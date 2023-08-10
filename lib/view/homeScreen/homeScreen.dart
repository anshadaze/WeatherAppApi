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
            height: double.infinity,
            padding: const EdgeInsets.all(20),
            color: const Color.fromARGB(255, 179, 205, 217),
            child: Visibility(
              visible: weatherprovider.isLoaded,
              replacement: const Center(child: CircularProgressIndicator()),
              child: Column(
                children: [
                  textFormField(size, weatherprovider, context),
                  const SizedBox(
                    height: 30,
                  ),
                  cityName(weatherprovider),
                  const SizedBox(
                    height: 20,
                  ),
                  Temprature(size, weatherprovider),
                  Pressure(size, weatherprovider),
                  Humidity(size, weatherprovider),
                  CloudCover(size, weatherprovider)
                ],
              ),
            ),
          ),
        ));
      },
    );
  }

  Container CloudCover(Size size, WeatherProvider weatherprovider) {
    return Container(
      width: double.infinity,
      height: size.height * 0.12,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade900,
              offset: const Offset(1, 2),
              blurRadius: 3,
              spreadRadius: 1,
            )
          ]),
      child: Row(
        children: [
          Image.asset(
            'assets/images/cloudCoverIcon.png',
            width: size.width * 0.09,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'Cloud Cover:${weatherprovider.cover.toStringAsFixed(2)}%',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Container Humidity(Size size, WeatherProvider weatherprovider) {
    return Container(
      width: double.infinity,
      height: size.height * 0.12,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade900,
              offset: const Offset(1, 2),
              blurRadius: 3,
              spreadRadius: 1,
            )
          ]),
      child: Row(
        children: [
          Image.asset(
            'assets/images/humidityIcon.png',
            width: size.width * 0.09,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'Humidity:${weatherprovider.hum.toStringAsFixed(2)}%',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Container Pressure(Size size, WeatherProvider weatherprovider) {
    return Container(
      width: double.infinity,
      height: size.height * 0.12,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade900,
              offset: const Offset(1, 2),
              blurRadius: 3,
              spreadRadius: 1,
            )
          ]),
      child: Row(
        children: [
          Image.asset(
            'assets/images/barometrIcon.png',
            width: size.width * 0.09,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'Pressure:${weatherprovider.press.toStringAsFixed(2)}hpa',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Container Temprature(Size size, WeatherProvider weatherprovider) {
    return Container(
      width: double.infinity,
      height: size.height * 0.12,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade900,
              offset: Offset(1, 2),
              blurRadius: 3,
              spreadRadius: 1,
            )
          ]),
      child: Row(
        children: [
          Image.asset(
            'assets/images/thermometerIcon.png',
            width: size.width * 0.09,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'Temprature:${weatherprovider.temp.toStringAsFixed(2)}℃',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Padding cityName(WeatherProvider weatherprovider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Icon(
            Icons.pin_drop,
            color: Colors.red,
            size: 40,
          ),
          Text(
            weatherprovider.cityName,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          )
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
