import 'package:aquaventures/utils/colors.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: double.infinity,
      color: primary,
      child: Center(
        child: Image.asset(
          'assets/images/EATS.png',
          width: 100,
        ),
      ),
    );
  }
}
