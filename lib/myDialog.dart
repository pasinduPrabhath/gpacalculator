import 'package:flutter/material.dart';

class GPAData {
  final String courseName;
  final double weight;
  bool selected;

  GPAData({
    required this.courseName,
    required this.weight,
    required this.selected,
  });
}

class MyDialog extends StatefulWidget {
  const MyDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  List<GPAData> courseData = [
    GPAData(courseName: 'Programming', weight: 1, selected: false),
    GPAData(courseName: 'DB', weight: 2, selected: false),
    GPAData(courseName: 'Cloud', weight: 3, selected: false),
    GPAData(courseName: 'AI', weight: 4, selected: false),
    GPAData(courseName: 'ML', weight: 5, selected: false),
    GPAData(courseName: 'Data Science', weight: 6, selected: false),
    GPAData(courseName: 'Cyber Security', weight: 7, selected: false),
  ];
  List<String> checkedItems = [];
  List<double> checkedItemsValues = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select courses'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: courseData.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(courseData[index].courseName),
                    value: courseData[index].selected,
                    onChanged: (value) {
                      setState(() {
                        courseData[index].selected = value!;
                        if (value) {
                          checkedItems.add(courseData[index].courseName);
                          checkedItemsValues
                              .add(courseData[index].weight.toDouble());
                        } else {
                          checkedItems.remove(courseData[index].courseName);
                          checkedItemsValues
                              .remove(courseData[index].weight.toDouble());
                        }
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'items': checkedItems,
                  'values': checkedItemsValues,
                });
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
