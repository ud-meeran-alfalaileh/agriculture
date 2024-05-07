import 'package:agriculture/src/config/app_text.dart';
import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/farmer/all_exports/controller/all_export_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllExportPage extends StatelessWidget {
  const AllExportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllExportsController());
    return SafeArea(
        child: Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            headerText("Exports"),
            Divider(
              thickness: 2,
              color: AppTheme.lightAppColors.primary,
            ),
            FutureBuilder(
                future: controller.fetchAllExports(),
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.done) {
                    if (snapShot.hasData) {
                      final post = snapShot.data!;

                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              height: context.screenHeight * .79,
                              width: context.screenWidth,
                              child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final name = post[index]['Name'].toString();
                                  final phone = post[index]['phone'].toString();
                                  final String img =
                                      post[index]['imageUrl'].toString();

                                  // final image = farm[index]['Image'];

                                  return GestureDetector(
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      height: context.screenHeight * .25,
                                      width: context.screenWidth,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 10,
                                            color: AppTheme
                                                .lightAppColors.background,
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          width: 2.0,
                                          color:
                                              AppTheme.lightAppColors.primary,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image:
                                                              NetworkImage(img),
                                                          fit: BoxFit.cover),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      border: Border.all(
                                                          color: AppTheme
                                                              .lightAppColors
                                                              .primary)),
                                                  child: img == ""
                                                      ? ColorFiltered(
                                                          colorFilter:
                                                              ColorFilter.mode(
                                                                  AppTheme
                                                                      .lightAppColors
                                                                      .primary,
                                                                  BlendMode
                                                                      .srcIn),
                                                          child: Image.asset(
                                                              "assets/images/Vector.png"),
                                                        )
                                                      : null,
                                                ),
                                                SizedBox(
                                                  width:
                                                      context.screenWidth * .03,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    headerText(name),
                                                  ],
                                                ),
                                                const Spacer(),
                                                IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .openWhatsAppChat(
                                                              phone);
                                                    },
                                                    icon: Icon(
                                                      Icons.message,
                                                      color: AppTheme
                                                          .lightAppColors
                                                          .primary,
                                                    ))
                                              ],
                                            ),
                                            Divider(
                                              color: AppTheme
                                                  .lightAppColors.primary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: post.length,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                              ),
                            ),
                          ],
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
                })
          ],
        ),
      ),
    ));
  }
}
