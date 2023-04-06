// ignore: file_names
import 'package:flutter/material.dart';
import './CustomCheckBoxDropdownTile.dart';

class GPAData {
  final String courseName;
  final double weight;
  String gradingLetter;
  double gradingLetterValue;
  bool selected;

  GPAData({
    required this.courseName,
    required this.weight,
    required this.gradingLetter,
    required this.gradingLetterValue,
    required this.selected,
  });
}

List<GPAData> courseData = [
  //use to pass selected course weight to main.dart
  GPAData(
      courseName: 'Programming',
      weight: 3,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: false),
  GPAData(
      courseName: 'DB',
      weight: 3,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: false),
  GPAData(
      courseName: 'Cloud',
      weight: 3,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: false),
  GPAData(
      courseName: 'AI',
      weight: 3,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: false),
  GPAData(
      courseName: 'ML',
      weight: 2,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: false),
  GPAData(
      courseName: 'Data Science',
      weight: 2,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: false),
  GPAData(
      courseName: 'Cyber Security',
      weight: 2,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: false),
];

_gradingLetterValue(String selectedGradeLetter) {
  if (selectedGradeLetter == 'A+') {
    return 4.0;
  } else if (selectedGradeLetter == 'A') {
    return 4.0;
  } else if (selectedGradeLetter == 'A-') {
    return 3.7;
  } else if (selectedGradeLetter == 'B+') {
    return 3.3;
  } else if (selectedGradeLetter == 'B') {
    return 3.0;
  } else if (selectedGradeLetter == 'B-') {
    return 2.7;
  } else if (selectedGradeLetter == 'C+') {
    return 2.3;
  } else if (selectedGradeLetter == 'C') {
    return 2.0;
  } else if (selectedGradeLetter == 'C-') {
    return 1.7;
  } else if (selectedGradeLetter == 'D+') {
    return 1.3;
  } else if (selectedGradeLetter == 'D') {
    return 1.0;
  } else if (selectedGradeLetter == 'E') {
    return 0.0;
  } else if (selectedGradeLetter == 'X') {
    return 0.01;
  } else {
    return 0.0;
  }
}

class MyDialog extends StatefulWidget {
  const MyDialog({super.key, required String title});

  @override
  // ignore: library_private_types_in_public_api
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  List<String> gradeValue = [
    'A+',
    'A',
    'A-',
    'B+',
    'B',
    'B-',
    'C+',
    'C',
    'C-',
    'D+',
    'D',
    'E',
    'X'
  ];
  late String _newCourseName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.looks_one_outlined)),
                Tab(icon: Icon(Icons.looks_two_outlined)),
                Tab(icon: Icon(Icons.looks_3_outlined)),
                Tab(icon: Icon(Icons.looks_4_outlined)),
              ],
            ),
            title: const Text('Select courses'),
          ),
          body: TabBarView(
            children: [
              Center(child: checklistMenu1()),
              Center(child: checklistMenu1()),
              Icon(Icons.directions_bike),
              Icon(Icons.abc)
            ],
          ),
        ),
      ),
    );
  }

  Column checklistMenu1() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: courseData.length,
            itemBuilder: (context, index) {
              return CustomCheckboxDropdownTile(
                title: courseData[index].courseName,
                value: courseData[index].selected,
                onChanged: (value, selectedValue) {
                  setState(() {
                    courseData[index].selected = value!;
                    if (value) {
                      courseData[index].gradingLetter =
                          selectedValue; // update grading letter
                      courseData[index].gradingLetterValue =
                          _gradingLetterValue(selectedValue);
                    } else {
                      courseData[index].selected = false;
                    }
                  });
                },
                options: gradeValue,
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            addNewCourse(),
            FloatingActionButton(
              onPressed: () {
                Navigator.pop(context, courseData);
              },
              heroTag: 'submitCourse',
              child: const Icon(Icons.done),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
      ],
    );
  }

  FloatingActionButton addNewCourse() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            String courseName = '';
            double? courseWeight;

            return AlertDialog(
              title: const Text('Enter New Course Details'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Course Name',
                    ),
                    onChanged: (value) {
                      courseName = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Course Weight',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      courseWeight = double.tryParse(value);
                    },
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (courseName.isNotEmpty && courseWeight != null) {
                      Map<String, dynamic> courseData = {
                        'name': courseName,
                        'weight': courseWeight,
                      };
                      Navigator.pop(context, courseData);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        ).then((value) {
          // Handle the result here
          if (value != null) {
            // Do something with the added course data
            courseData.add(GPAData(
                courseName: value['name'],
                weight: value['weight'],
                gradingLetter: 'X',
                gradingLetterValue: 0,
                selected: false));
          }
        });
      },
      heroTag: 'addCourse',
      child: const Icon(Icons.add),
    );
  }
}
