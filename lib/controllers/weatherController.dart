import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  RxString weather = ''.obs;

  Future<void> fetchWeather(String latitude, String longitude) async {
    try {
      String apiUrl =
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=d1dd19772a6142d9c438357ee4f10cd5';
      http.Response response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String description = data['weather'][0]['description'];
        weather.value = description;
      } else {
        print('Failed to fetch weather: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }
}
