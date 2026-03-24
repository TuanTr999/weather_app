import 'dart:convert';

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;
  int seaLevel;
  int grndLevel;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  factory Main.fromMap(Map<String, dynamic> map) {
    return Main(
      temp: (map['temp'] ?? 0).toDouble(),
      feelsLike: (map['feels_like'] ?? 0).toDouble(),
      tempMin: (map['temp_min'] ?? 0).toDouble(),
      tempMax: (map['temp_max'] ?? 0).toDouble(),
      pressure: map['pressure'] ?? 0,
      humidity: map['humidity'] ?? 0,
      seaLevel: map['sea_level'] ?? 0,
      grndLevel: map['grnd_level'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'humidity': humidity,
      'sea_level': seaLevel,
      'grnd_level': grndLevel,
    };
  }
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      id: map['id'] ?? 0,
      main: map['main'] ?? '',
      description: map['description'] ?? '',
      icon: map['icon'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'main': main, 'description': description, 'icon': icon};
  }
}

class Wind {
  double speed;
  int deg;
  double gust;

  Wind({required this.speed, required this.deg, required this.gust});

  factory Wind.fromMap(Map<String, dynamic> map) {
    return Wind(
      speed: (map['speed'] ?? 0).toDouble(),
      deg: map['deg'] ?? 0,
      gust: (map['gust'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'speed': speed, 'deg': deg, 'gust': gust};
  }
}

class WeatherData {
  int id;
  List<Weather>? weather;
  String base;
  Main main;
  int visibility;
  Wind wind;
  String name;
  int cod;

  WeatherData(this.id,
      this.weather,
      this.base,
      this.main,
      this.visibility,
      this.wind,
      this.name,
      this.cod,);

  factory WeatherData.fromMap(Map<String, dynamic> map) {
    return WeatherData(
      map['id'] ?? 0,
      map['weather'] != null
          ? List<Weather>.from(map['weather'].map((e) => Weather.fromMap(e)))
          : null,
      map['base'] ?? '',
      Main.fromMap(map['main'] ?? {}),
      map['visibility'] ?? 0,
      Wind.fromMap(map['wind'] ?? {}),
      map['name'] ?? '',
      map['cod'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'weather': weather != null
          ? weather!.map((e) => e.toMap()).toList()
          : null,
      'base': base,
      'main': main.toMap(),
      'visibility': visibility,
      'wind': wind.toMap(),
      'name': name,
      'cod': cod,
    };
  }

  factory WeatherData.fromJson(String source) {
    return WeatherData.fromMap(jsonDecode(source));
  }

  String toJson() => jsonEncode(toMap());
}

class WeatherDetail {
  Main main;
  Weather weather;
  String dt_txt;

  WeatherDetail({required this.main, required this.weather,
    required this.dt_txt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'main': main.toMap(),
      'weather': weather.toMap(),
      'dt_txt': dt_txt,
    };
  }

  factory WeatherDetail.fromMap(Map<String, dynamic> map) {
    return WeatherDetail(
      main: Main.fromMap(map['main'] as Map<String, dynamic>),
      weather: Weather.fromMap(map['weather'][0] as Map<String, dynamic>),
      dt_txt: map['dt_txt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherDetail.fromJson(String source) => WeatherDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}


