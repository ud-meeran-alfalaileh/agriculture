import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/core/auth_repo/auth_repo.dart';
import 'package:agriculture/src/feature/farmer/navbar_page/view/page/navbar_page.dart';
import 'package:agriculture/src/feature/login/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  final name = TextEditingController();
  final _db = FirebaseFirestore.instance;

  final confirmPassword = TextEditingController();

  validEmail(String? email) {
    if (GetUtils.isEmail(email!)) {
      return null;
    }
    return "Email is not valid";
  }

  vaildPhoneNumber(String? phoneNumber) {
    if (GetUtils.isPhoneNumber(phoneNumber!) && phoneNumber.length >= 9) {
      return null;
    }
    return "Invalid Phone number";
  }

  vaildatePassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 6)) {
      return 'Password is not vaild';
    }
    return null;
  }

  validName(String? address) {
    if (address!.isEmpty) {
      return "Username is not valid";
    }
    return null;
  }

  vaildateConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return 'Confirm Password is required';
    } else if (value != password.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<bool> isUsernameTaken(String username) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('Users')
          .where('UserName', isEqualTo: username)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      Get.snackbar("Error", "Error checking username: $error",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppTheme.lightAppColors.background,
          backgroundColor: Colors.red);
      return false;
    }
  }

  Future<void> createUser(UserModel user) async {
    await _db
        .collection("Users")
        .add(user.tojason())
        .whenComplete(() => Get.snackbar(
            "Success", "Your account has been created",
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
  }

  Future<void> onSignup(UserModel user) async {
    try {
      bool usernameCheck = await isUsernameTaken(user.name);
      if (!usernameCheck) {
        Future<bool> code = AuthenticationRepository()
            .createUserWithEmailPassword(user.email, user.password);
        if (await code) {
          createUser(user);
          Get.snackbar("Success", " Account  Created Successfullly",
              snackPosition: SnackPosition.BOTTOM,
              colorText: AppTheme.lightAppColors.background,
              backgroundColor: Colors.green);
          Get.to(const NavBarWidget());
        } else {
          Get.snackbar("ERROR", "Invalid datas",
              snackPosition: SnackPosition.BOTTOM,
              colorText: AppTheme.lightAppColors.background,
              backgroundColor: Colors.red);
        }
      } else {
        Get.snackbar("ERROR", "Username  is taken",
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppTheme.lightAppColors.background,
            backgroundColor: Colors.red);
      }
    } catch (e) {
      print(e);
    }
  }
}
