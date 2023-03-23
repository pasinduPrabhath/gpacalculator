import 'package:flutter/material.dart';

class MyDialog extends StatefulWidget {
  const MyDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  List<String> checkListItems = ['Apple', 'Vodafone', 'Oneplus'];
  List<double> checkListItemValues = [1, 2, 3];
  List<String> checkedItems = [];
  List<double> checkedItemsValues = [];
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
                itemCount: checkListItems.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(checkListItems[index]),
                    value: checked[index],
                    onChanged: (value) {
                      setState(() {
                        checked[index] = value!;
                        if (checked[index] == true) {
                          checkedItems.add(checkListItems[index]);
                          checkedItemsValues.add(checkListItemValues[index]);
                        } else {
                          checkedItems.remove(checkListItems[index]);
                          checkedItemsValues.remove(checkListItemValues[index]);
                        }
                      });
                      // checkedItems.add(checkListItems[index]);
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'items': checkedItems,
                  'values': checkedItemsValues,
                });
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

