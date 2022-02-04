import 'package:flutter/material.dart';
import 'package:clima_weather_app/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clima_weather_app/services/weather.dart';
import 'city_screen.dart';
import 'package:clima_weather_app/services/weather.dart';

String weatherConditionString = '' ;
int weathertemp = 0;
int weatherCod = 0;
String massage = '';
String weatherIcon='';
String cityName='';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();

  final locationWeather;

  LocationScreen({this.locationWeather});


}



class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(widget.locationWeather);
    updateUI(widget.locationWeather);



    //dynamic decodeData = json.decode(widget.locationWeather);
    //main.temp
    //print(widget.locationWeather);
  }

  void updateUI(dynamic weatherData)
  {

    setState(() {
      dynamic Data = weatherData;

      var weatherCondition =  Data['weather'][0]['main'];
      var temp = Data['main']['temp'];
      var cod = Data ['cod'];
      var city = Data['name'];
      weatherConditionString = weatherCondition.toString();
      weathertemp = temp.toInt();
      weatherCod = cod.toInt();


      weatherIcon = weatherModel.getWeatherIcon(weatherCod);
      massage = weatherModel.getMessage(weathertemp);
      cityName = city;

      //print(weatherConditionString);
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async{

                      var typedName = await Navigator.push(context, MaterialPageRoute(
                          builder: (context)
                      {
                        return CityScreen();
                      }
                      ));

                      print(typedName);
                      if(typedName != null)
                        {
                          print('hello');
                         dynamic weatherData = await weatherModel.getCityWeather(typedName);
                         print(weatherData);
                         updateUI(weatherData);
                        }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$weathertemp' ,
                      style: kTempTextStyle,
                    ),
                    Text(
                      "$weatherIcon",
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$massage in $cityName ",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
