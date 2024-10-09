import 'package:aquaventures/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20, bottom: 20),
            child: Align(
              alignment: Alignment.topRight,
              child: TextWidget(
                text: 'Favorite items ',
                fontSize: 32,
                fontFamily: 'Bold',
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
