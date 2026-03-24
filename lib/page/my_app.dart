import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/apps/config/theme_custom.dart';
import 'package:weather_app/page/bottom_navigation/bottom_custom.dart';
import 'package:weather_app/page/home/home_page.dart';
import 'package:weather_app/providers/weather_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.positionCurrent});

  final Position positionCurrent;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider()..updatePosition(positionCurrent),
    child: MaterialApp(
      theme: ThemeCustom.themeLight,
    debugShowCheckedModeBanner: false,
    home: const BottomNavigationCustom(),
    ),
    );
  }
}
