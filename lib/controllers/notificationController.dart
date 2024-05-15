import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:weather/controllers/loactionControllers.dart';
import 'package:weather/controllers/weatherController.dart';

class NotificationController extends GetxController {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    initializeNotifications();
  }

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
    const InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String latitude, String longitude,
      String weatherDescription) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Location & Weather Update',
      'Latitude: $latitude\nLongitude: $longitude\nWeather: $weatherDescription',
      platformChannelSpecifics,
    );
  }
}

class BackgroundService extends GetxService {
  final LocationController _locationController = Get.find();
  final NotificationController _notificationController = Get.find();
  final WeatherController _weatherController = Get.find();
  late Timer timer;

  void startBackgroundService() {
    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _locationController.getLocation();
      _weatherController.fetchWeather(
          _locationController.latitude.value,
          _locationController.longitude.value);
      _notificationController.showNotification(
          _locationController.latitude.value,
          _locationController.longitude.value,
          _weatherController.weather.value);
    });
  }
}