import 'package:aquaventures/screens/auth/signup_screen.dart';
import 'package:aquaventures/screens/home_screen.dart';
import 'package:aquaventures/utils/colors.dart';
import 'package:aquaventures/widgets/button_widget.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:aquaventures/widgets/textfield_widget.dart';
import 'package:aquaventures/widgets/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                    builder: (context) => const SignupScreen()));
              },
            ),
          ],
        ),
      ),
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
                      return 'Please enter an email address';
                    }
                    final emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
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
                    showToast(
                        'Password reset link sent to ${emailController.text}');
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

  bool validatePassword(String password) {
    // Regular expression explanation:
    // ^ - start of the string
    // (?=.*[A-Za-z]) - at least one letter
    // (?=.*\d) - at least one digit
    // (?=.*[@$!%*?&]) - at least one special character
    // .{8,} - minimum 8 characters
    // $ - end of the string
    final regex =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return regex.hasMatch(password);
  }

  login(context) async {
    if (validatePassword(password.text)) {
      try {
        final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text, password: password.text);

        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text, password: password.text);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
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
    } else {
      showToast(
          'Password should contain atleast one number, letter and symbol and atleast 8 characters');
    }
  }
}
