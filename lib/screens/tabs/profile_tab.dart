import 'package:aquaventures/screens/auth/landing_screen.dart';
import 'package:aquaventures/utils/const.dart';
import 'package:aquaventures/widgets/logout_widget.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:aquaventures/widgets/textfield_widget.dart';
import 'package:aquaventures/widgets/toast_widget.dart';
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
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Orders')
                          .where('uid', isEqualTo: userId)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                          return const Center(child: Text('Error'));
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: Colors.black,
                            )),
                          );
                        }

                        final data = snapshot.requireData;
                        return Align(
                            alignment: Alignment.topRight,
                            child: PopupMenuButton(
                              itemBuilder: (context) {
                                return [
                                  for (int i = 0; i < data.docs.length; i++)
                                    PopupMenuItem(
                                      child: TextWidget(
                                        text:
                                            'Your order: ${data.docs[i].id} is placed',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                ];
                              },
                            ));
                      }),
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
                    borderColor: Colors.grey,
                    width: 350,
                    label: 'Username',
                    controller: username,
                    color: Colors.black,
                    hintColor: Colors.black,
                  ),
                  TextFieldWidget(
                    borderColor: Colors.grey,
                    width: 350,
                    label: 'Delivery Address',
                    controller: address,
                    hintColor: Colors.black,
                  ),
                  TextFieldWidget(
                    enabled: false,
                    borderColor: Colors.grey,
                    width: 350,
                    label: 'Email',
                    controller: email,
                    hintColor: Colors.black,
                  ),
                  TextFieldWidget(
                    borderColor: Colors.grey,
                    enabled: false,
                    width: 350,
                    label: 'Password',
                    controller: password,
                    hintColor: Colors.black,
                    isObscure: true,
                    showEye: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          showToast('Profile updated!');
                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(userId)
                              .update({
                            'name': username.text,
                            'address': address.text,
                          });
                        },
                        child: Image.asset(
                          'assets/images/Frame 2.png',
                          width: 175,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          logout(context, const LandingScreen());
                        },
                        child: Image.asset(
                          'assets/images/Frame 3.png',
                          width: 175,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
