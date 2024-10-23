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
  };

  await docUser.set(json);
}
