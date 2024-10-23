import 'package:aquaventures/screens/add_product_screen.dart';
import 'package:aquaventures/screens/seller_tabs/seller_cart_tab.dart';
import 'package:aquaventures/screens/seller_tabs/seller_chat_tab.dart';
import 'package:aquaventures/screens/seller_tabs/seller_favorite_tab.dart';
import 'package:aquaventures/screens/seller_tabs/seller_home_tab.dart';
import 'package:aquaventures/screens/seller_tabs/seller_profile_tab.dart';
import 'package:aquaventures/screens/tabs/cart_tab.dart';
import 'package:aquaventures/screens/tabs/chat_tab.dart';
import 'package:aquaventures/screens/tabs/favorite_tab.dart';
import 'package:aquaventures/screens/tabs/home_tab.dart';
import 'package:aquaventures/screens/tabs/profile_tab.dart';
import 'package:aquaventures/utils/colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class SellerHomeScreen extends StatefulWidget {
  const SellerHomeScreen({super.key});

  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  //State class
  int _page = 0;

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List tabs = [
    const SellerHomeTab(),
    const SellerChatTab(),
    const SellerCarTab(),
    const SellerFavoriteTab(),
    const SellerProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddProductScreen()));
        },
      ),
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
