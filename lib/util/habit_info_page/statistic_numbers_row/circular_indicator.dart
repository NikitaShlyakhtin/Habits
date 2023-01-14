import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircularIndicator extends StatelessWidget {
  final double value;
  final Color color;
  const CircularIndicator(this.value, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 31,
      lineWidth: 7,
      animation: true,
      percent: value <= 1 ? value : 1,
      center: Text(
        '${double.parse((value * 10).toStringAsFixed(1))}',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      progressColor: color,
      backgroundColor: color.withOpacity(0.2),
      reverse: true,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
