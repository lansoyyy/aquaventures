import 'package:aquaventures/screens/tabs/cart_tab.dart';
import 'package:aquaventures/screens/tabs/chat_tab.dart';
import 'package:aquaventures/screens/tabs/favorite_tab.dart';
import 'package:aquaventures/screens/tabs/home_tab.dart';
import 'package:aquaventures/screens/tabs/messages_tab.dart';
import 'package:aquaventures/screens/tabs/profile_tab.dart';
import 'package:aquaventures/utils/colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //State class
  int _page = 0;

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List tabs = [
    const HomeTab(),
    const MessagesTab(),
    const CarTab(),
    const FavoriteTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Colors.white,
        buttonBackgroundColor: primary,
        color: primary,
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.chat,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_bag_outlined,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: SafeArea(child: tabs[_page]),
    );
  }
}
