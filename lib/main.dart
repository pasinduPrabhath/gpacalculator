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
  String inputValue = 'made it';
  List<String> items = <String>['A', 'B', 'C', 'D', 'F'];
  Future<void> _getValue() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyDialog()),
    ).then((input) async {
      if (input != null) {
        inputValue = input;
      }
      items.add(inputValue);
      return inputValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    String GPAValue = "0.0";

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
              GPAValue,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) => ListTile(
                  title: Center(child: Text('${index + 1}. ${items[index]}')),

                  // leading: const Icon(Icons.star),
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
