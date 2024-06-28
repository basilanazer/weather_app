import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sky_cast/Model/weather_model.dart';
import 'package:sky_cast/Services/services.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  late WeatherData weatherInfo;
  bool isLoading = false;
  myWeather() {
    isLoading = false;
    WeatherServices().fetchWeather().then((value) {
      setState(() {
        weatherInfo = value;
        isLoading = true;
      });
    });
  }

  @override
  void initState() {
    weatherInfo = WeatherData(
      name: '',
      seaLevel: 0,
      minTemperature: 0,
      maxTemperature: 0,
      temperature: Temperature(current: 0.0),
      humidity: 0,
      wind: Wind(speed: 0.0),
      pressure: 0,
      weather: [],
    );
    myWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('EEEE d,MMMM yyyy').format(DateTime.now());
    String formattedTime = DateFormat('hh:mm a').format(DateTime.now());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: isLoading
                  ? WeatherDetail(
                      weather: weatherInfo,
                      formattedDate: formattedDate,
                      formattedTime: formattedTime,
                    )
                  :  CircularProgressIndicator(color: Colors.indigo.shade200,),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherDetail extends StatelessWidget {
  final WeatherData weather;
  final String formattedDate;
  final String formattedTime;
  const WeatherDetail({
    super.key,
    required this.weather,
    required this.formattedDate,
    required this.formattedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weather.name,
                  style: GoogleFonts.josefinSans(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5,),
                if (weather.weather.isNotEmpty)
                  Text(
                    weather.weather[0].main,
                    style: GoogleFonts.josefinSans(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            Text(
                  formattedDate,
                  style: GoogleFonts.josefinSans(
                    fontSize: 16,
                    color: const Color(0x00a4a4a4),
                  ),
                ),
          ],
        ),
        
        const SizedBox(height: 20),
        Container(
          height: 177,
          width: 315,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/cloudy.png"),
            ),
          ),
        ),
        const SizedBox(height: 11,),
        // for current temperature of my location
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${weather.temperature.current.toStringAsFixed(0)}°C",
              style: GoogleFonts.josefinSans(
                fontSize: 96,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            //const SizedBox(height: 5,),
            Text(
              formattedTime,
              style: GoogleFonts.josefinSans(
                fontSize: 18,
                color: Colors.indigo[200],
                fontWeight: FontWeight.bold,
              ),
            ),
            // if (weather.weather.isNotEmpty)
            const SizedBox(height: 5,),
            if (weather.weather.isNotEmpty)
            Text(
              weather.weather.first.description,
              style: GoogleFonts.josefinSans(
                fontSize: 26,
                color: const Color(0x00a4a4a4),
              ),
            ),
          ],
        ),
        Container(
          height: 225,
          decoration: BoxDecoration(
            boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25), // Shadow color
                  spreadRadius: 5, // Spread radius
                  blurRadius: 7, // Blur radius
                  offset: const Offset(0, 3), // changes position of shadow (x, y)
                ),
              ],
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Icon(
                          Icons.wind_power,
                          color: Colors.indigo[900],
                        ),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                            title: "Wind", value: "${weather.wind.speed}km/h"),
                      ],
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sunny,
                          color: Colors.indigo[900],
                        ),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                            title: "Max",
                            value:
                            "${weather.maxTemperature.toStringAsFixed(0)}°C"),
                      ],
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sunny,
                          color: Colors.indigo[900],
                        ),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                            title: "Min",
                            value: 
                                "${weather.minTemperature.toStringAsFixed(0)}°C"),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.water_drop,
                          color: Colors.indigo[900],
                        ),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                            title: "Humidity", value: "${weather.humidity}%"),
                      ],
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.air,
                          color: Colors.indigo[900],
                        ),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                            title: "Pressure", value: "${weather.pressure}hPa"),
                      ],
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.leaderboard,
                          color: Colors.indigo[900],
                        ),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                            title: "Sea-Level", value: "${weather.seaLevel}m"),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column weatherInfoCard({required String title, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.josefinSans(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        Text(
          title,
          style: GoogleFonts.josefinSans(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}