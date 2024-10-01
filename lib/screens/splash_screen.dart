import 'dart:async';

import 'package:aquaventures/screens/auth/initial_landing_screen.dart';
import 'package:aquaventures/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 5), () async {
      // Test if location services are enabled.
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const InitialLandingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 250,
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/AquaVentures.png',
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}