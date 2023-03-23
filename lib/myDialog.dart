import 'package:flutter/material.dart';

class MyDialog extends StatefulWidget {
  const MyDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  List<String> checkItems = ['Item 1', 'Item 2', 'Item 3'];
  List<String> checkItemsPass = [];

  List<bool> checked = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select courses'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: checkItems.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(checkItems[index]),
                    value: checked[index],
                    onChanged: (value) {
                      setState(() {
                        checked[index] = value!;
                        // if (checked[index]) {
                        //   checkItemsPass.add(checkItems[index]);
                        // }
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, checked);
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}

// In your button onPressed callback:

