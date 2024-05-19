import 'package:agriculture/src/config/app_text.dart';
import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/admin/ads/view/pages/user_ads.dart';
import 'package:agriculture/src/feature/farmer/post/controller/post_controller.dart';
import 'package:agriculture/src/feature/farmer/post/view/page/add_post_page.dart';
import 'package:agriculture/src/feature/farmer/post/view/widget/post_widget.dart';
import 'package:agriculture/src/feature/login/model/user_model.dart';
import 'package:agriculture/src/feature/profile/controller/profile_controller.dart';
import 'package:agriculture/src/feature/weather/view/weather_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final controller = Get.put(ProfileController());
  final postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.getUserDataForFarmer(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            if (snapShot.hasData) {
              UserModel userData = snapShot.data as UserModel;

              return Scaffold(
                floatingActionButton: GestureDetector(
                  onTap: () {
                    Get.to(AddPostPAge(
                      user: UserModel(
                          id: userData.id,
                          name: userData.name,
                          email: userData.email,
                          password: userData.password,
                          imageUrl: userData.imageUrl,
                          userType: userData.userType,
                          phone: userData.phone),
                    ));
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
                  height: 700,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: context.screenHeight * .02,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              child: userData.imageUrl != userData.imageUrl!
                                  ? Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  userData.imageUrl!))),
                                    )
                                  : Container(
                                      width: 1,
                                    ),
                            ),
                            SizedBox(
                              width: context.screenWidth * 0.05,
                            ),
                            thirdText("Welcome ${userData.name}.."),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  Get.to(WeatherWidget());
                                },
                                icon: Icon(
                                  Icons.sunny,
                                  color: AppTheme.lightAppColors.primary,
                                )),
                          ],
                        ),
                        Divider(
                          thickness: 2,
                          color: AppTheme.lightAppColors.primary,
                        ),
                        SizedBox(
                          height: context.screenHeight * .02,
                        ),
                        AdsWidget(),
                        SizedBox(
                          height: context.screenHeight * .02,
                        ),
                        const PostWidget()
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
          } else if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
