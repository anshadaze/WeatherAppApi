import 'package:flutter/material.dart';

class WeatherProvider extends ChangeNotifier{

   
   bool isLoaded = false;
   num temp=0;
  num press=0;
  num hum=0;
  num cover=0;
  String cityName='';
TextEditingController controller = TextEditingController();

   void changeIsLoadedValue(bool value){
     isLoaded=value;
     notifyListeners();
   }


   void changeTempValue(num value){
    temp=value;
    notifyListeners();

   }

   void changePressValue(num value){
    press=value;
    notifyListeners();
   }

   void changeHumValue(num value){
   hum=value;
   notifyListeners();

   }

   void changeCoverValue(num value){
     cover=value;
     notifyListeners();
   }

   void changeCityName(String value){
      cityName=value;
      notifyListeners();
   }


   void changeControllerValue(value){
       controller=value;
   }

}

