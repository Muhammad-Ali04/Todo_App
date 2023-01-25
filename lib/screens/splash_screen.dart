import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AnimatedSplashScreen(
      nextScreen: HomeScreen(),
      splash: Stack(
        children: [
          Container(
              height: height,
              child: Image.asset(
                "assets/images/splash.jpg",
                fit: BoxFit.cover,
              )),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Plan Your Day's",
              style: TextStyle(
                  fontFamily: "Ubuntu",
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
          )
        ],
      ),
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: Duration(seconds: 3),
      // backgroundColor: Color.fromARGB(255, 203, 194, 177),
      pageTransitionType: PageTransitionType.leftToRight,
      splashIconSize: height,
      duration: 2000,
    );
  }
}
