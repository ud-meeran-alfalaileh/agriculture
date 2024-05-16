import 'package:agriculture/src/config/app_text.dart';
import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/admin/ads/controller/ads_controller.dart';
import 'package:agriculture/src/feature/admin/ads/view/pages/add_ads_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../login/view/page/login_page.dart';

class AllAdsPage extends StatelessWidget {
  const AllAdsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdsController());
    final auth = FirebaseAuth.instance;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: GestureDetector(
          onTap: () {
            Get.to(const AddAdsPages());
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
          margin: const EdgeInsets.all(10),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: controller.fetchAllAds(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final ads = snapshot.data ?? [];
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          headerText("Ads"),
                          SizedBox(
                            width: context.screenWidth * .35,
                          ),
                          GestureDetector(
                              onTap: () async {
                                await auth.signOut();

                                Get.offAll(() => const LoginPage());
                              },
                              child: Icon(
                                Icons.logout,
                                color: AppTheme.lightAppColors.primary,
                              )),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                        color: AppTheme.lightAppColors.primary,
                      ),
                      Container(
                          margin: EdgeInsets.all(10),
                          height: context.screenHeight,
                          width: context.screenWidth,
                          child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final img = ads[index]['img'].toString();
                                final date = ads[index]['Date'].toString();

                                return Container(
                                  width: context.screenWidth,
                                  height: context.screenWidth * .5,
                                  child: Column(
                                    children: [
                                      Text("Date of the Ads $date"),
                                      SizedBox(
                                        height: context.screenWidth * .4,
                                        child: Image.network(
                                          img,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: context.screenHeight * .01,
                                );
                              },
                              itemCount: ads.length)),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
