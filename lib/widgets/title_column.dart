import 'package:flutter/material.dart';

class TitleColumn extends StatelessWidget {
  final String primary;
  final String secondary;
  final bool big;
  const TitleColumn(
      {required this.primary,
      required this.secondary,
      this.big = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(primary,
            style: big
                ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                : Theme.of(context).textTheme.titleMedium),
        Opacity(
            opacity: 0.5,
            child:
                Text(secondary, style: Theme.of(context).textTheme.labelMedium))
      ],
    );
  }
}
