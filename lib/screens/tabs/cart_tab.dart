import 'package:aquaventures/services/add_order.dart';
import 'package:aquaventures/utils/colors.dart';
import 'package:aquaventures/utils/const.dart';
import 'package:aquaventures/widgets/button_widget.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:aquaventures/widgets/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarTab extends StatefulWidget {
  const CarTab({super.key});

  @override
  State<CarTab> createState() => _CarTabState();
}

class _CarTabState extends State<CarTab> {
  int selectedIndex = 0;

  final List<String> filters = ['To Purchase', 'Ordered'];

  int qty = 0;
  int price = 0;

  String id = '';
  String sellerId = '';

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
                          return SizedBox(
                            height: 350,
                            width: double.infinity,
                            child: ListView.builder(
                              itemCount: data.docs.length,
                              itemBuilder: (context, index) {
                                return StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Products')
                                        .doc(data.docs[index]['productId'])
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                            child: Text('Loading'));
                                      } else if (snapshot.hasError) {
                                        return const Center(
                                            child:
                                                Text('Something went wrong'));
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      dynamic productData = snapshot.data;
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 125,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors.white,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color:
                                                              Colors.black26),
                                                      child: Center(
                                                        child: TextWidget(
                                                          text: productData[
                                                              'name'],
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Image.network(
                                                            productData['img'],
                                                            width: 100,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            children: [
                                                              TextWidget(
                                                                text:
                                                                    productData[
                                                                        'desc'],
                                                                fontSize: 32,
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    'Bold',
                                                              ),
                                                              TextWidget(
                                                                text: '₱15.00',
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    'Regular',
                                                              ),
                                                            ],
                                                          ),
                                                          const Expanded(
                                                            child: SizedBox(
                                                              width: 10,
                                                            ),
                                                          ),
                                                          // ButtonWidget(
                                                          //   radius: 100,
                                                          //   width: 125,
                                                          //   height: 35,
                                                          //   fontSize: 14,
                                                          //   color: Colors.blue[900]!,
                                                          //   label: 'Completed',
                                                          //   onPressed: () {},
                                                          // ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      // Row(
                                                      //   children: [
                                                      //     for (int i = 0; i < 5; i++)
                                                      //       Icon(
                                                      //         Icons.star,
                                                      //         color: i == 4
                                                      //             ? Colors.white
                                                      //             : Colors.amber,
                                                      //       ),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                            ),
                          );
                        }),
                  ],
                ),
        ],
      ),
    );
  }

  Widget purchase() {
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
          dynamic mydata = snapshot.data;
          return Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Products')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Center(child: Text('Error'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.black,
                      )),
                    );
                  }

                  final data = snapshot.requireData;
                  return Column(
                    children: [
                      SizedBox(
                        height: 350,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: data.docs.isNotEmpty ? 1 : 0,
                          itemBuilder: (context, index) {
                            return mydata['carts'].contains(data.docs[index].id)
                                ? Builder(builder: (context) {
                                    price = data.docs[index]['price'];
                                    id = data.docs[index].id;
                                    sellerId = data.docs[index]['uid'];
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 150,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.white,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: Colors.black26),
                                                    child: Center(
                                                      child: TextWidget(
                                                        text: data.docs[index]
                                                            ['desc'],
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('Users')
                                                          .doc(userId)
                                                          .update({
                                                        'carts': FieldValue
                                                            .arrayRemove([
                                                          data.docs[index].id
                                                        ])
                                                      });
                                                      showToast(
                                                          'Removed from cart');
                                                    },
                                                    icon: const Icon(
                                                      Icons.close,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Image.network(
                                                      data.docs[index]['img'],
                                                      width: 100,
                                                      height: 75,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      children: [
                                                        TextWidget(
                                                          text: data.docs[index]
                                                              ['name'],
                                                          fontSize: 32,
                                                          color: Colors.black,
                                                          fontFamily: 'Bold',
                                                        ),
                                                        TextWidget(
                                                          text:
                                                              '₱${data.docs[index]['price']}.00',
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
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color:
                                                              Colors.black26),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (qty > 0) {
                                                                setState(() {
                                                                  qty--;
                                                                });
                                                              }
                                                            },
                                                            child: const Icon(
                                                              Icons.remove,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          TextWidget(
                                                            text:
                                                                qty.toString(),
                                                            fontSize: 14,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                qty++;
                                                              });
                                                            },
                                                            child: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                : const SizedBox();
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
                                  text: '₱${price * qty}.00',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, top: 0, bottom: 10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: ButtonWidget(
                            radius: 20,
                            width: 150,
                            height: 50,
                            fontSize: 18,
                            color: Colors.blue[900]!,
                            label: 'ORDER NOW',
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(userId)
                                  .update({
                                'carts': FieldValue.arrayRemove([id])
                              });
                              addOrder(mydata['name'], sellerId, id, qty,
                                  price * qty);
                              showToast('Order placed succesfully!');
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          );
        });
  }
}
