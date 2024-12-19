import 'package:aquaventures/screens/admin/admin_home.dart';
import 'package:aquaventures/screens/auth/seller_signup_screen.dart';
import 'package:aquaventures/screens/seller_home_screen.dart';
import 'package:aquaventures/utils/colors.dart';
import 'package:aquaventures/widgets/button_widget.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:aquaventures/widgets/textfield_widget.dart';
import 'package:aquaventures/widgets/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SellerLoginScreen extends StatefulWidget {
  const SellerLoginScreen({super.key});

  @override
  State<SellerLoginScreen> createState() => _SellerLoginScreenState();
}

class _SellerLoginScreenState extends State<SellerLoginScreen> {
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
                  onPressed: () {
                    forgotPassword();
                  },
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
                    login(context);
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
                    builder: (context) => const SellerSignupScreen()));
              },
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  adminDialog();
                },
                child: TextWidget(
                  text: 'Continue as Admin',
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'Bold',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final adminusername = TextEditingController();
  final adminpassword = TextEditingController();

  adminDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFieldWidget(
                  label: 'Admin Username',
                  controller: adminusername,
                ),
                TextFieldWidget(
                  label: 'Admin password',
                  controller: adminpassword,
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                  label: 'Continue',
                  onPressed: () {
                    if (adminusername.text == 'admin_username' &&
                        adminpassword.text == 'admin_password') {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const AdminHome()),
                      );
                    } else {
                      Navigator.pop(context);
                      showToast('Invalid admin credentials!');
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  forgotPassword() {
    showDialog(
      context: context,
      builder: ((context) {
        final formKey = GlobalKey<FormState>();
        final TextEditingController emailController = TextEditingController();

        return AlertDialog(
          backgroundColor: Colors.grey[300],
          title: TextWidget(
            text: 'Forgot Password',
            fontSize: 18,
            color: Colors.black,
            fontFamily: 'Bold',
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFieldWidget(
                  width: 300,
                  hint: 'Email for Reset Password',
                  textCapitalization: TextCapitalization.none,
                  inputType: TextInputType.emailAddress,
                  label: 'Email for Reset Password',
                  borderColor: secondary,
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    final emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a email';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              child: TextWidget(
                text: 'Cancel',
                fontSize: 12,
                color: Colors.black,
                fontFamily: 'Bold',
              ),
            ),
            TextButton(
              onPressed: (() async {
                if (formKey.currentState!.validate()) {
                  try {
                    Navigator.pop(context);
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: emailController.text);
                    // showToast(
                    //     'Password reset link sent to ${emailController.text}');
                  } catch (e) {
                    String errorMessage = '';

                    if (e is FirebaseException) {
                      switch (e.code) {
                        case 'invalid-email':
                          errorMessage = 'The email address is invalid.';
                          break;
                        case 'user-not-found':
                          errorMessage =
                              'The user associated with the email address is not found.';
                          break;
                        default:
                          errorMessage =
                              'An error occurred while resetting the password.';
                      }
                    } else {
                      errorMessage =
                          'An error occurred while resetting the password.';
                    }

                    showToast(errorMessage);
                    Navigator.pop(context);
                  }
                }
              }),
              child: TextWidget(
                text: 'Continue',
                fontSize: 14,
                color: Colors.black,
                fontFamily: 'Bold',
              ),
            ),
          ],
        );
      }),
    );
  }

  login(context) async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SellerHomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast("No user found with that email.");
      } else if (e.code == 'wrong-password') {
        showToast("Wrong password provided for that user.");
      } else if (e.code == 'invalid-email') {
        showToast("Invalid email provided.");
      } else if (e.code == 'user-disabled') {
        showToast("User account has been disabled.");
      } else {
        showToast("An error occurred: ${e.message}");
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
  }
}
