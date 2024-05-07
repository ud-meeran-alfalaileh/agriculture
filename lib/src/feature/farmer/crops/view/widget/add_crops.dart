import 'package:agriculture/src/config/app_text.dart';
import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/farmer/crops/controller/crops_controller.dart';
import 'package:agriculture/src/feature/farmer/crops/model/crops_model.dart';
import 'package:agriculture/src/feature/login/model/login_form_model.dart';
import 'package:agriculture/src/feature/login/model/user_model.dart';
import 'package:agriculture/src/feature/login/view/page/login_page.dart';
import 'package:agriculture/src/feature/login/view/widget/login_form_widget.dart';
import 'package:agriculture/src/feature/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCrops extends StatelessWidget {
  const AddCrops({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    final profileController = Get.put(ProfileController());

    final controller = Get.put(CropsController());
    return SafeArea(
        child: Scaffold(
            body: FutureBuilder(
                future: profileController.getUserDataForFarmer(),
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.done) {
                    if (snapShot.hasData) {
                      UserModel userData = snapShot.data as UserModel;
                      return Container(
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Form(
                          key: formkey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios_new,
                                          color:
                                              AppTheme.lightAppColors.primary,
                                        ))
                                  ],
                                ),
                                headerText("Add Crops"),
                                Divider(
                                  thickness: 2,
                                  color: AppTheme.lightAppColors.primary,
                                ),
                                CropsTypeWidget(controller: controller),
                                SizedBox(
                                  height: context.screenHeight * .05,
                                ),
                                FormWidget(
                                    ontap: () {
                                      controller.pickImage();
                                    },
                                    formModel: FormModel(
                                        controller: controller.img,
                                        enableText: true,
                                        hintText: "Click to choose img",
                                        invisible: false,
                                        validator: null,
                                        type: TextInputType.name,
                                        inputFormat: [],
                                        onTap: () {})),
                                SizedBox(
                                  height: context.screenHeight * .05,
                                ),
                                FormWidget(
                                    formModel: FormModel(
                                        controller: controller.title,
                                        enableText: false,
                                        hintText: "Crop Name",
                                        invisible: false,
                                        validator: null,
                                        type: TextInputType.name,
                                        inputFormat: [],
                                        onTap: null)),
                                SizedBox(
                                  height: context.screenHeight * .05,
                                ),
                                FormWidget(
                                    formModel: FormModel(
                                        controller: controller.price,
                                        enableText: false,
                                        hintText: "Crop Price",
                                        invisible: false,
                                        validator: null,
                                        type: TextInputType.number,
                                        inputFormat: [],
                                        onTap: null)),
                                SizedBox(
                                  height: context.screenHeight * .05,
                                ),
                                FormWidget(
                                    formModel: FormModel(
                                        controller: controller.quantity,
                                        enableText: false,
                                        hintText: "Crop Quantity",
                                        invisible: false,
                                        validator: null,
                                        type: TextInputType.number,
                                        inputFormat: [],
                                        onTap: null)),
                                SizedBox(
                                  height: context.screenHeight * .05,
                                ),
                                FormWidget(
                                    formModel: FormModel(
                                        controller: controller.location,
                                        enableText: false,
                                        hintText: "Crop Location",
                                        invisible: false,
                                        validator: null,
                                        type: TextInputType.name,
                                        inputFormat: [],
                                        onTap: null)),
                                appButton(context, "title", () {
                                  controller.addCrops(Crops(
                                      title: controller.title.text.trim(),
                                      price: controller.price.text.trim(),
                                      location: controller.location.text.trim(),
                                      quantity: controller.quantity.text.trim(),
                                      userId: userData.id!,
                                      type: controller.cropsType.value,
                                      img: controller.img.text));
                                })
                              ],
                            ),
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
}

class CropsTypeWidget extends StatelessWidget {
  const CropsTypeWidget({
    super.key,
    required this.controller,
  });

  final CropsController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => GestureDetector(
            onTap: () {
              controller.isSelected.value = true;
              controller.setValue("Fruits");
              print(controller.cropsType.value);
            },
            child: Container(
              width: context.screenWidth * .41,
              height: context.screenHeight * .08,
              decoration: BoxDecoration(
                  color: controller.cropsType.value == "Fruits"
                      ? AppTheme.lightAppColors.primary
                      : AppTheme.lightAppColors.background,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.lightAppColors.primary)),
              child: Center(
                child: Text(
                  "Fruits",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: controller.cropsType.value == "Fruits"
                              ? AppTheme.lightAppColors.background
                              : AppTheme.lightAppColors.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 20)),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: context.screenWidth * .05,
        ),
        Obx(
          () => GestureDetector(
            onTap: () {
              controller.isSelected.value = true;
              controller.setValue("Vegetables");
            },
            child: Container(
              width: context.screenWidth * .41,
              height: context.screenHeight * .08,
              decoration: BoxDecoration(
                  color: controller.cropsType.value == "Vegetables"
                      ? AppTheme.lightAppColors.primary
                      : AppTheme.lightAppColors.background,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.lightAppColors.primary)),
              child: Center(
                child: Text(
                  "Vegetables",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: controller.cropsType.value == "Vegetables"
                              ? AppTheme.lightAppColors.background
                              : AppTheme.lightAppColors.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 20)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
