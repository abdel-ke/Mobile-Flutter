import 'package:diary_app/pages/new_diary.dart';
import 'package:diary_app/widgets/list_entries.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  logOut() {
    FirebaseAuth.instance.signOut();
  }

  // getdata() {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diary'),
        actions: [
          IconButton(
            onPressed: logOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListEntries(),
            const NewDiary(),
          ],
        ),
      ),
    );
  }
}
