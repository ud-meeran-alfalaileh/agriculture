import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/core/auth_repo/user_repo.dart';
import 'package:agriculture/src/feature/login/controller/login_controller.dart';
import 'package:agriculture/src/feature/login/model/login_form_model.dart';
import 'package:agriculture/src/feature/login/view/widget/login_form_widget.dart';
import 'package:agriculture/src/feature/register/view/widget/register_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
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
            height: context.screenHeight * .6,
            decoration: BoxDecoration(
                color: AppTheme.lightAppColors.background,
                borderRadius: BorderRadius.circular(20)),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Text("LOGIN",
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 25))),
                  SizedBox(
                    height: context.screenHeight * .08,
                  ),
                  FormWidget(
                      formModel: FormModel(
                          controller: controller.email,
                          enableText: false,
                          hintText: "Email",
                          invisible: false,
                          validator: (email) => controller.emailValid(email!),
                          type: TextInputType.emailAddress,
                          inputFormat: [],
                          onTap: null)),
                  SizedBox(
                    height: context.screenHeight * .03,
                  ),
                  FormWidget(
                      formModel: FormModel(
                          controller: controller.password,
                          enableText: false,
                          hintText: "Password",
                          invisible: true,
                          validator: (password) =>
                              controller.vaildPassword(password),
                          type: TextInputType.emailAddress,
                          inputFormat: [],
                          onTap: null)),
                  SizedBox(
                    height: context.screenHeight * .07,
                  ),
                  appButton(context, "LOGIN", () {
                    if (formkey.currentState!.validate()) {
                      /////login button
                      controller.onLogin();
                      userRepo.getUserDetails(controller.email.text.trim());
                      //  UserController.instance.logIn();
                    }
                  }),
                  GestureDetector(
                    onTap: () {
                      Get.to(const RegisterWidget());
                    },
                    child: Text.rich(TextSpan(
                        text: "don’t have account?".tr,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 12,
                              color: AppTheme.lightAppColors.primary,
                              fontWeight: FontWeight.w500),
                        ),
                        children: [
                          TextSpan(
                              text: " Create one ".tr,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.lightAppColors.primary
                                      .withOpacity(.4),
                                ),
                              ))
                        ])),
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

GestureDetector appButton(BuildContext context, title, onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: context.screenWidth * .8,
      height: context.screenHeight * .08,
      decoration: BoxDecoration(
          color: AppTheme.lightAppColors.primary,
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.lightAppColors.background)),
        ),
      ),
    ),
  );
}
