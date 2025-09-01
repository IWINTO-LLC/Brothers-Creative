import 'package:brothers_creative/data/repositoies/product/product_repository.dart';
import 'package:brothers_creative/features/shop/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  static SearchController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString searchQuery = ''.obs;
  final RxList<ProductModel> searchResults = <ProductModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasSearched = false.obs;

  // البحث في المنتجات حسب النص المدخل
  Future<void> searchProducts(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      hasSearched.value = false;
      return;
    }

    // تحديث الاستعلام الحالي
    searchQuery.value = query.trim();
    
    // إذا كان النص قصير جداً، انتظر قليلاً
    if (query.trim().length < 2) {
      searchResults.clear();
      hasSearched.value = false;
      return;
    }

    isLoading.value = true;
    hasSearched.value = true;

    try {
      if (kDebugMode) {
        print('Searching for: "${query.trim()}"');
      }

      // جلب جميع المنتجات أولاً ثم البحث محلياً (أكثر فعالية للبحث)
      final allProducts = await _getAllProducts();

      // البحث المحلي في العناوين والوصف مع دعم البحث المتقدم
      final filteredProducts = allProducts.where((product) {
        final title = product.title.toLowerCase();
        final arabicTitle = product.arabicTitle.toLowerCase();
        final description = (product.description ?? '').toLowerCase();
        final arabicDescription = (product.arabicDescription ?? '').toLowerCase();
        final searchTerm = query.trim().toLowerCase();
        
        // البحث في الكلمات الفردية
        final searchWords = searchTerm.split(' ').where((word) => word.isNotEmpty);
        
        // البحث في العنوان الإنجليزي
        bool titleMatch = title.contains(searchTerm);
        // البحث في العنوان العربي
        bool arabicTitleMatch = arabicTitle.contains(searchTerm);
        // البحث في الوصف الإنجليزي
        bool descriptionMatch = description.contains(searchTerm);
        // البحث في الوصف العربي
        bool arabicDescriptionMatch = arabicDescription.contains(searchTerm);
        
        // البحث في الكلمات الفردية
        bool wordMatch = searchWords.every((word) =>
            title.contains(word) ||
            arabicTitle.contains(word) ||
            description.contains(word) ||
            arabicDescription.contains(word));
        
        return titleMatch ||
            arabicTitleMatch ||
            descriptionMatch ||
            arabicDescriptionMatch ||
            wordMatch;
      }).toList();

      searchResults.assignAll(filteredProducts);

      if (kDebugMode) {
        print('🔍 Search Summary:');
        print('   - Total products in database: ${allProducts.length}');
        print('   - Search query: "$query"');
        print('   - Search results found: ${searchResults.length}');
        if (searchResults.isNotEmpty) {
          print('   - Found products:');
          for (final product in searchResults) {
            print('     • ${product.title} (${product.arabicTitle})');
          }
        } else {
          print('   - No products found matching the search criteria');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Search error: $e');
      }
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }

  // جلب جميع المنتجات
  Future<List<ProductModel>> _getAllProducts() async {
    try {
      if (kDebugMode) {
        print('Fetching all products from Firestore...');
      }

      final snapshot =
          await FirebaseFirestore.instance.collection('Products').get();

      if (kDebugMode) {
        print('Firestore returned ${snapshot.docs.length} documents');
      }

      final products =
          snapshot.docs
              .map((doc) {
                try {
                  return ProductModel.fromSnapshot(doc);
                } catch (e) {
                  if (kDebugMode) {
                    print('Error parsing document ${doc.id}: $e');
                    print('Document data: ${doc.data()}');
                  }
                  return null;
                }
              })
              .where((product) => product != null)
              .cast<ProductModel>()
              .toList();

      if (kDebugMode) {
        print('Successfully parsed ${products.length} products');
        if (products.isNotEmpty) {
          print(
            'Sample product: ${products.first.title} (${products.first.arabicTitle})',
          );
        }
      }

      return products;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching all products: $e');
      }
      return [];
    }
  }

  // مسح نتائج البحث
  void clearSearch() {
    searchQuery.value = '';
    searchResults.clear();
    hasSearched.value = false;
  }

  // اختبار وجود منتجات في قاعدة البيانات
  Future<void> testProductsExist() async {
    if (kDebugMode) {
      print('🧪 Testing if products exist in database...');
    }

    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('Products')
              .limit(5)
              .get();

      if (kDebugMode) {
        print('📊 Products collection test:');
        print('   - Collection exists: ${snapshot.metadata.hasPendingWrites}');
        print('   - Documents found: ${snapshot.docs.length}');
        if (snapshot.docs.isNotEmpty) {
          print('   - Sample documents:');
          for (int i = 0; i < snapshot.docs.length; i++) {
            final doc = snapshot.docs[i];
            final data = doc.data();
            print('     ${i + 1}. Document ID: ${doc.id}');
            print('        - Title: ${data['Title'] ?? 'N/A'}');
            print('        - ArabicTitle: ${data['ArabicTitle'] ?? 'N/A'}');
            print('        - Description: ${data['Description'] ?? 'N/A'}');
            print('        - ArabicDescription: ${data['ArabicDescription'] ?? 'N/A'}');
            print('        - Available fields: ${data.keys.toList()}');
          }
        } else {
          print('   - ⚠️ No products found in database!');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('💥 Error testing products collection: $e');
      }
    }
  }

  // البحث الفوري (بدون تأخير)
  void searchOnChanged(String query) {
    if (query.trim().isEmpty) {
      clearSearch();
      return;
    }

    // البحث فوري عند الكتابة
    // إذا كان النص قصير جداً، لا تبحث
    if (query.trim().length >= 2) {
      searchProducts(query);
    } else {
      // مسح النتائج إذا كان النص قصير جداً
      searchResults.clear();
      hasSearched.value = false;
    }
  }

  // دالة مساعدة لاختبار البحث
  Future<void> testSearch(String testQuery) async {
    if (kDebugMode) {
      print('🧪 Testing search with query: "$testQuery"');
    }
    
    await searchProducts(testQuery);
    
    if (kDebugMode) {
      print('🧪 Test search completed');
      print('   - Query: "$testQuery"');
      print('   - Results count: ${searchResults.length}');
    }
  }
}
