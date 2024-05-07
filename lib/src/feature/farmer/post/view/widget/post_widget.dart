import 'package:agriculture/src/config/app_text.dart';
import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/farmer/post/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostController());

    return FutureBuilder(
      future: controller.fetchAllPost(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if (snapshot.hasError) {
          return Container();
        } else {
          final post = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: context.screenHeight * .75,
                  width: context.screenWidth,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final name = post[index]['Name'].toString();
                      final String img = post[index]['img'].toString();
                      final description = post[index]['Description'].toString();
                      final type = post[index]['type'].toString();

                      // final image = farm[index]['Image'];

                      return GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.only(top: 10),
                          height: context.screenHeight * .45,
                          width: context.screenWidth,
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(img),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: AppTheme
                                                  .lightAppColors.primary)),
                                      child: img == ""
                                          ? ColorFiltered(
                                              colorFilter: ColorFilter.mode(
                                                  AppTheme
                                                      .lightAppColors.primary,
                                                  BlendMode.srcIn),
                                              child: Image.asset(
                                                  "assets/images/Vector.png"),
                                            )
                                          : null,
                                    ),
                                    SizedBox(
                                      width: context.screenWidth * .03,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        headerText(name),
                                        secText(type),
                                      ],
                                    )
                                  ],
                                ),
                                Divider(
                                  color: AppTheme.lightAppColors.primary,
                                ),
                                Text(
                                  discriptionShortenText(description),
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          color: AppTheme
                                              .lightAppColors.mainTextcolor)),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: post.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  String discriptionShortenText(String text, {int maxLength = 250}) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }
}
