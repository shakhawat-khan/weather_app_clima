import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationClass {

  late double _latitude;

  double get latitude => _latitude;

  set latitude(double latitude) {
    _latitude = latitude;
  }
  late double _longitude;

  double get longitude => _longitude;

  set longitude(double longitude) {
    _longitude = longitude;
  }

  Future<void> getCurrentLocation() async
  {
    try{
      Position position = await Geolocator.
      getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      latitude = position.latitude;
      longitude = position.longitude;
    }
    catch(e){
      print(e);
    }
  }





}