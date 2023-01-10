import 'package:flutter/material.dart';
import 'package:habit_tracker/util/const.dart';
import 'package:habit_tracker/util/habit_info_page/circular_indicator.dart';
import 'package:habit_tracker/widgets/my_vertical_divider.dart';
import 'package:habit_tracker/widgets/title_column.dart';

class StatisticNumbers extends StatelessWidget {
  final double rating;
  final int times;
  final int missed;
  final int month;
  final int total;
  final Color color;
  const StatisticNumbers(
      this.rating, this.times, this.missed, this.month, this.total, this.color,
      {super.key});

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: borderRadius);
    return Container(
      decoration: boxDecoration,
      padding: blockPadding,
      child: IntrinsicHeight(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CircularIndicator(rating, color),
          TitleColumn(primary: '$times', secondary: 'times', big: true),
          const MyVerticalDivider(),
          TitleColumn(primary: '$missed', secondary: 'missed', big: true),
          const MyVerticalDivider(),
          TitleColumn(primary: '$month%', secondary: 'month', big: true),
          const MyVerticalDivider(),
          TitleColumn(primary: '$total%', secondary: 'total', big: true)
        ]),
      ),
    );
  }
}
