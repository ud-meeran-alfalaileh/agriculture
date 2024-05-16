import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/core/auth_repo/auth_repo.dart';
import 'package:agriculture/src/feature/admin/ads/view/all_ads_page.dart';
import 'package:agriculture/src/feature/farmer/post/view/page/post_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminNavBarWidget extends StatefulWidget {
  const AdminNavBarWidget({super.key});

  @override
  State<AdminNavBarWidget> createState() => _AdminNavBarWidgetState();
}

class _AdminNavBarWidgetState extends State<AdminNavBarWidget> {
  final _authRepo = Get.put(AuthenticationRepository());
  late final email = _authRepo.firebaseUser.value?.email;

  final List<Widget> widgetList = const [PostPage(), AllAdsPage()];

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
                ]))));
  }
}
