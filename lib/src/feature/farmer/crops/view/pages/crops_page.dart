import 'package:agriculture/src/config/app_text.dart';
import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/farmer/crops/controller/crops_controller.dart';
import 'package:agriculture/src/feature/farmer/crops/view/pages/crops_fruit.dart';
import 'package:agriculture/src/feature/farmer/crops/view/pages/crops_vegetables.dart';
import 'package:agriculture/src/feature/farmer/crops/view/widget/add_crops.dart';
import 'package:agriculture/src/feature/login/model/user_model.dart';
import 'package:agriculture/src/feature/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CropsPage extends StatelessWidget {
  const CropsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());

    return SafeArea(
      child: Scaffold(
        floatingActionButton: GestureDetector(
          onTap: () {
            Get.to(const AddCrops());
          },
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                color: AppTheme.lightAppColors.primary,
                borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Icon(
                Icons.add,
                size: 40,
                color: AppTheme.lightAppColors.background,
              ),
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                headerText("Crops"),
                Divider(
                  thickness: 2,
                  color: AppTheme.lightAppColors.primary,
                ),
                FutureBuilder(
                  future: profileController.getUserDataForFarmer(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if (snapshot.hasError) {
                      return Container();
                    } else {
                      UserModel userData = snapshot.data as UserModel;
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FruitPage(
                              id: userData.id!,
                            ),
                            VegetablesPage(
                              id: userData.id!,
                            ),
                            allItemContainer(context, userData.id!)
                          ],
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

allItemContainer(BuildContext context, String id) {
  final controller = Get.put(CropsController());

  return FutureBuilder(
      future: controller.fetchAllCrops(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if (snapshot.hasError) {
          return Container();
        } else {
          final item = snapshot.data!;
          if (item.isEmpty) {
            return Center(
              child: Text(
                "Add New Product",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 25, color: AppTheme.lightAppColors.primary)),
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "All Product",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                    fontSize: 25,
                  )),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  height: context.screenHeight * .79,
                  width: context.screenWidth,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final name = item[index]['title'].toString();
                      final String img = item[index]['img'].toString();

                      final quantity = item[index]['quantity'].toString();
                      final price = item[index]['price'].toString();
                      // final image = farm[index]['Image'];

                      return GestureDetector(
                          child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(right: 10),
                        width: context.screenWidth,
                        height: context.screenHeight * .1,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: AppTheme.lightAppColors.background,
                            )
                          ],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 2.0,
                            color: AppTheme.lightAppColors.primary,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: context.screenWidth * .2,
                              height: context.screenHeight,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(20)),
                                image: DecorationImage(
                                    image: NetworkImage(img),
                                    alignment: Alignment
                                        .topCenter, // Adjust alignment here

                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(
                              width: context.screenWidth * .05,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                    fontSize: 20,
                                  )),
                                ),
                                Text(
                                  "${quantity}KG",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                )
                              ],
                            ),
                            const Spacer(),
                            Text(
                              "${price}JD",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.lightAppColors.primary)),
                            )
                          ],
                        ),
                      ));
                    },
                    shrinkWrap: true,
                    itemCount: item.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: context.screenHeight * .02,
                      );
                    },
                  ),
                ),
              ],
            );
          }
        }
      });
}
