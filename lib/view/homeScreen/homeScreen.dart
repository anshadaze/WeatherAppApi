import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/controller/weatherProvider.dart';
import 'package:weatherapp/services/weather.dart';
import 'package:weatherapp/view/homeScreen/widgets/widgets.dart';

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
                image: const AssetImage(
                    "assets/backgroundImage/weatherBackground image.jpg"),
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
                  TextFiled(size: size, weatherprovider: weatherprovider, context: context),
                  const SizedBox(
                    height: 30,
                  ),
                  CityName(weatherprovider: weatherprovider),
                  const SizedBox(
                    height: 70,
                  ),
                  Temprature(size:size, weatherprovider:weatherprovider),
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Pressure(size: size, weatherprovider: weatherprovider),
                      CloudCover(size: size, weatherprovider: weatherprovider),
                      Humidity(size: size, weatherprovider: weatherprovider),
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

  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<WeatherProvider>(context).controller.dispose();
    super.dispose();
  }
}










