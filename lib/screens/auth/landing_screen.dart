import 'package:aquaventures/screens/auth/login_screen.dart';
import 'package:aquaventures/utils/colors.dart';
import 'package:aquaventures/widgets/button_widget.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/bg.png',
              ),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ButtonWidget(
              width: 350,
              color: primary,
              textColor: Colors.white,
              label: 'BUYER',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonWidget(
              width: 350,
              color: primary,
              textColor: Colors.white,
              label: 'SELLER',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
