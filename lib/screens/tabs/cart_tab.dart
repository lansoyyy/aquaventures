import 'package:aquaventures/utils/colors.dart';
import 'package:aquaventures/widgets/button_widget.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CarTab extends StatefulWidget {
  const CarTab({super.key});

  @override
  State<CarTab> createState() => _CarTabState();
}

class _CarTabState extends State<CarTab> {
  int selectedIndex = 0;

  final List<String> filters = ['To Purchase', 'Ordered'];

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
                text: 'My Cart',
                fontSize: 32,
                fontFamily: 'Bold',
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: filters.asMap().entries.map((entry) {
              int index = entry.key;
              String filter = entry.value;
              bool isSelected = index == selectedIndex;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  showCheckmark: false,
                  label: Text(
                    filter,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: const Color(0xff2A90EF),
                  backgroundColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  onSelected: (bool selected) {
                    setState(() {
                      selectedIndex = selected ? index : 0;
                    });
                  },
                ),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 10,
          ),
          selectedIndex == 0
              ? purchase()
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 125,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey[300]),
                          child: Center(
                            child: TextWidget(
                              text: 'Order completed',
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 350,
                      width: double.infinity,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Card(
                            color: primary,
                            child: SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 125,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.black26),
                                          child: Center(
                                            child: TextWidget(
                                              text: 'Too Big',
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Image.asset(
                                                'assets/images/Web_Photo_Editor 1.png',
                                                width: 100,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                children: [
                                                  TextWidget(
                                                    text: 'Slim',
                                                    fontSize: 32,
                                                    color: Colors.black,
                                                    fontFamily: 'Bold',
                                                  ),
                                                  TextWidget(
                                                    text: '₱20.00',
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: 'Regular',
                                                  ),
                                                ],
                                              ),
                                              const Expanded(
                                                child: SizedBox(
                                                  width: 10,
                                                ),
                                              ),
                                              ButtonWidget(
                                                radius: 100,
                                                width: 125,
                                                height: 35,
                                                fontSize: 14,
                                                color: Colors.blue[900]!,
                                                label: 'Completed',
                                                onPressed: () {},
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              for (int i = 0; i < 5; i++)
                                                Icon(
                                                  Icons.star,
                                                  color: i == 4
                                                      ? Colors.white
                                                      : Colors.amber,
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget purchase() {
    return Column(
      children: [
        SizedBox(
          height: 350,
          width: double.infinity,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                color: primary,
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 125,
                              height: 35,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black26),
                              child: Center(
                                child: TextWidget(
                                  text: 'Too Big',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.close,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/Web_Photo_Editor 1.png',
                                width: 100,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  TextWidget(
                                    text: 'Slim',
                                    fontSize: 32,
                                    color: Colors.black,
                                    fontFamily: 'Bold',
                                  ),
                                  TextWidget(
                                    text: '₱20.00',
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontFamily: 'Regular',
                                  ),
                                ],
                              ),
                              const Expanded(
                                child: SizedBox(),
                              ),
                              Container(
                                width: 125,
                                height: 35,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.black26),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                    TextWidget(
                                      text: 'Too Big',
                                      fontSize: 14,
                                    ),
                                    const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, top: 0, bottom: 0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: ButtonWidget(
                              radius: 100,
                              width: 125,
                              height: 35,
                              fontSize: 14,
                              color: Colors.blue[900]!,
                              label: 'Place Order',
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: 'Total:',
                fontSize: 32,
                fontFamily: 'Bold',
                color: Colors.black,
              ),
              Container(
                width: 75,
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[900]),
                child: Center(
                  child: TextWidget(
                    text: '₱45.00',
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 0, bottom: 10),
          child: Align(
            alignment: Alignment.topRight,
            child: ButtonWidget(
              radius: 20,
              width: 150,
              height: 50,
              fontSize: 18,
              color: Colors.blue[900]!,
              label: 'ORDER NOW',
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
