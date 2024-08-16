
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peony_app_kazeem/accountsreens/createaccount.dart';
import 'package:peony_app_kazeem/accountsreens/weSentAnOtp.dart';
import 'package:peony_app_kazeem/store/cartPage.dart';
import 'package:peony_app_kazeem/store/orders.dart';
import 'package:peony_app_kazeem/store/ordersCollectionDetails.dart';
import 'package:peony_app_kazeem/store/orderscollection.dart';
import 'package:peony_app_kazeem/store/storepage.dart';

class routeManager {
  static const String homePageOne = '/';
  static const String weSentAnOtp = '/weSentAnOtp';
  static const String spalshScreenThree = '/splashScreenThree';
  static const String splashScreenFour = '/splashScreenFour';
  static const String splashScreenFive = '/splashScreenFive';
  static const String getStarted = '/getStarted';
  static const String doctorCategories = '/doctorCategories';
  static const String mainHomeScreenOne = '/mainHomeScreenOne';
  static const String doctorsSpecification = '/doctorsSpecfication';
  static const String doctorProfile = '/doctorProfile';
  static const String doctorLocation = '/doctorLocation';
  static const String appointmentScreenOne = '/appointmentScreenOne';
  static const String appointmentScreenTwo = '/appointmentScreenTwo';
  static const String messageOne = '/messageOne';
  static const String messageTwo = '/messageTwo';
  static Route<dynamic> routeSettings(RouteSettings settings) {

    switch (settings.name) {
      case homePageOne:
        return MaterialPageRoute(
            builder: ((context) => storepage() ));
      case weSentAnOtp:
        return MaterialPageRoute(
            builder: ((context) => otp()));


      default:
        throw const FormatException('no route found');
    }
  }
}
