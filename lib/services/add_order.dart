import 'package:aquaventures/utils/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

Future addOrder(name, sellerId, productId, qty, total) async {
  final docUser = FirebaseFirestore.instance.collection('Orders').doc();

  final json = {
    'name': name,
    'sellerId': sellerId,
    'productId': productId,
    'date': DateTime.now(),
    'uid': userId,
    'price': 15,
    'qty': qty,
    'total': total,
    'status': 'Pending'
  };

  await docUser.set(json);
}
