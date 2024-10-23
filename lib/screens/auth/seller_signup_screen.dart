import 'package:aquaventures/screens/auth/login_screen.dart';
import 'package:aquaventures/screens/auth/seller_login_screen.dart';
import 'package:aquaventures/screens/home_screen.dart';
import 'package:aquaventures/services/add_seller.dart';
import 'package:aquaventures/services/add_user.dart';
import 'package:aquaventures/utils/colors.dart';
import 'package:aquaventures/widgets/button_widget.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:aquaventures/widgets/textfield_widget.dart';
import 'package:aquaventures/widgets/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SellerSignupScreen extends StatefulWidget {
  const SellerSignupScreen({super.key});

  @override
  State<SellerSignupScreen> createState() => _SellerSignupScreenState();
}

class _SellerSignupScreenState extends State<SellerSignupScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
  final address = TextEditingController();
  final stationname = TextEditingController();
  final number = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              TextWidget(
                text: 'Create Account',
                fontSize: 45,
                fontFamily: 'Bold',
              ),
              TextFieldWidget(
                width: 350,
                label: 'Owner Name',
                controller: username,
              ),
              TextFieldWidget(
                width: 350,
                label: 'Username',
                controller: email,
              ),
              TextFieldWidget(
                width: 350,
                label: 'Password',
                controller: password,
                isObscure: true,
                showEye: true,
              ),
              TextFieldWidget(
                width: 350,
                label: 'Water Station Name',
                controller: stationname,
              ),
              TextFieldWidget(
                width: 350,
                label: 'Water Station Address',
                controller: address,
              ),
              TextFieldWidget(
                width: 350,
                label: 'Contact Number',
                controller: number,
                inputType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: primary,
                          activeColor: Colors.white,
                          value: true,
                          onChanged: (value) {},
                        ),
                        TextWidget(
                          text: 'Remember Me',
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                  ButtonWidget(
                    width: 350,
                    textColor: Colors.black,
                    color: Colors.white,
                    label: 'Sign Up',
                    onPressed: () {
                      register(context);
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    text: ' have an Account?',
                    fontSize: 14,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    },
                    child: TextWidget(
                      text: 'Sign In',
                      fontSize: 16,
                      fontFamily: 'Bold',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  register(context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: '${email.text}@seller.com', password: password.text);

      addSeller(username.text, '${email.text}@seller.com', address.text,
          number.text, stationname.text);

      // signup(nameController.text, numberController.text, addressController.text,
      //     emailController.text);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SellerLoginScreen()),
      );
      showToast("Registered Successfully!");

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        showToast('The email address is not valid.');
      } else {
        showToast(e.toString());
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
  }
}
