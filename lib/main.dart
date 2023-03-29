import 'package:flutter/material.dart';
import 'myDialog.dart';

void main() {
  runApp(const MyApp());
}

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

//show dialog box
class _MyHomePageState extends State<MyHomePage> {
  // ignore: non_constant_identifier_names
  var GPAValue = 0.0;
  final dropdownValue = <String, String>{};

  Map<String, double> finalSelectedCourseData = <String, double>{};

  List<String> grades = <String>['A', 'B', 'C', 'D', 'F'];
  double gradingLetterValue = 0.0;
  Map<String, double> gradeValue = <String, double>{
    'A': 4.0,
    'B': 3.0,
    'C': 2.0,
    'D': 1.0,
    'F': 0.0
  };

  // double _calculateGPA(double courseWeight, double gradingLetterValue) {
  //   double totalCredits = 0;
  //   double totalGPA = 0;
  //   for (int i = 0; i < nameOfCourses.length; i++) {
  //     if (checkBoxValue[i] != 0) {
  //       totalCredits += courseWeight;
  //       totalGPA += (courseWeight * gradingLetterValue);
  //       print(totalCredits);
  //     }
  //   }
  //   return totalGPA / totalCredits;
  // }

  Future<void> _getValue() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const MyDialog(
                title: '',
              )),
    );
    if (result != null) {
      setState(() {
        Map<String, double> selectedCourseData = result;
        for (int i = 0; i < selectedCourseData.length; i++) {
          if (!finalSelectedCourseData
              .containsKey(selectedCourseData.keys.elementAt(i))) {
            finalSelectedCourseData.addAll(selectedCourseData);
            // dropdownValue[checked[i]];
            // GPAValue = courseWeight.reduce((a, b) => a + b);
          }
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
              GPAValue.toString(),
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                itemCount: finalSelectedCourseData.length,
                itemBuilder: (context, index) => Dismissible(
                  key: Key(finalSelectedCourseData.keys.elementAt(index)),
                  onDismissed: (direction) {
                    setState(() {
                      finalSelectedCourseData.remove(
                          finalSelectedCourseData.keys.elementAt(index));
                      // GPAValue = GPAValue - temp;
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
                          child: Text(
                              finalSelectedCourseData.keys.elementAt(index))),
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
