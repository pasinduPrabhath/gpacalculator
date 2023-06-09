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

List<GPAData> lvl1CourseData = [];
List<GPAData> lvl2CourseData = [];
List<GPAData> lvl3CourseData = [];
List<GPAData> lvl4CourseData = [];
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
    if (lvl1CourseData[i].selected == 1) {
      if (!parsingCourseData.contains(lvl1CourseData[i])) {
        parsingCourseData.add(lvl1CourseData[i]);

        SQLHelper.createItem(
            lvl1CourseData[i].level,
            lvl1CourseData[i].courseName,
            lvl1CourseData[i].weight,
            lvl1CourseData[i].gradingLetter,
            lvl1CourseData[i].gradingLetterValue,
            1);
      }
    }

    SQLHelper.createItemSecondWindow(
        1,
        lvl1CourseData[i].courseName,
        lvl1CourseData[i].weight,
        lvl1CourseData[i].gradingLetter,
        lvl1CourseData[i].gradingLetterValue,
        1);
  }

  for (int i = 0; i < lvl2CourseData.length; i++) {
    if (lvl2CourseData[i].selected == 1) {
      if (!parsingCourseData.contains(lvl2CourseData[i])) {
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
    SQLHelper.createItemSecondWindow(
        2,
        lvl2CourseData[i].courseName,
        lvl2CourseData[i].weight,
        lvl2CourseData[i].gradingLetter,
        lvl2CourseData[i].gradingLetterValue,
        1);
  }
  for (int i = 0; i < lvl3CourseData.length; i++) {
    if (lvl3CourseData[i].selected == 1 &&
        !parsingCourseData.contains(lvl3CourseData[i])) {
      parsingCourseData.add(lvl3CourseData[i]);
      SQLHelper.createItem(
          lvl3CourseData[i].level,
          lvl3CourseData[i].courseName,
          lvl3CourseData[i].weight,
          lvl3CourseData[i].gradingLetter,
          lvl3CourseData[i].gradingLetterValue,
          1);
    }
    SQLHelper.createItemSecondWindow(
        3,
        lvl3CourseData[i].courseName,
        lvl3CourseData[i].weight,
        lvl3CourseData[i].gradingLetter,
        lvl3CourseData[i].gradingLetterValue,
        1);
  }
  for (int i = 0; i < lvl4CourseData.length; i++) {
    if (lvl4CourseData[i].selected == 1 &&
        !parsingCourseData.contains(lvl4CourseData[i])) {
      parsingCourseData.add(lvl4CourseData[i]);
      SQLHelper.createItem(
          lvl4CourseData[i].level,
          lvl4CourseData[i].courseName,
          lvl4CourseData[i].weight,
          lvl4CourseData[i].gradingLetter,
          lvl4CourseData[i].gradingLetterValue,
          1);
    }
    SQLHelper.createItemSecondWindow(
        4,
        lvl4CourseData[i].courseName,
        lvl4CourseData[i].weight,
        lvl4CourseData[i].gradingLetter,
        lvl4CourseData[i].gradingLetterValue,
        1);
  }
}

List<GPAData> listfromDb = [];
List<Map<String, dynamic>> _dataFromDb = <Map<String, dynamic>>[];

class MyDialog extends StatefulWidget {
  final void Function() refresh;
  const MyDialog({super.key, required String title, required this.refresh});

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
  Future<void> _refresh() async {
    _dataFromDb = await SQLHelper.getItemsSecondWindow();
    listfromDb.clear();
    for (var element in _dataFromDb) {
      listfromDb.add(GPAData(
        id: element['id'],
        level: element['level'],
        courseName: element['courseName'],
        weight: element['courseWeight'],
        gradingLetter: element['gradingLetter'],
        gradingLetterValue: element['gradingLetterValue'],
        selected: element['selected'] == 1 ? 1 : 0,
      ));
    }
    // lvl1CourseData = listfromDb;
    setState(() {
      lvl1CourseData.clear();
      lvl2CourseData.clear();
      lvl3CourseData.clear();
      lvl4CourseData.clear();
      if (listfromDb.length > 0) {
        for (int i = 0; i < listfromDb.length; i++) {
          if (listfromDb[i].level == 1 &&
              !lvl1CourseData.contains(listfromDb[i])) {
            lvl1CourseData.add(listfromDb[i]);
          } else if (listfromDb[i].level == 2 &&
              !lvl2CourseData.contains(listfromDb[i])) {
            lvl2CourseData.add(listfromDb[i]);
          } else if (listfromDb[i].level == 3 &&
              !lvl3CourseData.contains(listfromDb[i])) {
            lvl3CourseData.add(listfromDb[i]);
          } else if (listfromDb[i].level == 4 &&
              !lvl4CourseData.contains(listfromDb[i])) {
            lvl4CourseData.add(listfromDb[i]);
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    setState(() {
      _refresh();
    });
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
                Tab(text: 'Year', icon: Icon(Icons.looks_one_outlined)),
                Tab(text: 'Year', icon: Icon(Icons.looks_two_outlined)),
                Tab(text: 'Year', icon: Icon(Icons.looks_3_outlined)),
                Tab(text: 'Year', icon: Icon(Icons.looks_4_outlined)),
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
                    widget.refresh();
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
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  setState(() {
                    final courseName = lvl1CourseData[index].courseName;
                    SQLHelper.deleteItemSecondWindow(courseName);
                    lvl1CourseData.removeAt(index);
                    _refresh();
                  });
                },
                background: Container(
                  color: Colors.red,
                  child: Icon(Icons.delete, color: Colors.white),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                ),
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return CustomCheckboxDropdownTile(
                      title: lvl1CourseData[index].courseName,
                      value: lvl1CourseData[index].selected,
                      onChanged: (value, selectedValue) {
                        setState(() {
                          lvl1CourseData[index].selected = value!;
                          if (value == 1) {
                            lvl1CourseData[index].gradingLetter = selectedValue;
                            lvl1CourseData[index].gradingLetterValue =
                                _gradingLetterValue(selectedValue);
                          } else {
                            lvl1CourseData[index].selected = 0;
                          }
                        });
                      },
                      options: gradeValue,
                    );
                  },
                ),
              );
            },
          ),
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
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      final courseName = lvl2CourseData[index].courseName;
                      SQLHelper.deleteItemSecondWindow(courseName);
                      lvl2CourseData.removeAt(index);
                      _refresh();
                    });
                  },
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                  ),
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return CustomCheckboxDropdownTile(
                        title: lvl2CourseData[index].courseName,
                        value: lvl2CourseData[index].selected,
                        onChanged: (value, selectedValue) {
                          setState(() {
                            lvl2CourseData[index].selected = value!;
                            if (value == 1) {
                              lvl2CourseData[index].gradingLetter =
                                  selectedValue;
                              lvl2CourseData[index].gradingLetterValue =
                                  _gradingLetterValue(selectedValue);
                            } else {
                              lvl2CourseData[index].selected = 0;
                            }
                          });
                        },
                        options: gradeValue,
                      );
                    },
                  ),
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
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      final courseName = lvl3CourseData[index].courseName;
                      SQLHelper.deleteItemSecondWindow(courseName);
                      lvl3CourseData.removeAt(index);
                      _refresh();
                    });
                  },
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                  ),
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return CustomCheckboxDropdownTile(
                        title: lvl3CourseData[index].courseName,
                        value: lvl3CourseData[index].selected,
                        onChanged: (value, selectedValue) {
                          setState(() {
                            lvl3CourseData[index].selected = value!;
                            if (value == 1) {
                              lvl3CourseData[index].gradingLetter =
                                  selectedValue;
                              lvl3CourseData[index].gradingLetterValue =
                                  _gradingLetterValue(selectedValue);
                            } else {
                              lvl3CourseData[index].selected = 0;
                            }
                          });
                        },
                        options: gradeValue,
                      );
                    },
                  ),
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
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      final courseName = lvl4CourseData[index].courseName;
                      SQLHelper.deleteItemSecondWindow(courseName);
                      lvl4CourseData.removeAt(index);
                      _refresh();
                    });
                  },
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                  ),
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return CustomCheckboxDropdownTile(
                        title: lvl4CourseData[index].courseName,
                        value: lvl4CourseData[index].selected,
                        onChanged: (value, selectedValue) {
                          setState(() {
                            lvl4CourseData[index].selected = value!;
                            if (value == 1) {
                              lvl4CourseData[index].gradingLetter =
                                  selectedValue;
                              lvl4CourseData[index].gradingLetterValue =
                                  _gradingLetterValue(selectedValue);
                            } else {
                              lvl4CourseData[index].selected = 0;
                            }
                          });
                        },
                        options: gradeValue,
                      );
                    },
                  ),
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
