import 'package:flutter/material.dart';
import 'package:habit_tracker/util/const.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController myController;
  final String placeholder;
  final bool enabled;
  const MyTextField(
      {required this.myController,
      required this.placeholder,
      required this.enabled,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextField(
        enabled: enabled,
        controller: myController,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceVariant,
            border: const OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide.none,
            ),
            labelText: placeholder),
      ),
    );
  }
}
