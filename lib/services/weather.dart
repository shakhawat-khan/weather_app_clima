import 'dart:js';

import 'package:flutter/material.dart';
import 'package:clima_weather_app/screens/location_screen.dart';
import 'location.dart';
import 'package:clima_weather_app/services/networking.dart';

String key = 'ab120a84607c006bd208001b5e48daad';

class WeatherModel {

  Future<dynamic> getCityWeather (String cityName) async
  {
    var url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$key&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);

    await networkHelper.getData();

    //print(networkHelper.decodeData);

    return await networkHelper.decodeData ;

  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
