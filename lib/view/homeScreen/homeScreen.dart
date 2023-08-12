import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/controller/provider/weatherProvider.dart';
import 'package:weatherapp/apiFunctions/apiFunctions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<WeatherProvider>(
      builder: (context, weatherprovider, child) {
        return SafeArea(
            child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: double.infinity,
             padding: const EdgeInsets.symmetric(horizontal: 32.0),
               decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage("assets/backgroundImage/weatherBackground image.jpg"),
              fit: BoxFit.cover,
                  ),
        ),
            child: Visibility(
              visible: weatherprovider.isLoaded,
              replacement: const Center(child: CircularProgressIndicator()),
              child: Column(
                children: [
                   const SizedBox(
                    height: 30,
                  ),
                  textFormField(size, weatherprovider, context),
                  const SizedBox(
                    height: 30,
                  ),
                  cityName(weatherprovider),
                  const SizedBox(
                    height: 70,
                  ),
                  Temprature(size, weatherprovider),
                   const SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Pressure(size, weatherprovider),
                  CloudCover(size, weatherprovider),
                   Humidity(size, weatherprovider),
                    ],
                  ),
                 
                 
                ],
              ),
            ),
          ),
        ));
      },
    );
  }

  Column CloudCover(Size size, WeatherProvider weatherprovider) {
    return Column(
      children: [
        const Icon(
          Icons.cloud_queue,
          size: 70,
          color:Colors.white,
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
                ]))]);
  }

  Column Humidity(Size size, WeatherProvider weatherprovider) {
    return Column(
      children: [
        const Icon(
          Icons.water_drop_outlined,
          size: 70,
          color:Colors.white,
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
                ]))]);
  }

  Column Pressure(Size size, WeatherProvider weatherprovider) {
    return Column(
      children: [
        const Icon(
          Icons.air_outlined,
          size: 70,
          color:Colors.white,
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
                ]))]);
  }

  Column Temprature(Size size, WeatherProvider weatherprovider) {
    return Column(
      children: [
        const Icon(
          Icons.sunny,
          size: 80,
          color:Colors.amber,
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
                ]))]);
  }

  SizedBox cityName(WeatherProvider weatherprovider) {
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

  Container textFormField(
      Size size, WeatherProvider weatherprovider, BuildContext context) {
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

  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<WeatherProvider>(context).controller.dispose();
    super.dispose();
  }
}
