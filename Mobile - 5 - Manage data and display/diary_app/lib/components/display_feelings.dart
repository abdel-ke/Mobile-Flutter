import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_final_app/components/feeling_of_day.dart';
import 'package:diary_final_app/services/db_service.dart';
import 'package:flutter/material.dart';

class DisplayFeelings extends StatelessWidget {
  const DisplayFeelings({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: CrudDB().getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as QuerySnapshot<Map<String, dynamic>>;
            Map<String, int> feeling = {};
            int count = 0;

            data.docs.map((e) {
              if (feeling.containsKey(e.data()['icon'])) {
                feeling[e.data()['icon']] = feeling[e.data()['icon']]! + 1;
              } else {
                feeling[e.data()['icon']] = 1;
              }
              count++;
            }).toList();
            return SizedBox(
              height: 250,
              child: ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  itemCount: feeling.length,
                  itemBuilder: (context, value) {
                    final percentage =
                        (feeling.values.elementAt(value) / count) * 100;
                    return Container(
                      color: Colors.grey[200],
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text('${percentage.toInt().toString()} %',
                            style: const TextStyle(fontSize: 24)),
                        // subtitle: Text(feeling.values.elementAt(value).toString()),
                        leading: FeelingOfTheDay(
                            feeling: feeling.keys.elementAt(value)),
                      ),
                    );
                  }),
            );
          } else {
            return const Center(
                child: Text('Your diary is empty!',
                    style: TextStyle(fontSize: 28)));
          }
        });
  }
}
