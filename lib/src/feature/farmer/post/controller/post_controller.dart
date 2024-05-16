import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/admin/nav_bar/admin_navbar_page.dart';
import 'package:agriculture/src/feature/exports/navbar/view/exports_navbar_page.dart';
import 'package:agriculture/src/feature/farmer/navbar_page/view/page/navbar_page.dart';
import 'package:agriculture/src/feature/farmer/post/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  final _db = FirebaseFirestore.instance;
  RxInt postLength = 0.obs;
  RxInt userPostLength = 0.obs;

  final description = TextEditingController();
  final formkey = GlobalKey<FormState>();

  Future<List<Map<String, dynamic>>> fetchAllPost() async {
    List<Map<String, dynamic>> post = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection('Post')
          .orderBy('Date',
              descending: true) // Order by datetime field in descending order
          .get();

      for (var doc in result.docs) {
        post.add(doc.data());
      }
      // ignore: empty_catches
    } catch (e) {}

    return post;
  }

  validName(String? address) {
    if (address!.isEmpty) {
      return "Post is not valid";
    }
    return null;
  }

  Future<void> addPost(PostModel post) async {
    await _db
        .collection("Post")
        .add(post.tojason())
        .whenComplete(() => Get.snackbar("Success", "Post Added Successfully",
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppTheme.lightAppColors.background,
            backgroundColor: Colors.green))
        .catchError((error) {
      Get.snackbar(error.toString(), "Something went wrong , try agin",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppTheme.lightAppColors.background,
          backgroundColor: Colors.red);
      throw error;
    });
    if (post.type == "User") {
      Get.to(const NavBarWidget());
    } else if (post.type == "exports") {
      Get.to(const ExportsNavBarWidget());
    } else if (post.type == "Admin") {
      Get.to(const AdminNavBarWidget());
    }
  }

  Future<Iterable<PostModel>> fetchUserPosts(String email) async {
    final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
        .instance
        .collection('Post')
        .where('Email', isEqualTo: email)
        .get();
    final post = result.docs.map((e) => PostModel.fromSnapshot(e));
    return post;
  }

  Future<void> removeUserPost(String itemId) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore.collection('Post').doc(itemId).delete();

      // ignore: empty_catches
    } catch (e) {}
  }
}
