// ignore: file_names
import 'package:flutter/material.dart';
import './myDialog.dart';

class CustomCheckboxDropdownTile extends StatefulWidget {
  final String title;
  final bool value;
  final Function(bool?) onChanged;
  final List<String> options;

  const CustomCheckboxDropdownTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.options,
  });

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
    _selectedOption = widget.options[0];
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              widget.title,
            ),
          ),

          Expanded(
            flex: 2,
            child: DropdownButton(
              value: _selectedOption,
              onChanged: (String? value) {
                setState(() {
                  _selectedOption = value!;
                  selectedGradeLetter = _selectedOption;
                });
              },
              items: widget.options
                  .map((option) => DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      ))
                  .toList(),
            ),
          ),
          // SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Checkbox(
              value: widget.value,
              onChanged: widget.onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
