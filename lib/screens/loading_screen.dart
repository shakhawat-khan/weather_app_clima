
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';
import 'package:clima_weather_app/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clima_weather_app/services/networking.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  String key = 'ab120a84607c006bd208001b5e48daad';

  double latitude=0.0;
  double longitude=0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationdata();
  }


 Future<dynamic> getLocationdata() async
 {
   LocationClass location = LocationClass();
   await location.getCurrentLocation();

   latitude = (location.latitude);
   longitude = (location.longitude);

   NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$key&units=metric');
   await networkHelper.getData();
   var weatherData = networkHelper.decodeData;

   //print(weatherData);


   Navigator.push(context, MaterialPageRoute(builder: (context)
   {
     return LocationScreen(locationWeather: weatherData,);
   }
   ));




 }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 100.0,
        ),
      ) ,
    );
  }
}
