import 'package:diary_final_app/components/my_button.dart';
import 'package:diary_final_app/components/my_textfield.dart';
import 'package:diary_final_app/services/db_service.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';

Map<String, String> list = {
  "excellent": Emojis.starStruck,
  "good": Emojis.smilingFaceWithSmilingEyes,
  "average": Emojis.neutralFace,
  "poor": Emojis.disappointedFace,
  "terrible": Emojis.poutingFace,
};

class NewDiary extends StatefulWidget {
  const NewDiary({super.key});

  @override
  State<NewDiary> createState() => _NewDiaryState();
}

class _NewDiaryState extends State<NewDiary> {
  TextEditingController title = TextEditingController();
  TextEditingController text = TextEditingController();

  String dropdownValue = list.keys.first;

  addNew(context) => showDialog<String>(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('Add an entry'),
            content: SizedBox(
              height: 300,
              child: Column(children: [
                MyTextField(controller: title, hintText: 'Title', margin: 0),
                DropdownButton<String>(
                  icon: const Icon(Icons.arrow_downward),
                  isExpanded: true,
                  alignment: Alignment.center,
                  value: dropdownValue,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.blueAccent,
                  ),
                  items:
                      list.keys.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          Text(list[value]!),
                          const SizedBox(width: 10),
                          Text(value),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                ),
                Flexible(
                  child: TextField(
                    controller: text,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'Text',
                        hintStyle: TextStyle(color: Colors.grey[500])),
                    maxLines: 8,
                  ),
                ),
              ]),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await CrudDB().add(title.text, text.text, dropdownValue);
                  title.clear();
                  text.clear();
                  dropdownValue = list.keys.first;
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, 'OK');
                },
                child: const Text('Add',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          );
        }),
      );

  @override
  Widget build(BuildContext context) {
    return MyButton(onTap: () => addNew(context), title: 'Show Dialog');
  }
}
