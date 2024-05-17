import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/farmer/crops/controller/crops_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FruitPage extends StatelessWidget {
  const FruitPage({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CropsController());

    return FutureBuilder(
      future: controller.fetchAllFruits(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if (snapshot.hasError) {
          return Container();
        } else {
          final item = snapshot.data!;
          if (item.isEmpty) {
            return Container();
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fruits",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      fontSize: 25,
                    )),
                  ),
                  SizedBox(
                    height: context.screenHeight * .25,
                    width: context.screenWidth,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final name = item[index]['title'].toString();

                        final img = item[index]['img'].toString();
                        final quantity = item[index]['quantity'].toString();
                        final price = item[index]['price'].toString();

                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: context.screenWidth * .5,
                          height: context.screenHeight * .25,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: context.screenWidth,
                                height: context.screenHeight * .15,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20)),
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
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      name,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                        fontSize: 20,
                                      )),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${quantity}KG",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        Text(
                                          "${price}JD",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppTheme
                                                      .lightAppColors.primary)),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: item.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: context.screenWidth * .02,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        }
      },
    );
  }
}
