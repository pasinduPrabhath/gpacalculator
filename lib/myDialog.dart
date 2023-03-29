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
  const MyDialog({super.key, required String title});

  @override
  // ignore: library_private_types_in_public_api
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  List<GPAData> courseData = [
    //use to pass selected course weight to main.dart
    GPAData(courseName: 'Programming', weight: 3, selected: false),
    GPAData(courseName: 'DB', weight: 3, selected: false),
    GPAData(courseName: 'Cloud', weight: 3, selected: false),
    GPAData(courseName: 'AI', weight: 3, selected: false),
    GPAData(courseName: 'ML', weight: 2, selected: false),
    GPAData(courseName: 'Data Science', weight: 2, selected: false),
    GPAData(courseName: 'Cyber Security', weight: 2, selected: false),
  ];
  // List<String> checkedItems = [];
  // List<double> checkedItemsValues = [];

  Map<String, double> selectedCourseData = <String, double>{};

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
              return CheckboxListTile(
                title: Text(courseData[index].courseName),
                value: courseData[index].selected,
                onChanged: (value) {
                  setState(() {
                    courseData[index].selected = value!;
                    if (value) {
                      // checkedItems.add(courseData[index].courseName);
                      // checkedItemsValues
                      //     .add(courseData[index].weight.toDouble());
                      selectedCourseData[courseData[index].courseName] =
                          courseData[index].weight.toDouble();
                    } else {
                      // checkedItems.remove(courseData[index].courseName);
                      // checkedItemsValues
                      //     .remove(courseData[index].weight.toDouble());
                      selectedCourseData.remove(courseData[index].courseName);
                    }
                  });
                },
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, selectedCourseData);
          },
          child: const Text('Done'),
        ),
      ],
    );
  }
}

// trailing: DropdownButton<String>(
//                         value: dropdownValue[nameOfCourses[index]],
//                         onChanged: (String? newValue) {
//                           if (newValue != null) {
//                             setState(() {
//                               var temp = index;
//                               // double result =
//                               //     (courseWeight[index] * gradeValue[newValue]!) /
//                               //         courseWeight.length;
//                               dropdownValue[nameOfCourses[index]] = newValue;
//                               gradingLetterValue = gradeValue[
//                                   newValue]!; //here we update the gpa according to the letter value
//                               // GPAValue += gradingLetterValue;
//                               // GPAValue = result;
//                             });
//                           }
//                         },
//                         items: //here we pass the Grade value array
//                             grades
//                                 .map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                       ),
//  {
//               'items': checkedItems,
//               'values': checkedItemsValues,
//             }