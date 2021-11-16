import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> initSimulator(User user, int code) async {
  final firestore = FirebaseFirestore.instance;
  final ref = firestore.collection('init_connection').doc();
  await ref.set({
    'id': user.uid,
    'code': code,
  });
  return ref.id;
}
