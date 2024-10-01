import 'package:aquaventures/screens/auth/signup_screen.dart';
import 'package:aquaventures/screens/home_screen.dart';
import 'package:aquaventures/utils/colors.dart';
import 'package:aquaventures/widgets/button_widget.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:aquaventures/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            TextWidget(
              text: 'Welcome!',
              fontSize: 75,
              fontFamily: 'Bold',
            ),
            TextFieldWidget(
              width: 350,
              label: 'Email',
              controller: email,
            ),
            TextFieldWidget(
              width: 350,
              label: 'Password',
              controller: password,
              isObscure: true,
              showEye: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {},
                  child: TextWidget(
                    text: 'Forgot Password?',
                    fontSize: 14,
                  ),
                ),
                ButtonWidget(
                  width: 350,
                  textColor: Colors.black,
                  color: Colors.white,
                  label: 'Sign In',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            TextWidget(
              text: 'Don’t have an Account?',
              fontSize: 14,
              fontFamily: 'Medium',
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              width: 300,
              textColor: Colors.black,
              color: Colors.white,
              label: 'Create Account',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SignupScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
