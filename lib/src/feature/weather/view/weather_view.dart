import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/weather/controller/weather_controller.dart';
import 'package:agriculture/src/feature/weather/model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WeatherController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.lightAppColors.background,
        body: Container(
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
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: AppTheme.lightAppColors.primary,
                            )),
                        SizedBox(
                          width: context.screenWidth * .04,
                        ),
                        Icon(
                          Icons.map,
                          color: AppTheme.lightAppColors.subTextcolor,
                        ),
                        SizedBox(
                          width: context.screenWidth * .02,
                        ),
                        Text(
                          "Jordan Weather",
                          style: TextStyle(
                              color: AppTheme.lightAppColors.primary,
                              fontSize: 23,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: context.screenHeight * .1,
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
      ),
    );
  }
}
