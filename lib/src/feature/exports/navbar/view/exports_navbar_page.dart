import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/core/auth_repo/auth_repo.dart';
import 'package:agriculture/src/feature/exports/crops/view/page/export_crops_page.dart';
import 'package:agriculture/src/feature/farmer/post/view/page/post_page.dart';
import 'package:agriculture/src/feature/profile/view/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExportsNavBarWidget extends StatefulWidget {
  const ExportsNavBarWidget({super.key});

  @override
  State<ExportsNavBarWidget> createState() => _ExportsNavBarWidgetState();
}

class _ExportsNavBarWidgetState extends State<ExportsNavBarWidget> {
  final _authRepo = Get.put(AuthenticationRepository());
  late final email = _authRepo.firebaseUser.value?.email;

  final List<Widget> widgetList = const [
    PostPage(),
    ExportCropspage(),
    ProfilePage(),
  ];

  RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(() => Scaffold(
            body: Center(
              child: widgetList[selectedIndex.value],
            ),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: AppTheme.lightAppColors.primary,
                selectedItemColor: AppTheme.lightAppColors.background,
                unselectedItemColor: AppTheme.lightAppColors.background,
                onTap: (value) {
                  selectedIndex.value = value;
                },
                currentIndex: selectedIndex.value,
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(
                      Icons.home_outlined,
                    ),
                    label: "",
                    backgroundColor: AppTheme.lightAppColors.primary,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(CupertinoIcons.tree),
                    backgroundColor: AppTheme.lightAppColors.primary,
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: AppTheme.lightAppColors.primary,
                    icon: const Icon(
                      Icons.person_2_outlined,
                    ),
                    label: "",
                  ),
                ]))));
  }
}
