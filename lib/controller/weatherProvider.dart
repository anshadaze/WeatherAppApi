import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/services/weather.dart';

class WeatherProvider extends ChangeNotifier{
  Services services=Services();
   
   bool isLoaded = false;
   num temp=0;
  num press=0;
  num hum=0;
  num cover=0;
  String cityName='';
TextEditingController controller = TextEditingController();

getCurrentLocation(BuildContext context) async {
 var position=await services.getCurrentLocation(context);
  if (position != null) {
    getCurrentCityWeather(context, position);
  } else {
    print('data unavailable');
  }
}



getCurrentCityWeather(BuildContext context, Position position) async {
  var response=await  services.getCurrentCityWeather(context,position);
  if (response.statusCode == 200) {
    var data = response.body;
    var decodeData = json.decode(data);
    print(data);
    updateUI(context, decodeData);
    isLoaded=true;
  } else {
    print(response.statusCode);
  }
  }

  updateUI(BuildContext context, var decodedData) {
  if (decodedData == null) {
    temp=0;
    press=0;
    hum=0;
    cover=0;
    cityName='Not available';
  } else {
    temp=decodedData['main']['temp'] - 273;
    press=decodedData['main']['pressure'];
    hum=decodedData['main']['humidity'];
    cover=decodedData['clouds']['all'];
    cityName=(decodedData['name']);
  }
  notifyListeners();
}



getCityWeather(BuildContext context, String cityName) async {
    var response=await services.getCityWeather(context, cityName);
  if (response.statusCode == 200) {
    var data = response.body;
    var decodeData = json.decode(data);
    print(data);
    updateUI(context, decodeData);
    isLoaded=true;
  } else {
    print(response.statusCode);
  }

 }


   void changeControllerValue(value){
       controller=value;
   }



   

}

