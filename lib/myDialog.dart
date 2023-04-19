// ignore: file_names
import 'package:flutter/material.dart';
import 'package:gpacalculator/sql_helper.dart';
import './CustomCheckBoxDropdownTile.dart';

//second screen
class GPAData {
  final int id;
  final int level;
  final String courseName;
  final double weight;
  String gradingLetter;
  double gradingLetterValue;
  int selected;

  GPAData({
    required this.id,
    required this.level,
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
      id: 0,
      level: 1,
      courseName: 'Programming',
      weight: 3,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: 0),
  GPAData(
      id: 1,
      level: 1,
      courseName: 'DB',
      weight: 3,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: 0),
  GPAData(
      id: 2,
      level: 1,
      courseName: 'Cloud',
      weight: 3,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: 0),
  GPAData(
      id: 3,
      level: 1,
      courseName: 'AI',
      weight: 3,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: 0),
  GPAData(
      id: 4,
      level: 1,
      courseName: 'ML',
      weight: 2,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: 0),
  GPAData(
      id: 5,
      level: 1,
      courseName: 'Data Science',
      weight: 2,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: 0),
  GPAData(
      id: 6,
      level: 1,
      courseName: 'Cyber Security',
      weight: 2,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: 0),
];

List<GPAData> lvl2CourseData = [
  //use to pass selected course weight to main.dart
  GPAData(
      id: 7,
      level: 2,
      courseName: 'Infromation System Modeling',
      weight: 3,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: 0),
  GPAData(
      id: 8,
      level: 2,
      courseName: 'Cloud Computing',
      weight: 3,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: 0),
  GPAData(
      id: 9,
      level: 2,
      courseName: 'Design Patterns',
      weight: 2,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: 0),
  GPAData(
      id: 10,
      level: 2,
      courseName: 'AI',
      weight: 3,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: 0),
  GPAData(
      id: 11,
      level: 2,
      courseName: 'Software Architecture',
      weight: 2,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: 0),
  GPAData(
      id: 12,
      level: 2,
      courseName: 'Mobile Applications Development',
      weight: 2,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: 0),
  GPAData(
      id: 13,
      level: 2,
      courseName: 'Web Development 2',
      weight: 2,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: 0),
];
List<GPAData> lvl3CourseData = [
  //use to pass selected course weight to main.dart
  GPAData(
      id: 14,
      level: 3,
      courseName: 'Big Data',
      weight: 3,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: 0),
];
List<GPAData> lvl4CourseData = [
  //use to pass selected course weight to main.dart
  GPAData(
      id: 15,
      level: 4,
      courseName: 'Image Processing',
      weight: 3,
      gradingLetter: 'X',
      gradingLetterValue: 0,
      selected: 0),
];

List<GPAData> parsingCourseData = [];
int selectedCoursesCount = 0;
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

int maxId = 0;

void handleTabSelection(List<GPAData> lvl1CourseData, lvl2CourseData,
    lvl3CourseData, lvl4CourseData, parsingCourseData) {
  for (int i = 0; i < lvl1CourseData.length; i++) {
    if (lvl1CourseData[i].selected == 1 &&
        !parsingCourseData.contains(lvl1CourseData[i])) {
      parsingCourseData.add(lvl1CourseData[i]);
      // print('inserted data ' + SQLHelper.getItem(0).toString());
      for (int j = 0; j < 1; j++) {
        SQLHelper.createItem(
            lvl1CourseData[i].level,
            lvl1CourseData[i].courseName,
            lvl1CourseData[i].weight,
            lvl1CourseData[i].gradingLetter,
            lvl1CourseData[i].gradingLetterValue,
            1);
        print('Added! $j');
        print(SQLHelper.getItem(j).toString());
      }
    }
  }

  for (int i = 0; i < lvl2CourseData.length; i++) {
    if (lvl2CourseData[i].selected == true &&
        !parsingCourseData.contains(lvl2CourseData[i])) {
      parsingCourseData.add(lvl2CourseData[i]);
      SQLHelper.createItem(
          lvl2CourseData[i].level,
          lvl2CourseData[i].courseName,
          lvl2CourseData[i].weight,
          lvl2CourseData[i].gradingLetter,
          lvl2CourseData[i].gradingLetterValue,
          1);
    }
  }
  for (int i = 0; i < lvl3CourseData.length; i++) {
    if (lvl3CourseData[i].selected == true &&
        !parsingCourseData.contains(lvl3CourseData[i])) {
      parsingCourseData.add(lvl3CourseData[i]);
    }
  }
  for (int i = 0; i < lvl4CourseData.length; i++) {
    if (lvl4CourseData[i].selected == true &&
        !parsingCourseData.contains(lvl4CourseData[i])) {
      parsingCourseData.add(lvl4CourseData[i]);
    }
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
  // late String _newCourseName;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    // _tabController.addListener(_handleTabSelection);
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
              tabs: const [
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
              Center(child: level3Menu()),
              Center(child: level4Menu()),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                addNewCourse(),
                OutlinedButton(
                  onPressed: () {
                    print('yata button eka ebuwa');
                    handleTabSelection(lvl1CourseData, lvl2CourseData,
                        lvl3CourseData, lvl4CourseData, parsingCourseData);
                    Navigator.pop(context, parsingCourseData);
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
                      if (value == 1) {
                        lvl1CourseData[index].gradingLetter =
                            selectedValue; // update grading letter

                        lvl1CourseData[index].gradingLetterValue =
                            _gradingLetterValue(selectedValue);
                      } else {
                        lvl1CourseData[index].selected = 0;
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
                      if (value == 1) {
                        lvl2CourseData[index].gradingLetter =
                            selectedValue; // update grading letter

                        lvl2CourseData[index].gradingLetterValue =
                            _gradingLetterValue(selectedValue);
                      } else {
                        lvl2CourseData[index].selected = 0;
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

  Column level3Menu() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: lvl3CourseData.length,
              itemBuilder: (context, index) {
                return CustomCheckboxDropdownTile(
                  title: lvl3CourseData[index].courseName,
                  value: lvl3CourseData[index].selected,
                  onChanged: (value, selectedValue) {
                    setState(() {
                      lvl3CourseData[index].selected = value!;
                      if (value == 1) {
                        lvl3CourseData[index].gradingLetter =
                            selectedValue; // update grading letter

                        lvl3CourseData[index].gradingLetterValue =
                            _gradingLetterValue(selectedValue);
                      } else {
                        lvl3CourseData[index].selected = 0;
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

  Column level4Menu() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: lvl4CourseData.length,
              itemBuilder: (context, index) {
                return CustomCheckboxDropdownTile(
                  title: lvl4CourseData[index].courseName,
                  value: lvl4CourseData[index].selected,
                  onChanged: (value, selectedValue) {
                    setState(() {
                      lvl4CourseData[index].selected = value!;
                      if (value == 1) {
                        lvl4CourseData[index].gradingLetter =
                            selectedValue; // update grading letter

                        lvl4CourseData[index].gradingLetterValue =
                            _gradingLetterValue(selectedValue);
                      } else {
                        lvl4CourseData[index].selected = 0;
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
        for (var course in lvl1CourseData) {
          //checking for the highest id
          if (course.id > maxId) {
            maxId = course.id;
          }
        }
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
            int selectedLevel = _tabController.index + 1;
            switch (selectedLevel) {
              case 1:
                lvl1CourseData.add(GPAData(
                    id: maxId + 1,
                    level: 1,
                    courseName: value['name'],
                    weight: value['weight'],
                    gradingLetter: 'X',
                    gradingLetterValue: 0,
                    selected: 0));
                break;
              case 2:
                lvl2CourseData.add(GPAData(
                    id: maxId + 1,
                    level: 2,
                    courseName: value['name'],
                    weight: value['weight'],
                    gradingLetter: 'X',
                    gradingLetterValue: 0,
                    selected: 0));
                break;
              case 3:
                lvl3CourseData.add(GPAData(
                    id: maxId + 1,
                    level: 3,
                    courseName: value['name'],
                    weight: value['weight'],
                    gradingLetter: 'X',
                    gradingLetterValue: 0,
                    selected: 0));
                break;
              case 4:
                lvl4CourseData.add(GPAData(
                    id: maxId + 1,
                    level: 4,
                    courseName: value['name'],
                    weight: value['weight'],
                    gradingLetter: 'X',
                    gradingLetterValue: 0,
                    selected: 0));
                break;
              default:
            }
          }
        });
      },
      child: const Icon(Icons.add),
    );
  }
}
