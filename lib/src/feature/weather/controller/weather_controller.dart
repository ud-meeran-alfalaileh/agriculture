import 'dart:async';
import 'dart:convert';

import 'package:agriculture/src/feature/weather/model/weather_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  late StreamController<Weather> _weatherStreamController;

  Stream<Weather> get weatherStream => _weatherStreamController.stream;

  @override
  void onInit() {
    _weatherStreamController = StreamController<Weather>.broadcast();
    fetchDataPeriodically(); // Fetch data periodically
    super.onInit();
  }

  @override
  void onClose() {
    _weatherStreamController.close();
    super.onClose();
  }

  void fetchDataPeriodically() async {
    while (true) {
      try {
        final weatherData = await fetchWeatherData();
        //    print('Fetched weather data: $weatherData');
        _weatherStreamController.add(weatherData);
        await Future.delayed(
            const Duration(seconds: 5)); // Fetch data every 5 minutes
      } catch (e) {
        //    print('Error fetching weather data: $e');
        await Future.delayed(
            const Duration(minutes: 1)); // Retry after 1 minute
      }
    }
  }

  Future<Weather> fetchWeatherData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://api.weatherapi.com/v1/current.json?key=6ffc80afdafe49bbb9f225956241204&q=Jordan&aqi=no'));

      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
