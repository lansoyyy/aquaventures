import 'package:aquaventures/utils/colors.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:aquaventures/widgets/textfield_widget.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: 'Your Order',
                  fontSize: 18,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: Colors.grey,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: 'Order Tracking',
                  fontSize: 18,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
