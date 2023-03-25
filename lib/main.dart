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
  var valueToCount = <double>[];
  final dropdownValue = <String, String>{};
  String inputValue = 'made it';
  List<String> items = <String>[];
  List<double> values = <double>[];

  Future<void> _getValue() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyDialog()),
    );
    if (result != null) {
      setState(() {
        final checkBoxItem = result['items'] as List<String>;
        checkBoxValue = result['values'];

        final List<String> checked = checkBoxItem;

        for (int i = 0; i < checked.length; i++) {
          if (!items.contains(checked[i])) {
            items.add(checked[i]);
            values.add(checkBoxValue[i]);
            dropdownValue[checked[i]] = 'A';
            GPAValue = values.reduce((a, b) => a + b);
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
                itemCount: items.length,
                itemBuilder: (context, index) => Dismissible(
                  key: Key(items[index]),
                  onDismissed: (direction) {
                    setState(() {
                      items.removeAt(index);
                      double temp = values[index];
                      values.removeAt(index);
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
                    title: Center(child: Text(items[index])),
                    trailing: DropdownButton<String>(
                      value: dropdownValue[items[index]],
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            dropdownValue[items[index]] = newValue;
                          });
                        }
                      },
                      items: <String>['A', 'B', 'C', 'D', 'F']
                          .map<DropdownMenuItem<String>>((String value) {
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
