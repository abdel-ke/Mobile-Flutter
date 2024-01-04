import 'package:diary_final_app/components/display_feelings.dart';
import 'package:diary_final_app/components/list_entries.dart';
import 'package:diary_final_app/components/profile_bar.dart';
import 'package:diary_final_app/pages/new_diary.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const ProfileBar(),
        Container(
          color: Colors.grey[300],
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'Your last diary entries',
                style: TextStyle(fontSize: 32),
              ),
              ListEntries(),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          // color: Colors.blue[100],
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Feeling of the day', style: TextStyle(fontSize: 32)),
              DisplayFeelings(),
            ],
          ),
        ),
        const NewDiary(),
      ],
    ));
  }
}
