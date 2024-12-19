import 'package:aquaventures/screens/auth/landing_screen.dart';
import 'package:aquaventures/widgets/admin_drawer_widget.dart';
import 'package:aquaventures/widgets/logout_widget.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminRevenuesScreen extends StatelessWidget {
  const AdminRevenuesScreen({super.key});

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
              TextWidget(
                text: 'Revenues',
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
                            DataColumn(
                              label: TextWidget(
                                text: 'Revenue',
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
                                DataCell(
                                  StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('Orders')
                                          .where('sellerId',
                                              isEqualTo: data.docs[i].id)
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasError) {
                                          print(snapshot.error);
                                          return const Center(
                                              child: Text('Error'));
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Padding(
                                            padding: EdgeInsets.only(top: 50),
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: Colors.black,
                                            )),
                                          );
                                        }

                                        final orderData = snapshot.requireData;
                                        double total = 0;
                                        for (int j = 0;
                                            j < orderData.docs.length;
                                            j++) {
                                          total +=
                                              orderData.docs[j]['qty'] * 15;
                                        }
                                        return TextWidget(
                                          text: 'P ${total.toStringAsFixed(2)}',
                                          fontSize: 14,
                                          color: Colors.green,
                                        );
                                      }),
                                ),
                              ])
                          ]),
                        ),
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
