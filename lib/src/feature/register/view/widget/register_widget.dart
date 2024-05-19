import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/core/auth_repo/user_repo.dart';
import 'package:agriculture/src/feature/register/controller/register_controller.dart';
import 'package:agriculture/src/feature/register/view/pages/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    final userRepo = Get.put(UserRepository());

    return SafeArea(
        child: Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppTheme.lightAppColors.primary.withOpacity(.3),
              AppTheme.lightAppColors.primary,
              AppTheme.lightAppColors.primary.withOpacity(.3),
              AppTheme.lightAppColors.primary,
            ],
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            width: context.screenWidth,
            height: context.screenHeight * .85,
            decoration: BoxDecoration(
                color: AppTheme.lightAppColors.background,
                borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("CREATE NEW ACCOUNT",
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 25))),
                  SizedBox(
                    height: context.screenHeight * .08,
                  ),
                  //export
                  GestureDetector(
                    onTap: () {
                      Get.to(RegisterPage(type: "exports"));
                    },
                    child: Container(
                      width: context.screenWidth,
                      height: context.screenHeight * .25,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.lightAppColors.primary,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.building_2_fill,
                            color: AppTheme.lightAppColors.primary,
                            size: 150,
                          ),
                          Text(
                            "Exports",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: AppTheme.lightAppColors.primary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.screenHeight * .055,
                  ),
                  //frmer
                  GestureDetector(
                    onTap: () {
                      Get.to(RegisterPage(type: "Farmer"));
                    },
                    child: Container(
                      width: context.screenWidth,
                      height: context.screenHeight * .25,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.lightAppColors.primary,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.person,
                            color: AppTheme.lightAppColors.primary,
                            size: 150,
                          ),
                          Text(
                            "Farmer",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: AppTheme.lightAppColors.primary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
