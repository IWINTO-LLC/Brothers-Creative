import 'package:brothers_creative/data/repositoies/blog/blog_repository.dart';
import 'package:brothers_creative/features/blog/model/blog_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class BlogController extends GetxController {
  static BlogController get instance => Get.find();
  final isLoading = false.obs;
  final RxList<BlogModel> blogs = <BlogModel>[].obs;

  @override
  void onInit() {
    fetchBlogs();
    super.onInit();
  }

  Future<List<BlogModel>> fetchUserblogs() async {
    try {
      final snapshot = await BlogRepository.instance.fetchBlog();

      return snapshot;
    } catch (e) {
      throw 'Something wrong while fetch Project data';
    }
  }

  Future<void> fetchBlogs() async {
    try {
      isLoading.value = true;
      final blogRepo = Get.put(BlogRepository());
      final blogs = await blogRepo.fetchBlog();
      this.blogs.assignAll(blogs);
      if (kDebugMode) {
        print('============ blogs length==========$blogs.length');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      } // Get.snackbar('oh Snap!', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
