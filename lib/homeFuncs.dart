import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

DocumentSnapshot userDoc;
getUserDoc() async {
  final user = await FirebaseAuth.instance.currentUser();
  var query = await Firestore.instance
      .collection('Users')
      .where('email', isEqualTo: user.email)
      .limit(1)
      .getDocuments();
  userDoc = query.documents.first;
}
