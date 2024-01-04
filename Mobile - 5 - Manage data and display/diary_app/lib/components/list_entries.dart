import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_final_app/components/item_entry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListEntries extends StatelessWidget {
  ListEntries({super.key});
  final _usersStream = FirebaseFirestore.instance
      .collection('notes')
      .where("username", isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .orderBy('date', descending: false)
      .limitToLast(2)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'Your diary is empty!',
              style: TextStyle(fontSize: 28),
            ),
          );
        }
        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children:
              snapshot.data!.docs.reversed.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            DateTime da = data['date'].toDate();
            return ItemEntry(
                data: data,
                day: da.day.toString(),
                month: da.month,
                year: da.year.toString());
          }).toList(),
        );
      },
    );
  }
}
