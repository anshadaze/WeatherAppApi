import 'package:flutter/material.dart';
import 'package:weatherapp/services/weather.dart';

import '../../../controller/weatherProvider.dart';

class TextFiled extends StatelessWidget {
  const TextFiled({
    super.key,
    required this.size,
    required this.weatherprovider,
    required this.context,
  });

  final Size size;
  final WeatherProvider weatherprovider;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
  return Container(
    width: size.width * 0.85,
    height: size.height * 0.09,
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
    ),
    decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(20))),
    child: Center(
      child: TextFormField(
        onFieldSubmitted: (String s) {
          weatherprovider.changeIsLoadedValue(false);

          weatherprovider.changeCityName(s);

          getCityWeather(context, s);

          weatherprovider.controller.clear();
        },
        controller: weatherprovider.controller,
        cursorColor: Colors.white,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        decoration: InputDecoration(
          hintText: "Search city",
          hintStyle:
              TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.7)),
          prefixIcon: Icon(
            Icons.search,
            size: 25,
            color: Colors.white.withOpacity(0.7),
          ),
          border: InputBorder.none,
        ),
      ),
    ),
  );
}
}



class CityName extends StatelessWidget {
  const CityName({
    super.key,
    required this.weatherprovider,
  });

  final WeatherProvider weatherprovider;

  @override
  Widget build(BuildContext context) {
  return SizedBox(
    width: 226,
    height: 61,
    child: Column(
      children: [
        Text(
          weatherprovider.cityName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
      ],
    ),
  );
}
}

class Temprature extends StatelessWidget {
  const Temprature({
    super.key,
    required this.size,
    required this.weatherprovider,
  });

  final Size size;
  final WeatherProvider weatherprovider;

  @override
  Widget build(BuildContext context) {
  return Column(children: [
    const Icon(
      Icons.sunny,
      size: 80,
      color: Colors.amber,
    ),
    const SizedBox(height: 18),
    RichText(
        text: TextSpan(
            text: weatherprovider.temp.toStringAsFixed(2),
            style: TextStyle(
              color: Colors.white,
              fontSize: 56,
              fontWeight: FontWeight.w700,
            ),
            children: [
          TextSpan(
              text: "°C",
              style: TextStyle(
                fontWeight: FontWeight.w200,
              ))
        ]))
  ]);
}
}





class Pressure extends StatelessWidget {
  const Pressure({
    super.key,
    required this.size,
    required this.weatherprovider,
  });

  final Size size;
  final WeatherProvider weatherprovider;

  @override
  Widget build(BuildContext context) {
  return Column(children: [
    const Icon(
      Icons.air_outlined,
      size: 70,
      color: Colors.white,
    ),
    const SizedBox(height: 5),
    RichText(
        text: TextSpan(
            text: weatherprovider.press.toStringAsFixed(2),
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
            children: [
          TextSpan(
              text: "hpa",
              style: TextStyle(
                fontWeight: FontWeight.w200,
              ))
        ]))
  ]);
}
}


class Humidity extends StatelessWidget {
  const Humidity({
    super.key,
    required this.size,
    required this.weatherprovider,
  });

  final Size size;
  final WeatherProvider weatherprovider;

  @override
  Widget build(BuildContext context) {
  return Column(children: [
    const Icon(
      Icons.water_drop_outlined,
      size: 70,
      color: Colors.white,
    ),
    const SizedBox(height: 5),
    RichText(
        text: TextSpan(
            text: weatherprovider.hum.toStringAsFixed(2),
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
            children: [
          TextSpan(
              text: "%",
              style: TextStyle(
                fontWeight: FontWeight.w200,
              ))
        ]))
  ]);
}
}

class CloudCover extends StatelessWidget {
  const CloudCover({
    super.key,
    required this.size,
    required this.weatherprovider,
  });

  final Size size;
  final WeatherProvider weatherprovider;

  @override
  Widget build(BuildContext context) {
  return Column(children: [
    const Icon(
      Icons.cloud_queue,
      size: 70,
      color: Colors.white,
    ),
    const SizedBox(height: 5),
    RichText(
        text: TextSpan(
            text: weatherprovider.cover.toStringAsFixed(2),
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
            children: [
          TextSpan(
              text: "%",
              style: TextStyle(
                fontWeight: FontWeight.w200,
              ))
        ]))
  ]);
}
}

