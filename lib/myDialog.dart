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

List<GPAData> selectedCourseData = [];
bool doesSelected = false;

_gradingLetterValue(String selectedGradeLetter) {
  if (selectedGradeLetter == 'A') {
    return 4.0;
  } else if (selectedGradeLetter == 'B') {
    return 3.0;
  } else if (selectedGradeLetter == 'C') {
    return 2.0;
  } else if (selectedGradeLetter == 'D') {
    return 1.0;
  } else if (selectedGradeLetter == 'F') {
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
  Map<String, double> gradeValue = <String, double>{
    'A': 4.0,
    'B': 3.0,
    'C': 2.0,
    'D': 1.0,
    'F': 0.0,
    'X': 0.0
  };

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
        Expanded(
          child: ListView.builder(
            itemCount: courseData.length,
            itemBuilder: (context, index) {
              return CustomCheckboxDropdownTile(
                title: courseData[index].courseName,
                value: courseData[index].selected,
                onChanged: (value, selectedValue) {
                  // Accept two arguments
                  setState(() {
                    courseData[index].selected = value!;
                    if (value) {
                      // courseData[index].selected = true;

                      courseData[index].gradingLetter =
                          selectedValue; // update grading letter
                      courseData[index].gradingLetterValue =
                          _gradingLetterValue(selectedValue);
                    } else {
                      courseData[index].selected = false;
                    }
                  });
                },
                options: gradeValue.keys.toList(),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, courseData);
          },
          child: const Text('Done'),
        ),
      ],
    );
  }
}
