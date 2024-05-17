import 'dart:io';

import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/farmer/crops/model/crops_model.dart';
import 'package:agriculture/src/feature/farmer/navbar_page/view/page/navbar_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CropsController extends GetxController {
  RxBool isSelected = false.obs;
  RxString cropsType = "".obs;
  final title = TextEditingController();
  final price = TextEditingController();
  final quantity = TextEditingController();
  final location = TextEditingController();
  final img = TextEditingController();
  final _db = FirebaseFirestore.instance;
  Rx<File?> image = Rx<File?>(null);

  setValue(value) {
    cropsType.value = value;
  }

  validName(String? name) {
    if (name!.isEmpty) {
      return "Field is not valid";
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> fetchAllCrops(String userId) async {
    List<Map<String, dynamic>> crops = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection('Crops')
          .where('userId', isEqualTo: userId)
          .get();

      for (var doc in result.docs) {
        crops.add(doc.data());
      }
    } catch (e) {
      print("Error fetching crops: $e");
    }

    return crops;
  }

  Future<List<Map<String, dynamic>>> fetchAllFruits(String userId) async {
    List<Map<String, dynamic>> fruits = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection('Crops')
          .where('userId', isEqualTo: userId)
          .get();

      for (var doc in result.docs) {
        Map<String, dynamic> data = doc.data();
        // Check if the crop type is "fruit"
        if (data['type'] == 'Fruits') {
          fruits.add(data);
        }
      }
    } catch (e) {
      print("Error fetching fruits: $e");
    }

    return fruits;
  }

  Future<List<Map<String, dynamic>>> fetchAllVegetables(String userId) async {
    List<Map<String, dynamic>> vegetables = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection('Crops')
          .where('userId', isEqualTo: userId)
          .get();

      for (var doc in result.docs) {
        Map<String, dynamic> data = doc.data();
        // Check if the crop type is "vegetable"
        if (data['type'] == 'Vegetables') {
          vegetables.add(data);
        }
      }
    } catch (e) {
      print("Error fetching vegetables: $e");
    }

    return vegetables;
  }

  Future<void> addCrops(Crops crops) async {
    await _db
        .collection("Crops")
        .add(crops.toJason())
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
    Get.to(const NavBarWidget());
  }

  void setImage(File? newImage) {
    image.value = newImage;
  }

  pickImage() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }
    String uniqueName =
        '${DateTime.now().millisecondsSinceEpoch}_${UniqueKey()}';

    Reference storageReference =
        FirebaseStorage.instance.ref().child('images').child('$uniqueName.jpg');
    await storageReference.putFile(File(file.path));

    String imageUrl = await storageReference.getDownloadURL();
    setImage(File(file.path));

    img.text = imageUrl;
  }
}
