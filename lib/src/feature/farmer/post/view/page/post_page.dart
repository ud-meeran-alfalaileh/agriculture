import 'package:agriculture/src/config/app_text.dart';
import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/farmer/post/view/page/add_post_page.dart';
import 'package:agriculture/src/feature/farmer/post/view/widget/post_widget.dart';
import 'package:agriculture/src/feature/login/model/user_model.dart';
import 'package:agriculture/src/feature/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final controller = Get.put(ProfileController());

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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: context.screenHeight * .02,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.pickImage(userData.id);
                              },
                              child: userData.imageUrl != null
                                  ? CircleAvatar(
                                      radius: 35,
                                      backgroundImage:
                                          NetworkImage(userData.imageUrl!))
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme
                                              .lightAppColors.background,
                                          shape: BoxShape.circle),
                                      child: Icon(Icons.person,
                                          size: 40,
                                          color: AppTheme
                                              .lightAppColors.background),
                                    ),
                            ),
                            SizedBox(
                              width: context.screenWidth * 0.05,
                            ),
                            thirdText("Welcome ${userData.name}.."),
                          ],
                        ),
                        Divider(
                          thickness: 2,
                          color: AppTheme.lightAppColors.primary,
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
