class Temperature {
  final double current;

  Temperature({required this.current});

  factory Temperature.fromJson(dynamic json) {
    return Temperature(
      current: (json - 273.15), // Kelvin to Celsius
    );
  }
}
class Wind {
  final double speed;

  Wind({required this.speed});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(speed: json['speed']);
  }
}
class WeatherInfo {
  final String main;
  
  final String description;
  WeatherInfo({
    required this.main,
    required this.description,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      main: json['main'],
      description: json['description'],
    );
  }
}
class WeatherData{
  final String name;
  final Temperature temperature;
  final Wind wind;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final double minTemperature;
  final double maxTemperature;
  final List<WeatherInfo> weather;

  WeatherData({
    required this.seaLevel,
    required this.maxTemperature,
    required this.minTemperature,
    required this.name,
    required this.temperature,
    required this.wind,
    required this.pressure,
    required this.humidity,
    required this.weather,
  });

  factory WeatherData.fromJson(Map<String,dynamic> json){
    return WeatherData(
      name: json['name'],
      temperature: Temperature.fromJson(json['main']['temp']),
      humidity: json['main']['humidity'],
      wind: Wind.fromJson(json['wind']),
      pressure: json['main']['pressure'],
      maxTemperature: (json['main']['temp_max'] - 273.15), // Kelvin to Celsius
      minTemperature: (json['main']['temp_min'] - 273.15), // Kelvin to Celsius
      seaLevel: json['main']['sea_level'] ?? 0,
      weather: List<WeatherInfo>.from(
        json['weather'].map(
          (weather) => WeatherInfo.fromJson(weather),
        ),
      ),
    );
  }
}