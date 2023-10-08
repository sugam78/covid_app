import 'dart:async';
import 'dart:math' as math;

import 'package:covid_app/routing/route_name.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late final AnimationController controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync:this)..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
  }
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3), (){
      Navigator.pushNamed(context, RouteName.homepage);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context,Widget? child){
                return Transform.rotate(angle: controller.value * 2 * math.pi,
                  child:Container(
                    height: 200,
                    width: 200,
                    child: Center(
                      child: Image(
                        image: AssetImage('images/virus.jpg'),
                      ),
                    ),
                  ) ,);
              }
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.08,),
          Align(
              alignment: Alignment.center,
              child: Text('    Covid 19\n  Tracker App\nMade By Sugam',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),))
        ],
      ),
    );
  }
}
