import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'styles.dart';

class DatePicker extends StatefulWidget {
  final TextEditingController controller;
  const DatePicker({required this.controller, Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          prefixIcon: const Icon(
            Icons.calendar_today,
            size: 18,
          ),
          hintText: '--/--/--',
          hintStyle: inputHintStyle,
          enabledBorder: inputBorder,
          focusedBorder: inputBorder,
          floatingLabelBehavior: FloatingLabelBehavior.never),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime(1990),
            firstDate: DateTime(1900),
            lastDate: DateTime.now());

        if (pickedDate != null) {
          String formattedDate =
          DateFormat('yyyy-MM-dd').format(pickedDate);

          setState(() {
            widget.controller.text = formattedDate;
          });
        } else {
          print("Date is not selected");
        }
      },
    );
  }
}
