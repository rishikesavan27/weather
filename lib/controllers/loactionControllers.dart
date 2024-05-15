import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';


class LocationController extends GetxController {
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;

  Future<void> getLocation() async {
    try {
      var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude.value = position.latitude.toString();
      longitude.value = position.longitude.toString();
    } catch (e) {
      print('Error getting location: $e');
    }
  }
}


