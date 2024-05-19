import 'package:agriculture/src/config/app_text.dart';
import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/admin/nav_bar/admin_navbar_page.dart';
import 'package:agriculture/src/feature/exports/navbar/view/exports_navbar_page.dart';
import 'package:agriculture/src/feature/farmer/navbar_page/view/page/navbar_page.dart';
import 'package:agriculture/src/feature/farmer/post/controller/post_controller.dart';
import 'package:agriculture/src/feature/farmer/post/model/post_model.dart';
import 'package:agriculture/src/feature/farmer/post/view/widget/add_post_form.dart';
import 'package:agriculture/src/feature/login/model/login_form_model.dart';
import 'package:agriculture/src/feature/login/model/user_model.dart';
import 'package:agriculture/src/feature/login/view/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPostPAge extends StatelessWidget {
  const AddPostPAge({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostController());
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: context.screenHeight * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppTheme.lightAppColors.background,
                      )),
                ],
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  width: context.screenWidth,
                  height: context.screenHeight * .8,
                  decoration: BoxDecoration(
                      color: AppTheme.lightAppColors.background,
                      borderRadius: BorderRadius.circular(20)),
                  child: Form(
                    key: controller.formkey,
                    child: Column(
                      children: [
                        headerText("Write Your Post"),
                        SizedBox(
                          height: context.screenHeight * .05,
                        ),
                        AddPostForm(
                          formModel: FormModel(
                              controller: controller.description,
                              enableText: false,
                              hintText: "Post..",
                              invisible: false,
                              validator: (name) => controller.validName(name),
                              type: TextInputType.name,
                              inputFormat: null,
                              onTap: null),
                        ),
                        SizedBox(
                          height: context.screenHeight * .05,
                        ),
                        appButton(context, "POST", () {
                          if (controller.formkey.currentState!.validate()) {
                            controller.addPost(PostModel(
                                name: user.name,
                                userId: user.id!,
                                img: user.imageUrl!,
                                description: controller.description.text,
                                date: DateTime.now().toString(),
                                type: user.userType,
                                email: user.email));
                            controller.description.clear();
                            if (user.userType == "Farmer") {
                              Get.to(NavBarWidget());
                            } else if (user.userType == "exports") {
                              Get.to(ExportsNavBarWidget());
                            } else {
                              Get.to(AdminNavBarWidget());
                            }
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
