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
  var checkBoxValue = <double>[];
  final dropdownValue = <String, String>{};
  List<String> nameOfCourses = <String>[];
  List<double> numOfCredits = <double>[];
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

  //test

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
        final checkBoxItem = result['items'] as List<String>;
        checkBoxValue = result['values'];

        final List<String> checked = checkBoxItem;

        for (int i = 0; i < checked.length; i++) {
          if (!nameOfCourses.contains(checked[i])) {
            nameOfCourses.add(checked[i]);
            numOfCredits.add(checkBoxValue[i]);
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
                itemCount: nameOfCourses.length,
                itemBuilder: (context, index) => Dismissible(
                  key: Key(nameOfCourses[index]),
                  onDismissed: (direction) {
                    setState(() {
                      nameOfCourses.removeAt(index);
                      double temp = numOfCredits[index];
                      numOfCredits.removeAt(index);
                      GPAValue = GPAValue - temp;
                    });
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.startToEnd,
                  child: ListTile(
                    title: Center(child: Text(nameOfCourses[index])),
                    trailing: DropdownButton<String>(
                      value: dropdownValue[nameOfCourses[index]],
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            var temp = index;
                            // double result =
                            //     (courseWeight[index] * gradeValue[newValue]!) /
                            //         courseWeight.length;
                            dropdownValue[nameOfCourses[index]] = newValue;
                            gradingLetterValue = gradeValue[
                                newValue]!; //here we update the gpa according to the letter value
                            // GPAValue += gradingLetterValue;
                            // GPAValue = result;
                          });
                        }
                      },
                      items: //here we pass the Grade value array
                          grades.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
