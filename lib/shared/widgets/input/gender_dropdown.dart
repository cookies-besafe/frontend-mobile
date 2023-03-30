import 'package:flutter/material.dart';

import 'styles.dart';

const List<String> list = <String>['Male', 'Female', 'Prefer not to say'];

class GenderDropdown extends StatefulWidget {
  String genderValue = '';

  GenderDropdown({super.key});

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.genderValue.isNotEmpty ? widget.genderValue : null,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      hint: const Text('Select', style: inputHintStyle),
      style: inputHintStyle,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          hintStyle: inputHintStyle,
          enabledBorder: inputBorder,
          focusedBorder: inputBorder,
          floatingLabelBehavior: FloatingLabelBehavior.never),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          widget.genderValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
