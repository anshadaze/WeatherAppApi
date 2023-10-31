
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/constants/constants.dart';
import 'package:http/http.dart' as http;
 class Services{
getCurrentLocation(BuildContext context) async {
  var position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.low,
  );
 return position;
}

getCurrentCityWeather(BuildContext context, Position position) async {
  var client = http.Client();
  var uri =
      '${domain}lat=${position.latitude}&lon=${position.longitude}&appid=${apiKey}';
  var url = Uri.parse(uri);
  var response = await client.get(url);
   return response;
  }



getCityWeather(BuildContext context, String cityName) async {
  var client = http.Client();
  var uri = '${domain}q=$cityName&appid=${apiKey}';
  var url = Uri.parse(uri);
  var response = await client.get(url);
   return response;


 }


}
