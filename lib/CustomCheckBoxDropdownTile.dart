// ignore: file_names
import 'package:flutter/material.dart';

//second screen widget
class CustomCheckboxDropdownTile extends StatefulWidget {
  final String title;
  final int value;
  final Function(int?, dynamic) onChanged;
  final List<String> options;

  const CustomCheckboxDropdownTile({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.options,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomCheckboxDropdownTileState createState() =>
      _CustomCheckboxDropdownTileState();
}

class _CustomCheckboxDropdownTileState
    extends State<CustomCheckboxDropdownTile> {
  late String _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = 'X';
    ;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.07),
          Expanded(
            flex: 7,
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
                      if (value != 'X') {
                        _selectedOption = value!;
                        widget.onChanged(1,
                            _selectedOption); // Pass two arguments to the callback
                      }
                    });
                  },
                  items: widget.options
                      .map((option) => DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  alignment: FractionalOffset.centerRight,
                  elevation: 8,
                  menuMaxHeight: MediaQuery.of(context).size.height * 0.2,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.13),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
