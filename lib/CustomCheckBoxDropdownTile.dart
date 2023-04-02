// ignore: file_names
import 'package:flutter/material.dart';
import './myDialog.dart';

class CustomCheckboxDropdownTile extends StatefulWidget {
  final String title;
  final bool value;
  final Function(bool?, dynamic)
      onChanged; // Change the callback type to accept two arguments
  final List<String> options;

  const CustomCheckboxDropdownTile({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.options,
  }) : super(key: key);

  @override
  _CustomCheckboxDropdownTileState createState() =>
      _CustomCheckboxDropdownTileState();
}

class _CustomCheckboxDropdownTileState
    extends State<CustomCheckboxDropdownTile> {
  late String _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = 'F';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(widget.title),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                DropdownButton<String>(
                  value: _selectedOption,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedOption = value!;
                      widget.onChanged(true,
                          _selectedOption); // Pass two arguments to the callback
                      print(_selectedOption);
                    });
                  },
                  items: widget.options
                      .map((option) => DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.17),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
