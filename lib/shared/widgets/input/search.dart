import 'package:besafe/shared/widgets/input/styles.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final VoidCallback onInput;

  const SearchBar({required this.onInput, Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      height: 38,
      child: TextField(
        autofocus: false,
        controller: controller,
        style: searchInputTextStyle,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 9),
          labelText: 'Search',
          labelStyle: searchLabelTextStyle,
          prefixIcon: const Icon(Icons.search, grade: 100, weight: 100,),
          prefixIconColor: searchLabelColor,
          enabledBorder: searchBorderStyle,
          focusedBorder: searchBorderStyle,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }
}
