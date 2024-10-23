import 'package:aquaventures/utils/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

Future addSeller(name, email, address, number, stationName) async {
  final docUser = FirebaseFirestore.instance.collection('Seller').doc(userId);

  final json = {
    'name': name,
    'number': number,
    'stationName': stationName,
    'address': address,
    'email': email,
    'id': docUser.id,
    'isVerified': false,
    'favs': [],
    'profile': '',
  };

  await docUser.set(json);
}
