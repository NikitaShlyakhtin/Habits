import 'package:flutter/material.dart';

class TitleColumn extends StatelessWidget {
  final String primary;
  final String secondary;
  const TitleColumn(
      {required this.primary, required this.secondary, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(primary, style: Theme.of(context).textTheme.titleMedium),
        Opacity(
            opacity: 0.5,
            child:
                Text(secondary, style: Theme.of(context).textTheme.labelMedium))
      ],
    );
  }
}
