// ignore: file_names
import 'package:flutter/material.dart';
import 'package:gpacalculator/main.dart';
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

List<GPAData> lvl1CourseData = [
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

List<GPAData> lvl2CourseData = [
  //use to pass selected course weight to main.dart
  GPAData(
      courseName: 'Infromation System Modeling',
      weight: 3,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: false),
  GPAData(
      courseName: 'Cloud Computing',
      weight: 3,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: false),
  GPAData(
      courseName: 'Design Patterns',
      weight: 2,
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
      courseName: 'Software Architecture',
      weight: 2,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: false),
  GPAData(
      courseName: 'Mobile Applications Development',
      weight: 2,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: false),
  GPAData(
      courseName: 'Web Development 2',
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

class _MyDialogState extends State<MyDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
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
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      // Update the selected tab index here
      // You can get the selected tab index from _tabController.index
      if (_tabController.index != _tabController.previousIndex) {
        print('tab index is changing');
        // if (_tabController.previousIndex == 0) {
        //   Navigator.pop(context, lvl1CourseData);
        // } else if (_tabController.previousIndex == 1) {
        //   Navigator.pop(context, lvl2CourseData);
        // }
      }
      print('tab index: ${_tabController.index}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              controller: _tabController,
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
            controller: _tabController,
            children: [
              Center(child: level1Menu()),
              Center(child: level2Menu()),
              Icon(Icons.directions_bike),
              Icon(Icons.abc)
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                addNewCourse(),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, lvl1CourseData);
                  },
                  child: const Icon(Icons.done_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column level1Menu() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: lvl1CourseData.length,
              itemBuilder: (context, index) {
                return CustomCheckboxDropdownTile(
                  title: lvl1CourseData[index].courseName,
                  value: lvl1CourseData[index].selected,
                  onChanged: (value, selectedValue) {
                    setState(() {
                      lvl1CourseData[index].selected = value!;
                      if (value) {
                        lvl1CourseData[index].gradingLetter =
                            selectedValue; // update grading letter

                        lvl1CourseData[index].gradingLetterValue =
                            _gradingLetterValue(selectedValue);
                      } else {
                        lvl1CourseData[index].selected = false;
                      }
                    });
                  },
                  options: gradeValue,
                );
              }),
        ),
      ],
    );
  }

  Column level2Menu() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: lvl2CourseData.length,
              itemBuilder: (context, index) {
                return CustomCheckboxDropdownTile(
                  title: lvl2CourseData[index].courseName,
                  value: lvl2CourseData[index].selected,
                  onChanged: (value, selectedValue) {
                    setState(() {
                      lvl2CourseData[index].selected = value!;
                      if (value) {
                        lvl2CourseData[index].gradingLetter =
                            selectedValue; // update grading letter

                        lvl2CourseData[index].gradingLetterValue =
                            _gradingLetterValue(selectedValue);
                      } else {
                        lvl2CourseData[index].selected = false;
                      }
                    });
                  },
                  options: gradeValue,
                );
              }),
        ),
      ],
    );
  }

  OutlinedButton addNewCourse() {
    return OutlinedButton(
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
            // finalSelectedCourseDataList.add(value);
            lvl1CourseData.add(GPAData(
                courseName: value['name'],
                weight: value['weight'],
                gradingLetter: 'X',
                gradingLetterValue: 0,
                selected: false));
          }
        });
      },
      child: const Icon(Icons.add),
    );
  }
}
