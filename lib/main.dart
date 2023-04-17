import 'package:flutter/material.dart';
import 'package:gpacalculator/sql_helper.dart';
import 'myDialog.dart';

void main() {
  runApp(const MyApp());
}

//this is the main screen
List<GPAData> finalSelectedCourseDataList = <GPAData>[];
//new database List map

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gpa Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'GPA Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//show dialog box 1....
class _MyHomePageState extends State<MyHomePage> {
  // ignore: non_constant_identifier_names
  var GPAValue = 0.0;
  final dropdownValue = <String, String>{};
  String selectedGradeLetter = 'A';

  double gradingLetterValue = 0.0;

  double _calculateGPA(List<GPAData> finalSelectedCourseData) {
    double totalCredits = 0;
    double weightedGradePoints = 0;
    for (int i = 0; i < finalSelectedCourseData.length; i++) {
      if (finalSelectedCourseData[i].courseName != '') {
        totalCredits += finalSelectedCourseData[i].weight;
        weightedGradePoints += finalSelectedCourseData[i].weight *
            finalSelectedCourseData[i].gradingLetterValue;
      }
      GPAValue = weightedGradePoints / totalCredits;
    }
    return GPAValue;
  }

  List<Map<String, dynamic>>? _newDatabaseListMap = <Map<String, dynamic>>[];
  bool _isLoading = false;
  void _refresh() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _newDatabaseListMap = data;
      _isLoading = false;
    });
  }

  Future<void> _getValue() async {
    SQLHelper.createItem(1, 'test1', 3.0, 'A', 2.7, 1);
    print(SQLHelper.getItems());
    _refresh();
    print('..... no of itmes in db ${_newDatabaseListMap!.length}');
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const MyDialog(
                title: '',
              )),
    );
    if (result != null) {
      setState(() {
        List<GPAData> selectedCourseData = result;
        for (int i = 0; i < selectedCourseData.length; i++) {
          if (selectedCourseData[i].selected == true &&
              selectedCourseData[i].gradingLetter != 'X' &&
              !finalSelectedCourseDataList.contains(selectedCourseData[i])) {
            finalSelectedCourseDataList.add(selectedCourseData[i]);
          }
          _calculateGPA(finalSelectedCourseDataList);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: const SizedBox(),
            ),
            Text(
              GPAValue.toStringAsFixed(2),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const Text(
              'Courses List',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  itemCount: finalSelectedCourseDataList.length,
                  itemBuilder: (context, index) => Dismissible(
                    key: Key(finalSelectedCourseDataList[index].courseName),
                    onDismissed: (direction) {
                      setState(() {
                        finalSelectedCourseDataList[index].selected = false;

                        finalSelectedCourseDataList
                            .remove(finalSelectedCourseDataList[index]);

                        if (finalSelectedCourseDataList.isEmpty) {
                          GPAValue = 0.0;
                        }
                        _calculateGPA(finalSelectedCourseDataList);
                      });
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.startToEnd,
                    child: Card(
                      child: ListTile(
                        title: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.06,
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '${finalSelectedCourseDataList[index].courseName}   (${finalSelectedCourseDataList[index].weight.toInt()} Credits)',
                                ),
                              ),
                              Container(
                                constraints: const BoxConstraints(
                                  minWidth: 35, // set a minimum width
                                  maxWidth: 35, // set a maximum width
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: double.minPositive,
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0, top: 2.0, bottom: 2),
                                child: Center(
                                  child: Text(
                                    finalSelectedCourseDataList[index]
                                        .gradingLetter,
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.08,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getValue,
        tooltip: 'Add Value',
        child: const Icon(Icons.add),
      ),
    );
  }
}
