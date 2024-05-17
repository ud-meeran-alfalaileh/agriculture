import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/exports/crops/controller/export_crops_controller.dart';
import 'package:agriculture/src/feature/farmer/all_exports/controller/all_export_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ExportCropspage extends StatelessWidget {
  const ExportCropspage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExportsCropController());
    final ccontroller = Get.put(AllExportsController());

    return FutureBuilder(
        future: controller.fetchAllCrops(),
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
                  "No Product",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 25,
                          color: AppTheme.lightAppColors.primary)),
                ),
              );
            } else {
              return Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "All Product",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          fontSize: 25,
                        )),
                      ),
                      SizedBox(
                        height: context.screenHeight * .05,
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        height: context.screenHeight,
                        width: context.screenWidth,
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final name = item[index]['title'].toString();
                            final String img = item[index]['img'].toString();
                            final phone = item[index]['phone'].toString();

                            final quantity = item[index]['quantity'].toString();
                            final price = item[index]['price'].toString();

                            return Container(
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
                                      borderRadius:
                                          const BorderRadius.horizontal(
                                              left: Radius.circular(20)),
                                      image: DecorationImage(
                                          image: NetworkImage(img),
                                          alignment: Alignment.topCenter,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(
                                    width: context.screenWidth * .05,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${price}JD",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: AppTheme
                                                    .lightAppColors.primary)),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            ccontroller.openWhatsAppChat(phone);
                                          },
                                          icon: Icon(
                                            Icons.message,
                                            color:
                                                AppTheme.lightAppColors.primary,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            );
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
                  ),
                ),
              );
            }
          }
        });
  }
}
