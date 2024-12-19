import 'package:aquaventures/screens/auth/landing_screen.dart';
import 'package:aquaventures/widgets/admin_drawer_widget.dart';
import 'package:aquaventures/widgets/logout_widget.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminDrawerWidget(),
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: TextWidget(
          text: 'ADMIN',
          fontSize: 18,
          color: Colors.white,
          fontFamily: 'Bold',
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              logout(context, const LandingScreen());
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
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
                        return Card(
                          elevation: 3,
                          child: SizedBox(
                            width: 150,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextWidget(
                                  text: data.docs.length.toString(),
                                  fontSize: 50,
                                  fontFamily: 'Bold',
                                  color: Colors.blue,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.groups_2_outlined,
                                      size: 25,
                                      color: Colors.blue,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    TextWidget(
                                      text: 'Users',
                                      fontSize: 18,
                                      fontFamily: 'Bold',
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .where('type', isEqualTo: 'Organizer')
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
                        return Card(
                          elevation: 3,
                          child: SizedBox(
                            width: 150,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextWidget(
                                  text: data.docs.length.toString(),
                                  fontSize: 50,
                                  fontFamily: 'Bold',
                                  color: Colors.blue,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.event,
                                      size: 25,
                                      color: Colors.blue,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    TextWidget(
                                      text: 'Event Organizer',
                                      fontSize: 12,
                                      fontFamily: 'Bold',
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                text: 'Active Merchants',
                fontSize: 18,
                fontFamily: 'Bold',
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Seller')
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
                    return Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(columns: [
                          DataColumn(
                            label: TextWidget(
                              text: 'ID',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          DataColumn(
                            label: TextWidget(
                              text: 'Name',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          DataColumn(
                            label: TextWidget(
                              text: 'Station Name',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          DataColumn(
                            label: TextWidget(
                              text: 'Station Address',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ], rows: [
                          for (int i = 0; i < data.docs.length; i++)
                            DataRow(cells: [
                              DataCell(
                                TextWidget(
                                  text: '${i + 1}',
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              DataCell(
                                TextWidget(
                                  text: data.docs[i]['name'],
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              DataCell(
                                TextWidget(
                                  text: data.docs[i]['stationName'],
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              DataCell(
                                TextWidget(
                                  text: data.docs[i]['address'],
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ])
                        ]),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
