import 'package:diary_app/components/feeling_of_day.dart';
import 'package:diary_app/models/name_date.dart';
import 'package:diary_app/widgets/display_entry.dart';
import 'package:flutter/material.dart';

class ItemEntry extends StatelessWidget {
  const ItemEntry(
      {super.key,
      required this.data,
      required this.day,
      required this.month,
      required this.year});
  final String day;
  final int month;
  final String year;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DateTime date = data['date'].toDate();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return DisplayEntry(data: data, date: date);
            });
      },
      child: Container(
          color: Colors.grey[200],
          // width: 100,
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      day,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      NameOfDate().monthName[month - 1],
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      year,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                child: FeelingOfTheDay(feeling: data['icon']),
              ),
              const VerticalDivider(
                color: Colors.black,
                width: 20,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                width: 200,
                child: Text(
                  data['content'].length > 80
                      ? data['content'].substring(0, 80) + '...'
                      : data['content'],
                  style: TextStyle(
                      fontSize: data['content'].length > 60 ? 20 : 24),
                ),
              ),
            ],
          )),
    );
  }
}
