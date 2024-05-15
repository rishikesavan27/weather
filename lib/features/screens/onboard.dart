

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/controllers/loactionControllers.dart';
import 'package:weather/controllers/notificationController.dart';
import 'package:weather/controllers/weatherController.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final LocationController locationController = Get.put(LocationController());
  final NotificationController notificationController =
  Get.put(NotificationController());
  final WeatherController weatherController = Get.put(WeatherController());

  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text('Latitude: ${locationController.latitude.value}')),
            Obx(
                    () => Text('Longitude: ${locationController.longitude.value}')),
            ElevatedButton(
              onPressed: () {
                locationController.getLocation();
                _timer?.cancel(); // Cancel previous timer if any
                _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
                  weatherController.fetchWeather(
                      locationController.latitude.value,
                      locationController.longitude.value);
                });
              },
              child: const Text('Get Location & Weather'),
            ),
          ],
        ),
      )
    );
  }
}
