import 'package:aquaventures/utils/colors.dart';
import 'package:aquaventures/utils/const.dart';
import 'package:aquaventures/widgets/button_widget.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:aquaventures/widgets/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SellerCarTab extends StatefulWidget {
  const SellerCarTab({super.key});

  @override
  State<SellerCarTab> createState() => _SellerCarTabState();
}

class _SellerCarTabState extends State<SellerCarTab> {
  int selectedIndex = 0;

  final List<String> filters = ['To Deliver', 'Done'];

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
                text: 'My Orders',
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
          selectedIndex == 0 ? purchase() : done(),
        ],
      ),
    );
  }

  Widget purchase() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Orders')
            .where('sellerId', isEqualTo: userId)
            .where('status', isEqualTo: 'Pending')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          return SizedBox(
            height: 500,
            width: double.infinity,
            child: ListView.builder(
              itemCount: data.docs.length,
              itemBuilder: (context, index) {
                return StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Products')
                        .doc(data.docs[index]['productId'])
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: Text('Loading'));
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text('Something went wrong'));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      dynamic productData = snapshot.data;
                      return Card(
                        color: primary,
                        child: SizedBox(
                          height: 210,
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
                                          text: productData['name'],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    // IconButton(
                                    //   onPressed: () {},
                                    //   icon: const Icon(
                                    //     Icons.close,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        productData['img'],
                                        width: 100,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: productData['desc'],
                                            fontSize: 32,
                                            color: Colors.black,
                                            fontFamily: 'Bold',
                                          ),
                                          TextWidget(
                                            text: '₱15.00',
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontFamily: 'Regular',
                                          ),
                                        ],
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
                                      label: 'Mark as Done',
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('Orders')
                                            .doc(data.docs[index].id)
                                            .update({'status': 'Done'});
                                        showToast('Order completed!');
                                      },
                                    ),
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
        });
  }

  Widget done() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Orders')
            .where('sellerId', isEqualTo: userId)
            .where('status', isEqualTo: 'Done')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          return SizedBox(
            height: 500,
            width: double.infinity,
            child: ListView.builder(
              itemCount: data.docs.length,
              itemBuilder: (context, index) {
                return StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Products')
                        .doc(data.docs[index]['productId'])
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: Text('Loading'));
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text('Something went wrong'));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      dynamic productData = snapshot.data;
                      return Card(
                        color: primary,
                        child: SizedBox(
                          height: 210,
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
                                          text: productData['name'],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    // IconButton(
                                    //   onPressed: () {},
                                    //   icon: const Icon(
                                    //     Icons.close,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        productData['img'],
                                        width: 100,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: productData['desc'],
                                            fontSize: 32,
                                            color: Colors.black,
                                            fontFamily: 'Bold',
                                          ),
                                          TextWidget(
                                            text: '₱15.00',
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontFamily: 'Regular',
                                          ),
                                        ],
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
                                      label: 'Completed',
                                      onPressed: () async {},
                                    ),
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
        });
  }
}
