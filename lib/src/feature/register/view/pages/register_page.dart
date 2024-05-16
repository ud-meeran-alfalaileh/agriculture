import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/core/auth_repo/user_repo.dart';
import 'package:agriculture/src/feature/login/model/login_form_model.dart';
import 'package:agriculture/src/feature/login/model/user_model.dart';
import 'package:agriculture/src/feature/login/view/page/login_page.dart';
import 'package:agriculture/src/feature/login/view/widget/login_form_widget.dart';
import 'package:agriculture/src/feature/register/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    final userRepo = Get.put(UserRepository());
    final formkey = GlobalKey<FormState>();

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
            child: Form(
              key: formkey,
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
                    FormWidget(
                        formModel: FormModel(
                            controller: controller.email,
                            enableText: false,
                            hintText: "Email",
                            invisible: false,
                            validator: (email) => controller.validEmail(email!),
                            type: TextInputType.emailAddress,
                            inputFormat: [],
                            onTap: null)),
                    SizedBox(
                      height: context.screenHeight * .03,
                    ),
                    FormWidget(
                        formModel: FormModel(
                            controller: controller.phone,
                            enableText: false,
                            hintText: "Phone Number",
                            invisible: false,
                            validator: (phone) =>
                                controller.vaildPhoneNumber(phone),
                            type: TextInputType.phone,
                            inputFormat: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onTap: null)),
                    SizedBox(
                      height: context.screenHeight * .03,
                    ),
                    FormWidget(
                        formModel: FormModel(
                            controller: controller.name,
                            enableText: false,
                            hintText: "Username",
                            invisible: false,
                            validator: (email) => controller.validName(email!),
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
                                controller.vaildatePassword(password),
                            type: TextInputType.emailAddress,
                            inputFormat: [],
                            onTap: null)),
                    SizedBox(
                      height: context.screenHeight * .03,
                    ),
                    FormWidget(
                        formModel: FormModel(
                            controller: controller.confirmPassword,
                            enableText: false,
                            hintText: "Confirm Password",
                            invisible: true,
                            validator: (password) =>
                                controller.vaildateConfirmPassword(password),
                            type: TextInputType.emailAddress,
                            inputFormat: [],
                            onTap: null)),
                    SizedBox(
                      height: context.screenHeight * .06,
                    ),
                    appButton(context, "REGISTER", () {
                      if (formkey.currentState!.validate()) {
                        controller.onSignup(UserModel(
                            name: controller.name.text.trim(),
                            email: controller.email.text.trim(),
                            password: controller.password.text.trim(),
                            userType: type,
                            imageUrl: '',
                            phone: controller.phone.text.trim()));
                        userRepo.getUserDetails(controller.email.text.trim());
                        //  UserController.instance.logIn();
                      }
                    }),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const LoginPage());
                      },
                      child: Text.rich(TextSpan(
                          text: "Already have an account?".tr,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Tajawal',
                              color: AppTheme.lightAppColors.primary,
                              fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                              text: " Login in ".tr,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.lightAppColors.primary
                                    .withOpacity(.4),
                                fontFamily: 'Tajawal',
                              ),
                            )
                          ])),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
