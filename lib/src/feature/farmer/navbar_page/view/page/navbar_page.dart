import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/core/auth_repo/auth_repo.dart';
import 'package:agriculture/src/feature/farmer/all_exports/view/page/all_exports_page.dart';
import 'package:agriculture/src/feature/farmer/crops/view/pages/crops_widget.dart';
import 'package:agriculture/src/feature/farmer/post/view/page/post_page.dart';
import 'package:agriculture/src/feature/profile/view/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({super.key});

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  final _authRepo = Get.put(AuthenticationRepository());
  late final email = _authRepo.firebaseUser.value?.email;

  final List<Widget> widgetList = const [
    PostPage(),
    CropsPage(),
    AllExportPage(),
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
                    icon: const Icon(
                      CupertinoIcons.add_circled_solid,
                    ),
                    backgroundColor: AppTheme.lightAppColors.primary,
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(
                      CupertinoIcons.building_2_fill,
                    ),
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
