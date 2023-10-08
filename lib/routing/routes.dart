import 'package:covid_app/View/splash_screen.dart';
import 'package:covid_app/countries_list.dart';
import 'package:covid_app/detail_screen.dart';
import 'package:covid_app/home_page.dart';
import 'package:covid_app/routing/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes{
static Route<dynamic> generateRoutes(RouteSettings settings){
switch(settings.name){
  case RouteName.homepage:
    return MaterialPageRoute(builder: (context)=> HomeScreen());
  case RouteName.splashscreen:
    return MaterialPageRoute(builder: (context)=> SplashScreen());
  case RouteName.countrylist  :
    return MaterialPageRoute(builder: (context)=> CountiresList());
  case RouteName.detailsCountry:
    return MaterialPageRoute(builder: (context)=> DetailScreen(data: settings.arguments as Map));
  default:
    return MaterialPageRoute(builder: (context){
      return Scaffold(
        body: Center(
          child: Text('No routes available'),
        ),
      );
    });
}
}
}