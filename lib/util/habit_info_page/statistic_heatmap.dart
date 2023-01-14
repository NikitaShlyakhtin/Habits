import 'package:flutter/material.dart';
import 'package:habit_tracker/util/const.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class StatisticHeatmap extends StatelessWidget {
  final List data;
  final Color color;
  const StatisticHeatmap(this.data, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: borderRadius);

    Map<int, Color> colorSet = {1: color};

    Map<DateTime, int> dataSets = {};

    for (int i = 0; i < data.length; i++) {
      DateTime date = DateTime(data[i][0], data[i][1], data[i][2]);
      dataSets[date] = 10;
    }
    return Container(
      decoration: boxDecoration,
      padding: blockPadding,
      child: Column(
        children: [
          const HistoryLabelRow(),
          const Divider(
            thickness: 2,
          ),
          HeatMap(
            datasets: dataSets,
            scrollable: true,
            defaultColor:
                Theme.of(context).colorScheme.surface.withOpacity(0.2),
            // size: 15,
            showText: true,
            fontSize: 12,
            textColor: Colors.white.withOpacity(0.5),
            showColorTip: false,
            colorMode: ColorMode.opacity,
            colorsets: colorSet,
          ),
        ],
      ),
    );
  }
}

class HistoryLabelRow extends StatelessWidget {
  const HistoryLabelRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Text('History',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      Opacity(
        opacity: 0.5,
        child: Text('Drag to see more',
            style: Theme.of(context).textTheme.labelMedium),
      )
    ]);
  }
}
