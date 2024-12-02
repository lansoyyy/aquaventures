import 'package:aquaventures/screens/tabs/chat_tab.dart';
import 'package:aquaventures/utils/const.dart';
import 'package:aquaventures/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SellerMessagesTab extends StatelessWidget {
  const SellerMessagesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Users').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            return Expanded(
              child: ListView.builder(
                itemCount: data.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ChatTab(
                                    currentUserId: userId,
                                    receiverId: data.docs[index].id,
                                  )),
                        );
                      },
                      leading: SizedBox(
                        width: 300,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.account_circle_rounded,
                              size: 75,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            TextWidget(
                              text: data.docs[index]['name'],
                              fontSize: 18,
                              color: Colors.black,
                              fontFamily: 'Bold',
                            ),
                            const Expanded(
                              child: SizedBox(
                                width: 20,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_right,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
