import 'package:aquaventures/screens/admin/admin_home.dart';
import 'package:aquaventures/screens/admin/admin_merchants_screen.dart';
import 'package:aquaventures/screens/admin/admin_revenues_screen.dart';
import 'package:aquaventures/screens/admin/admin_users_screen.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AdminDrawerWidget extends StatelessWidget {
  const AdminDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 250,
      color: Colors.blue[100],
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: primary), color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(2.5),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 75,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AdminHome()));
              },
              title: TextWidget(
                text: 'Dashboard',
                fontSize: 14,
                fontFamily: 'Bold',
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AdminRevenuesScreen()));
              },
              title: TextWidget(
                text: 'Revenues',
                fontSize: 14,
                fontFamily: 'Bold',
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AdminMerchantsScreen()));
              },
              title: TextWidget(
                text: 'Merchants',
                fontSize: 14,
                fontFamily: 'Bold',
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AdminusersScreen()));
              },
              title: TextWidget(
                text: 'Users',
                fontSize: 14,
                fontFamily: 'Bold',
              ),
            ),
          ],
        ),
      )),
    );
  }
}
