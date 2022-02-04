import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class NetworkHelper {

  String uri;


  NetworkHelper(this.uri);

  dynamic decodeData;


  Future getData() async
  {

    http.Response response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200)
    {
      String data = response.body;

      decodeData = jsonDecode(data);

      //print(decodeData);


    }

    else{
      print(response.statusCode);
    }
  }



}




