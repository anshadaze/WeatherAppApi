import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/constants/constants.dart';
import 'package:http/http.dart' as http;

import '../controller/weatherProvider.dart';


getCurrentLocation(BuildContext context) async {
  var position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.low,
  );
  if (position != null) {
    print('Lat:${position.latitude},Log:${position.longitude}');
    getCurrentCityWeather(context, position);
  } else {
    print('data unavailable');
  }
}

getCurrentCityWeather(BuildContext context, Position position) async {
  var weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
  var client = http.Client();
  var uri =
      '${domain}lat=${position.latitude}&lon=${position.longitude}&appid=${apiKey}';
  var url = Uri.parse(uri);
  var response = await client.get(url);
  if (response.statusCode == 200) {
    var data = response.body;
    var decodeData = json.decode(data);
    print(data);
    updateUI(context, decodeData);
    weatherProvider.changeIsLoadedValue(true);
  } else {
    print(response.statusCode);
  }
}

updateUI(BuildContext context, var decodedData) {
  var weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
  if (decodedData == null) {
    weatherProvider.changeTempValue(0);
    weatherProvider.changePressValue(0);
    weatherProvider.changeHumValue(0);
    weatherProvider.changeCoverValue(0);
    weatherProvider.changeCityName('Not available');
  } else {
    weatherProvider.changeTempValue(decodedData['main']['temp'] - 273);
    weatherProvider.changePressValue(decodedData['main']['pressure']);
    weatherProvider.changeHumValue(decodedData['main']['humidity']);

    weatherProvider.changeCoverValue(decodedData['clouds']['all']);

    weatherProvider.changeCityName(decodedData['name']);
  }
}

getCityWeather(BuildContext context, String cityName) async {
  var weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
  var client = http.Client();
  var uri = '${domain}q=$cityName&appid=${apiKey}';
  var url = Uri.parse(uri);
  var response = await client.get(url);
  if (response.statusCode == 200) {
    var data = response.body;
    var decodeData = json.decode(data);
    print(data);
    updateUI(context, decodeData);
    weatherProvider.changeIsLoadedValue(true);
  } else {
    print(response.statusCode);
  }
}
