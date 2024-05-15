
import 'package:get/get.dart';
import 'package:weather/features/screens/onboard.dart';
import 'package:weather/routes/routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: HRoutes.onBoarding, page: () => const OnBoardingPage()),
  ];
}