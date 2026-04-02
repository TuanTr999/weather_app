import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/repositories/api_repository.dart';

import '../models/search_location_model.dart';

class WeatherProvider extends ChangeNotifier {
  Position? position;
  String? nameCity;

  WeatherData? weatherCurrent;
  List<WeatherDetail> listData = [];

  List<Location> searchResults = [];

  /// ================== LOCATION ==================

  void updatePosition(Position positionCurrent) {
    position = positionCurrent;
    fetchWeather();
  }

  /// ================== WEATHER ==================

  Future<WeatherData> getWeatherCurrent() async {
    if (position == null) throw Exception("Position null");

    WeatherData result = await ApiRepository.callApiGetWeather(position!);

    nameCity = result.name;
    return result;
  }

  Future<List<WeatherDetail>> getWeatherDetail() async {
    if (position == null) throw Exception("Position null");

    List<WeatherDetail> result = await ApiRepository.callApiGetWeatherDetail(
      position!,
    );

    return result;
  }

  Future<void> fetchWeather() async {
    if (position == null) return;

    weatherCurrent = await ApiRepository.callApiGetWeather(position!);

    listData = await ApiRepository.callApiGetWeatherDetail(position!);

    // nameCity = weatherCurrent?.name;

    notifyListeners();
  }

  /// ================== SEARCH ==================

  /// ===== SEARCH CITY =====
  Future<void> searchCity(String query) async {
    searchResults = await ApiRepository.searchCity(query);
    notifyListeners();
  }

  /// ===== SELECT CITY =====
  Future<void> selectLocation(Location loc) async {
    // tạo Position từ lat/lon
    position = Position(
      latitude: loc.lat,
      longitude: loc.lon,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );

    nameCity = loc.name;
    searchResults = [];
    await fetchWeather(); // gọi API cho vị trí mới
  }
}
