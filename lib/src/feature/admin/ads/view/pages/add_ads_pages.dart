import 'package:agriculture/src/config/app_text.dart';
import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/admin/ads/controller/ads_controller.dart';
import 'package:agriculture/src/feature/admin/ads/model/ads_model.dart';
import 'package:agriculture/src/feature/login/view/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAdsPages extends StatelessWidget {
  const AddAdsPages({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdsController());
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    ),
                  )
                ],
              ),
              SizedBox(
                height: context.screenHeight * .1,
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  width: context.screenWidth,
                  height: context.screenHeight * .6,
                  decoration: BoxDecoration(
                    color: AppTheme.lightAppColors.background,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        headerText("Add The Daily News Image"),
                        SizedBox(
                          height: context.screenHeight * .05,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.pickImage();
                          },
                          child: Obx(
                            () => Stack(
                              children: [
                                Container(
                                  width: context.screenWidth,
                                  height: context.screenHeight * .3,
                                  decoration: BoxDecoration(
                                    color: AppTheme.lightAppColors.primary
                                        .withOpacity(.4),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: controller.image.value != null
                                      ? Image.network(controller.img.text)
                                      : Icon(
                                          Icons.image,
                                          color: AppTheme
                                              .lightAppColors.background,
                                          size: 80,
                                        ),
                                ),
                                if (controller.isLoading.value)
                                  Positioned.fill(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor:
                                            Colors.grey.withOpacity(.2),
                                        color: AppTheme.lightAppColors.primary,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: context.screenHeight * .05,
                        ),
                        appButton(context, "Add", () {
                          controller.addAds(AdsModel(
                              img: controller.img.text.trim(),
                              date: DateTime.now().toString()));
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
    );
  }
}
