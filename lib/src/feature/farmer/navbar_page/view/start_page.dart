import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/feature/farmer/navbar_page/view/page/navbar_page.dart';
import 'package:agriculture/src/feature/weather/controller/weather_controller.dart';
import 'package:agriculture/src/feature/weather/model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../config/theme/theme.dart';

// ignore: must_be_immutable
class StartWidget extends StatefulWidget {
  const StartWidget({
    super.key,
  });

  @override
  State<StartWidget> createState() => _StartWidgetState();
}

class _StartWidgetState extends State<StartWidget> {
  final controller = Get.put(WeatherController());

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
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
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: StreamBuilder<Weather>(
          stream: controller.weatherStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitFadingCircle(
                      color: AppTheme.lightAppColors.mainTextcolor,
                      size: 50.0,
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final weatherData = snapshot.data!;

              return Column(
                children: [
                  SizedBox(
                    height: context.screenHeight * .2,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: context.screenWidth,
                    height: context.screenHeight * 0.6,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            AppTheme.lightAppColors.primary.withOpacity(.3),
                            AppTheme.lightAppColors.primary,
                            AppTheme.lightAppColors.primary.withOpacity(.3),
                            AppTheme.lightAppColors.primary,
                          ],
                        ),
                        color: AppTheme.lightAppColors.maincolor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '  ${weatherData.location.name}, ${weatherData.location.region}, ${weatherData.location.country}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: context.screenHeight * .02,
                        ),
                        Text(
                          'Temperature: ${weatherData.current.tempC}°C',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Center(
                          child: Image.network(
                            'https:${weatherData.current.condition['icon']}',
                            width: 100,
                            height: 200,
                          ),
                        ),
                        Text(
                          'Condition: ${weatherData.current.condition['text']}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: context.screenHeight * .02,
                        ),
                        Text(
                          'Local Time: ${weatherData.location.localtime}',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
