import 'package:aquaventures/utils/colors.dart';
import 'package:aquaventures/utils/const.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:aquaventures/widgets/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final searchController = TextEditingController();
  String nameSearched = '';

  int selectedIndex = 0;

  final List<String> filters = ['All'];

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
          dynamic mydata = snapshot.data;
          return Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Image.asset(
                    'assets/images/AquaVentures.png',
                    height: 50,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextWidget(
                    text: 'Order your favorite Purified Drinking Water Now!',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 310,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Regular',
                                  fontSize: 14),
                              onChanged: (value) {
                                setState(() {
                                  nameSearched = value;
                                });
                              },
                              decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Regular', fontSize: 18),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  )),
                              controller: searchController,
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: primary,
                        //     borderRadius: BorderRadius.circular(10),
                        //   ),
                        //   child: IconButton(
                        //     onPressed: () {},
                        //     icon: const Icon(
                        //       Icons.sort,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/Rectangle 58.png',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Products')
                          .where('name',
                              isGreaterThanOrEqualTo:
                                  toBeginningOfSentenceCase(nameSearched))
                          .where('name',
                              isLessThan:
                                  '${toBeginningOfSentenceCase(nameSearched)}z')
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
                          width: double.infinity,
                          height: 300,
                          child: GridView.builder(
                            itemCount: data.docs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Image.network(
                                            data.docs[index]['img'],
                                            width: 150,
                                            height: 105,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextWidget(
                                          text: data.docs[index]['name'],
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: 'Bold',
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 12,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                TextWidget(
                                                  text:
                                                      '${data.docs[index]['ratings']}',
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                if (!mydata['favs'].contains(
                                                    data.docs[index].id)) {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Users')
                                                      .doc(userId)
                                                      .update({
                                                    'favs':
                                                        FieldValue.arrayUnion([
                                                      data.docs[index].id
                                                    ])
                                                  });
                                                  showToast(
                                                      'Added to favorites');
                                                } else {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Users')
                                                      .doc(userId)
                                                      .update({
                                                    'favs':
                                                        FieldValue.arrayRemove([
                                                      data.docs[index].id
                                                    ])
                                                  });
                                                  showToast(
                                                      'Removed from favorites');
                                                }
                                              },
                                              child: Icon(
                                                mydata['favs'].contains(
                                                        data.docs[index].id)
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: Colors.red,
                                                size: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      })
                ],
              ),
            ),
          );
        });
  }
}
