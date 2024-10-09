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
          Wrap(
            children: [
              for (int i = 0; i < 7; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.grey[300],
                    child: SizedBox(
                      width: 180,
                      height: 265,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                width: 150,
                                height: 125,
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/Web_Photo_Editor 1.png',
                                    width: 125,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextWidget(
                              text: 'AquaLinda',
                              fontSize: 18,
                              fontFamily: 'Bold',
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: GestureDetector(
                                child: Container(
                                  width: 125,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: Colors.grey,
                                      )),
                                  child: Center(
                                    child: TextWidget(
                                      text: 'Add to cart',
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontFamily: 'Bold',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
