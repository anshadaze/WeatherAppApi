import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/constants/constants.dart';
import 'package:http/http.dart' as http;

import '../controller/provider/weatherProvider.dart';

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
    Provider.of<WeatherProvider>(context, listen: false)
        .changeIsLoadedValue(true);
  } else {
    print(response.statusCode);
  }
}

updateUI(BuildContext context, var decodedData) {
  if (decodedData == null) {
    Provider.of<WeatherProvider>(context).changeTempValue(0);
    Provider.of<WeatherProvider>(context).changePressValue(0);
    Provider.of<WeatherProvider>(context).changeHumValue(0);
    Provider.of<WeatherProvider>(context).changeCoverValue(0);
    Provider.of<WeatherProvider>(context).changeCityName('Not available');
  } else {
    Provider.of<WeatherProvider>(context, listen: false)
        .changeTempValue(decodedData['main']['temp'] - 273);
    Provider.of<WeatherProvider>(context, listen: false)
        .changePressValue(decodedData['main']['pressure']);

    Provider.of<WeatherProvider>(context, listen: false)
        .changeHumValue(decodedData['main']['humidity']);

    Provider.of<WeatherProvider>(context, listen: false)
        .changeCoverValue(decodedData['clouds']['all']);

    Provider.of<WeatherProvider>(context, listen: false)
        .changeCityName(decodedData['name']);
  }
}

getCityWeather(BuildContext context, String cityName) async {
  var client = http.Client();
  var uri = '${domain}q=$cityName&appid=${apiKey}';
  var url = Uri.parse(uri);
  var response = await client.get(url);
  if (response.statusCode == 200) {
    var data = response.body;
    var decodeData = json.decode(data);
    print(data);
    updateUI(context, decodeData);
    Provider.of<WeatherProvider>(context, listen: false)
        .changeIsLoadedValue(true);
  } else {
    print(response.statusCode);
  }
}
