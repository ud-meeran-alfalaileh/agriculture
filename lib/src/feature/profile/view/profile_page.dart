import 'package:agriculture/src/config/app_text.dart';
import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/login/controller/user_controller.dart';
import 'package:agriculture/src/feature/login/model/user_model.dart';
import 'package:agriculture/src/feature/login/view/page/login_page.dart';
import 'package:agriculture/src/feature/profile/controller/profile_controller.dart';
import 'package:agriculture/src/feature/profile/view/user_posts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final auth = FirebaseAuth.instance;

    return SafeArea(
        child: Scaffold(
            body: FutureBuilder(
                future: controller.getUserDataForFarmer(),
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.done) {
                    if (snapShot.hasData) {
                      UserModel userData = snapShot.data as UserModel;

                      return Container(
                        margin: const EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Profile",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          AppTheme.lightAppColors.mainTextcolor,
                                    )),
                                  ),
                                  SizedBox(
                                    width: context.screenWidth * .3,
                                  ),
                                  GestureDetector(
                                      onTap: () async {
                                        await auth.signOut();

                                        Get.offAll(const LoginPage());
                                      },
                                      child: Icon(
                                        Icons.logout,
                                        color: AppTheme.lightAppColors.primary,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: context.screenHeight * .02,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.pickImage(userData.id);
                                  },
                                  child: userData.imageUrl != null
                                      ? CircleAvatar(
                                          radius: 80,
                                          backgroundImage:
                                              NetworkImage(userData.imageUrl!))
                                      : Container(
                                          decoration: BoxDecoration(
                                              color: AppTheme
                                                  .lightAppColors.background,
                                              shape: BoxShape.circle),
                                          child: Icon(Icons.person,
                                              size: 40,
                                              color: AppTheme
                                                  .lightAppColors.background),
                                        ),
                                ),
                              ),
                              Text(UserController.instance.farmName.value),
                              Divider(
                                thickness: 2,
                                color: AppTheme.lightAppColors.primary,
                              ),
                              headerText("Name: ${userData.name}"),
                              SizedBox(
                                height: context.screenHeight * .01,
                              ),
                              headerText("Email: ${userData.email}"),
                              SizedBox(
                                height: context.screenHeight * .01,
                              ),
                              headerText("My Posts:"),
                              UserPosts(email: userData.email)
                            ],
                          ),
                        ),
                      );
                    } else if (snapShot.hasError) {
                      return Center(child: Text('Error${snapShot.error}'));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  } else if (snapShot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })));
  }

  String discriptionShortenText(String text, {int maxLength = 250}) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }
}
