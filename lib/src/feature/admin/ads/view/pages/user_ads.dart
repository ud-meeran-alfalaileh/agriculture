import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/feature/admin/ads/controller/ads_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdsController());

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: controller.fetchAllAds(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Map<String, dynamic>> ads = snapshot.data ?? [];
          return CarouselSlider(
            items: ads.map((ad) {
              return SizedBox(
                width: context.screenWidth * .7,
                child: Image.network(
                  ad['img'],
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayInterval: const Duration(seconds: 2),
            ),
          );
        }
      },
    );
  }
}
