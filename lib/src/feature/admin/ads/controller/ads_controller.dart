import 'dart:io';

import 'package:agriculture/src/feature/admin/ads/model/ads_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdsController extends GetxController {
  final _db = FirebaseFirestore.instance;
  Rx<File?> image = Rx<File?>(null);
  final img = TextEditingController();
  RxBool isLoading = false.obs; // Track loading state

  void setImage(File? newImage) {
    image.value = newImage;
  }

  pickImage() async {
    isLoading.value = true; // Set loading to true when image picking starts

    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      isLoading.value = false; // Set loading to false if no image picked
      return;
    }

    // Generate a unique name for the image using timestamp and a unique identifier
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString() +
        '_' +
        UniqueKey().toString();

    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('ads')
        .child('$uniqueName.jpg'); // Append the unique name to the path
    await storageReference.putFile(File(file.path));

    String imageUrl = await storageReference.getDownloadURL();
    setImage(File(file.path));
    img.text = imageUrl;

    isLoading.value =
        false; // Set loading to false after image picked and processed
  }

  Future<void> addAds(AdsModel ads) async {
    isLoading.value = true; // Set loading to true when adding post starts

    await _db
        .collection("Ads")
        .add(ads.tojason())
        .whenComplete(() => Get.snackbar(
              "Success",
              "Post Added Successfully",
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.green,
            ))
        .catchError((error) {
      Get.snackbar(
        error.toString(),
        "Something went wrong , try again",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      throw error;
    });

    isLoading.value = false; // Set loading to false after post added
  }

  RxList adsList = [].obs;
  Future<List<Map<String, dynamic>>> fetchAllAds() async {
    List<Map<String, dynamic>> ads = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> result =
          await FirebaseFirestore.instance.collection('Ads').get();

      for (var doc in result.docs) {
        ads.add(doc.data());
        adsList.add(doc.data());
      }
      // ignore: empty_catches
    } catch (e) {}

    return ads;
  }
}
