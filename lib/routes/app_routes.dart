import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/info_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String info = '/info';

  static Map<String, WidgetBuilder> get routes => {
        home: (context) => const HomeScreen(),
        info: (context) => const InfoScreen(),
      };
}