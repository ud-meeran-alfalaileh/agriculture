import 'package:agriculture/src/feature/navbar_page/view/page/navbar_page.dart';
import 'package:agriculture/src/feature/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class StartWidget extends StatefulWidget {
  const StartWidget({
    super.key,
  });

  @override
  State<StartWidget> createState() => _StartWidgetState();
}

class _StartWidgetState extends State<StartWidget> {
  final controller = Get.put(ProfileController());

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      Get.offAll(
        const NavBarWidget(),
        transition: Transition.fade,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOut,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Container());
  }
}
