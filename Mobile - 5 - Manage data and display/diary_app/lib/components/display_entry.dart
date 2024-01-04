import 'package:diary_final_app/components/feeling_of_day.dart';
import 'package:diary_final_app/services/name_date.dart';
import 'package:diary_final_app/services/db_service.dart';
import 'package:flutter/material.dart';

class DisplayEntry extends StatelessWidget {
  const DisplayEntry({super.key, required this.data, required this.date});
  final Map<String, dynamic> data;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          '${NameOfDate().dayNames[date.weekday]} ${NameOfDate().monthName[date.month]} ${date.day} ${date.year}'),
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Row(
              children: [
                const Text('My feeling: '),
                FeelingOfTheDay(feeling: data['icon']),
              ],
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Text(data['content'])
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close')),
        TextButton(
          onPressed: () {
            CrudDB().delete(data['username'], data['date']);
            Navigator.pop(context);
          },
          child: const Text('Delete the entry',
              style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
