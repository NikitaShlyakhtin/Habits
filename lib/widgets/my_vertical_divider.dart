import 'package:flutter/material.dart';

class MyVerticalDivider extends StatelessWidget {
  const MyVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      thickness: 2,
      indent: 15,
      endIndent: 15,
      color: Theme.of(context).dividerColor,
    );
  }
}
