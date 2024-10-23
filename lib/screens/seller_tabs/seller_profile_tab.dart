import 'package:aquaventures/screens/auth/landing_screen.dart';
import 'package:aquaventures/utils/colors.dart';
import 'package:aquaventures/widgets/button_widget.dart';
import 'package:aquaventures/widgets/logout_widget.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:aquaventures/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class SellerProfileTab extends StatefulWidget {
  const SellerProfileTab({super.key});

  @override
  State<SellerProfileTab> createState() => _SellerProfileTabState();
}

class _SellerProfileTabState extends State<SellerProfileTab> {
  final email = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
  final address = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.notifications,
                color: primary,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/sample_avatar.png',
              height: 125,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              borderColor: Colors.grey,
              width: 350,
              label: 'Username',
              controller: username,
            ),
            TextFieldWidget(
              borderColor: Colors.grey,
              width: 350,
              label: 'Dlivery Address',
              controller: address,
            ),
            TextFieldWidget(
              enabled: false,
              borderColor: Colors.grey,
              width: 350,
              label: 'Email',
              controller: email,
            ),
            TextFieldWidget(
              borderColor: Colors.grey,
              enabled: false,
              width: 350,
              label: 'Password',
              controller: password,
              isObscure: true,
              showEye: true,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              width: 300,
              textColor: Colors.white,
              color: Colors.red,
              label: 'Logout',
              onPressed: () {
                logout(context, const LandingScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
