import 'package:brothers_creative/features/blog/model/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BlogRepository extends GetxController {
  static BlogRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<String> addBolg(BlogModel blog) async {
    try {
      await _db.collection('Blog').add(blog.toJson());

      return 'added succesfully';
    } catch (e) {
      throw 'Some thing wrong while saving Blog';
    }
  }

  Future<List<BlogModel>> fetchBlog() async {
    // addBolg(BlogModel(
    //     '2',
    //     'second news',
    //     'مقالة 2',
    //     'manager Nour Hasibi',
    //     'المدير نور حسيبي',
    //     'Incididunt Eu consectetur irure qui amet est elit ex.Laborum mollit voluptate eiusmod non fugiat laboris aute elit deserunt proident officia ipsum irure mollit. pariatur minim dolor culpa.',
    //     'ابتىى صثهابىصت  iنص عربي عربي عربي تجربة نجربةنص عربي عربي عربي تجربة نجربةنص عربي عربي عربي تجربة نجربةنص عربي عربي عربي تجربة نجربةنص عربي عربي عربي تجربة نجربةنص عربي عربي عربي تجربة نجربة نصثىل',
    //     true,
    //     [
    //       'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/Users%2FImages%2FProfile%2Fscaled_1000414330.jpg?alt=media&token=18f991e9-f02d-4922-8deb-883885623893',
    //       'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/Users%2FImages%2FProfile%2Fscaled_1000414330.jpg?alt=media&token=18f991e9-f02d-4922-8deb-883885623893',
    //       'https://firebasestorage.googleapis.com/v0/b/brothers-creative.appspot.com/o/Users%2FImages%2FProfile%2Fscaled_1000414330.jpg?alt=media&token=18f991e9-f02d-4922-8deb-883885623893',
    //     ],
    //     DateTime.now()));
    try {
      final snapshot =
          await _db.collection("Blog").where('Active', isEqualTo: true).get();
      return snapshot.docs.map((e) => BlogModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw 'Something wrong while fetch Blog data';
    }
  }
}
