import 'package:aquaventures/utils/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

Future addProduct(img, name, desc, note) async {
  final docUser = FirebaseFirestore.instance.collection('Products').doc();

  final json = {
    'img': img,
    'name': name,
    'desc': desc,
    'note': note,
    'date': DateTime.now(),
    'uid': userId,
    'ratings': 0,
    'favs': [],
    'price': 15,
    'status': 'Pending',
  };

  await docUser.set(json);
}
