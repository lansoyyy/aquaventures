import 'package:aquaventures/screens/auth/landing_screen.dart';
import 'package:aquaventures/utils/colors.dart';
import 'package:aquaventures/utils/const.dart';
import 'package:aquaventures/widgets/button_widget.dart';
import 'package:aquaventures/widgets/logout_widget.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:aquaventures/widgets/textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final email = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
  final address = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('Loading'));
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          dynamic data = snapshot.data;
          username.text = data['name'].toString();

          address.text = data['address'];
          email.text = data['email'];
          password.text = '*******';
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
                    'assets/images/profile.png',
                    height: 125,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    enabled: false,
                    borderColor: Colors.grey,
                    width: 350,
                    label: 'Username',
                    controller: username,
                  ),
                  TextFieldWidget(
                    enabled: false,
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
        });
  }
}
