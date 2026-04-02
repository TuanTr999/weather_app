import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/apps/utils/const.dart';
import 'package:weather_app/models/weather_model.dart';

import '../models/search_location_model.dart';

class ApiRepository {
  static Future<WeatherData> callApiGetWeather(Position position) async {
    try {
      final dio = Dio();

      final res = await dio.get(
        "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&units=metric&appid=${MyKey.api_token}",
      );
      final data = res.data;
      WeatherData result = WeatherData.fromMap(data);
      return result;
    } catch (e) {
      print('Lỗi: $e');
      throw e;
    }
  }

  static Future<List<WeatherDetail>> callApiGetWeatherDetail(Position position,) async {
    try {
      final dio = Dio();

      final res = await dio.get(
        "https://api.openweathermap.org/data/2.5/forecast?lat=${position.latitude}&lon=${position.longitude}&units=metric&appid=${MyKey.api_token}",
      );
      List data = res.data['list'];
      List<WeatherDetail> result = data
          .map((e) => WeatherDetail.fromMap(e))
          .toList();
      return result;
    } catch (e) {
      print('Lỗi: $e');
      throw e;
    }
  }

  static Future<List<Location>> searchCity(String query) async {
    if (query.isEmpty) return [];

    final dio = Dio();
    final res = await dio.get(
      'https://nominatim.openstreetmap.org/search',
      queryParameters: {
        'q': query,
        'format': 'json',
        'limit': 5,
      },
      options: Options(
        headers: {'User-Agent': 'weather_app'},
      ),
    );

    final data = res.data as List;
    return data.map((e) => Location.fromMap(e)).toList();
  }
}
