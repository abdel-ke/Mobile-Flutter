// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudDB {
  add(title, text, icon) async {
    CollectionReference newField =
        FirebaseFirestore.instance.collection('notes');
    try {
      await newField.add({
        'title': title,
        'content': text,
        'icon': icon,
        'username': FirebaseAuth.instance.currentUser!.email,
        'date': Timestamp.now(),
      });
    } catch (e) {
      print('error from add entry: $e');
    }
  }

  delete(username, date) {
    try {
      FirebaseFirestore.instance
          .collection('notes')
          .where('username', isEqualTo: username)
          .where('date', isEqualTo: date)
          .get()
          .then((QuerySnapshot snapshot) {
        String docId = snapshot.docs.first.id;
        FirebaseFirestore.instance
            .collection('notes')
            .doc(docId)
            .delete()
            .then((value) => print('Document deleted'))
            .catchError((error) => print('Failed to delete document: $error'));
      });
    } catch (e) {
      print('error from delete entry: $e');
    }
  }
}
