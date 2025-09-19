import 'package:brothers_creative/features/gallery/models/gallery_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class GallerySearchController extends GetxController {
  static GallerySearchController get instance => Get.find();

  final RxString searchQuery = ''.obs;
  final RxList<GalleryModel> searchResults = <GalleryModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasSearched = false.obs;

  // البحث في المعرض حسب النص المدخل
  Future<void> searchGallery(String query) async {
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
        print('Searching gallery for: "${query.trim()}"');
      }

      // جلب جميع صور المعرض أولاً ثم البحث محلياً
      final allGalleryItems = await _getAllGalleryItems();

      // البحث المحلي في الاسم والاسم العربي والوصف العربي
      final filteredGalleryItems =
          allGalleryItems.where((galleryItem) {
            final name = (galleryItem.name ?? '').toLowerCase();
            final arabicName = (galleryItem.arabicName ?? '').toLowerCase();
            final arabicDescription =
                (galleryItem.arabicDescription ?? '').toLowerCase();
            final searchTerm = query.trim().toLowerCase();

            // البحث في الكلمات الفردية
            final searchWords = searchTerm
                .split(' ')
                .where((word) => word.isNotEmpty);

            // البحث في الاسم الإنجليزي
            bool nameMatch = name.contains(searchTerm);
            // البحث في الاسم العربي
            bool arabicNameMatch = arabicName.contains(searchTerm);
            // البحث في الوصف العربي
            bool arabicDescriptionMatch = arabicDescription.contains(
              searchTerm,
            );

            // البحث في الكلمات الفردية
            bool wordMatch = searchWords.every(
              (word) =>
                  name.contains(word) ||
                  arabicName.contains(word) ||
                  arabicDescription.contains(word),
            );

            return nameMatch ||
                arabicNameMatch ||
                arabicDescriptionMatch ||
                wordMatch;
          }).toList();

      searchResults.assignAll(filteredGalleryItems);

      if (kDebugMode) {
        print('🔍 Gallery Search Summary:');
        print(
          '   - Total gallery items in database: ${allGalleryItems.length}',
        );
        print('   - Search query: "$query"');
        print('   - Search results found: ${searchResults.length}');
        if (searchResults.isNotEmpty) {
          print('   - Found gallery items:');
          for (final item in searchResults) {
            print(
              '     • ${item.name ?? 'No name'} (${item.arabicName ?? 'No Arabic name'})',
            );
          }
        } else {
          print('   - No gallery items found matching the search criteria');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Gallery search error: $e');
      }
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }

  // جلب جميع صور المعرض
  Future<List<GalleryModel>> _getAllGalleryItems() async {
    try {
      if (kDebugMode) {
        print('Fetching all gallery items from Firestore...');
      }

      final snapshot =
          await FirebaseFirestore.instance.collection('Gallery').get();

      if (kDebugMode) {
        print('Firestore returned ${snapshot.docs.length} gallery documents');
      }

      final galleryItems =
          snapshot.docs
              .map((doc) {
                try {
                  return GalleryModel.fromSnapshot(doc);
                } catch (e) {
                  if (kDebugMode) {
                    print('Error parsing gallery document ${doc.id}: $e');
                    print('Document data: ${doc.data()}');
                  }
                  return null;
                }
              })
              .where((item) => item != null)
              .cast<GalleryModel>()
              .toList();

      if (kDebugMode) {
        print('Successfully parsed ${galleryItems.length} gallery items');
        if (galleryItems.isNotEmpty) {
          print(
            'Sample gallery item: ${galleryItems.first.name ?? 'No name'} (${galleryItems.first.arabicName ?? 'No Arabic name'})',
          );
        }
      }

      return galleryItems;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching all gallery items: $e');
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

  // اختبار وجود صور في قاعدة البيانات
  Future<void> testGalleryItemsExist() async {
    if (kDebugMode) {
      print('🧪 Testing if gallery items exist in database...');
    }

    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('Gallery').limit(5).get();

      if (kDebugMode) {
        print('📊 Gallery collection test:');
        print('   - Collection exists: ${snapshot.metadata.hasPendingWrites}');
        print('   - Documents found: ${snapshot.docs.length}');
        if (snapshot.docs.isNotEmpty) {
          print('   - Sample documents:');
          for (int i = 0; i < snapshot.docs.length; i++) {
            final doc = snapshot.docs[i];
            final data = doc.data();
            print('     ${i + 1}. Document ID: ${doc.id}');
            print('        - Name: ${data['Name'] ?? 'N/A'}');
            print('        - ArabicName: ${data['ArabicName'] ?? 'N/A'}');
            print(
              '        - ArabicDescription: ${data['ArabicDescription'] ?? 'N/A'}',
            );
            print('        - Available fields: ${data.keys.toList()}');
          }
        } else {
          print('   - ⚠️ No gallery items found in database!');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('💥 Error testing gallery collection: $e');
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
      searchGallery(query);
    } else {
      // مسح النتائج إذا كان النص قصير جداً
      searchResults.clear();
      hasSearched.value = false;
    }
  }

  // دالة مساعدة لاختبار البحث
  Future<void> testSearch(String testQuery) async {
    if (kDebugMode) {
      print('🧪 Testing gallery search with query: "$testQuery"');
    }

    await searchGallery(testQuery);

    if (kDebugMode) {
      print('🧪 Test gallery search completed');
      print('   - Query: "$testQuery"');
      print('   - Results count: ${searchResults.length}');
    }
  }
}
