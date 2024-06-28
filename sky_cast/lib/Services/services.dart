// ignore_for_file: avoid_print

import "dart:convert";

import "package:http/http.dart" as http;
import "package:sky_cast/Model/weather_model.dart";

class WeatherServices{
  fetchWeather() async{
    final responce = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=10.530345&lon=76.214729&appid=fd4066867f6ee925ed1cf62a90b00c6f"
      )
    );
    try {
      if (responce.statusCode==200) {
        var json = jsonDecode(responce.body);
        return WeatherData.fromJson(json);
      }
      else{
        throw Exception("failed to load weather data");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}