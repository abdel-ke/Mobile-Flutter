import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_final_app/components/item_entry.dart';
import 'package:diary_final_app/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _selectedDay = DateTime.now(), _focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 15),
      child: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2010, 10, 20),
            lastDay: DateTime.utc(2040, 10, 20),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            headerStyle: const HeaderStyle(formatButtonVisible: false),
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
          ),
          Expanded(
            child: StreamBuilder(
                stream: CrudDB().getDataByDate(_selectedDay),
                builder: (context, snapshot) {
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
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          DateTime da = data['date'].toDate();
                          return ItemEntry(
                              data: data,
                              day: da.day.toString(),
                              month: da.month,
                              year: da.year.toString());
                        })
                        .toList()
                        .cast<Widget>(),
                  );
                }),
          )
        ],
      ),
    );
  }
}
