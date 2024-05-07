import 'package:agriculture/src/feature/navbar_page/view/page/navbar_page.dart';
import 'package:agriculture/src/feature/profile/view/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();

  final _auth = FirebaseAuth.instance;
  emailValid(String email) {
    if (GetUtils.isEmail(email)) {
      return null;
    } else {
      return "Fill the Field";
    }
  }

  vaildPassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 6)) {
      return "'Invalid password'".tr;
    }
    return null;
  }

  Future<bool> login(String email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  Future onLogin() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      String userType = await _getUserType(userCredential.user!.email!);

      if (userType == 'Farmer') {
        Get.to(const NavBarWidget());
      } else if (userType == 'exports') {
        Get.to(const ProfilePage());
      } else {
        Get.snackbar("ERROR", "Email or Password is invild",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.red);
      }
    } on FirebaseAuthException {
      print(FirebaseAuthException);
      Get.snackbar("ERROR", "Email or Password is invild",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  Future<String> _getUserType(String email) async {
    QuerySnapshot userQuery = await FirebaseFirestore.instance
        .collection('Users')
        .where('Email', isEqualTo: email)
        .get();

    if (userQuery.docs.isNotEmpty) {
      return userQuery.docs.first['UserType'];
    }

    return '';
  }
}
