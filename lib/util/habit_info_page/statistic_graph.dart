import 'package:flutter/material.dart';
import 'package:habit_tracker/util/const.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:habit_tracker/widgets/gap.dart';

class StatisticGraph extends StatefulWidget {
  final List<double> data;
  final Color color;
  const StatisticGraph(this.data, this.color, {super.key});

  @override
  State<StatisticGraph> createState() => _StatisticGraphState();
}

class _StatisticGraphState extends State<StatisticGraph> {
  get spots =>
      [for (double i = 0; i < 12; i++) FlSpot(i, widget.data[i.toInt()])];

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: borderRadius);

    return Container(
      decoration: boxDecoration,
      padding: blockPadding,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Statistic',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color:
                        Theme.of(context).colorScheme.surface.withOpacity(0.2)),
                height: 35,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: const [
                    Text(
                      'Last year',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Icon(Icons.expand_more)
                  ],
                ),
              )
            ],
          ),
          const Gap(),
          AspectRatio(
            aspectRatio: 1.7,
            child: LineChart(
              mainData(),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    value++;
    var style = Theme.of(context).textTheme.labelMedium;
    Widget text;

    String s = value > 9 ? value.toInt().toString() : '0${value.toInt()}';
    text = Opacity(opacity: 0.5, child: Text(s, style: style));

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    var style = Theme.of(context).textTheme.labelMedium;
    String text;

    int intValue = value.toInt();

    if (intValue <= 0) {
      text = '';
    } else if (intValue <= 20) {
      text = '20%';
    } else if (intValue <= 40) {
      text = '40%';
    } else if (intValue <= 60) {
      text = '60%';
    } else if (intValue <= 80) {
      text = '80%';
    } else {
      text = '100%';
    }

    return Opacity(
        opacity: 0.5,
        child: Text(text, style: style, textAlign: TextAlign.left));
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 16,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Theme.of(context).dividerColor,
            strokeWidth: 2,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 20,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 40,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: widget.color,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  widget.color.withOpacity(0.6),
                  widget.color.withOpacity(0)
                ]),
          ),
        ),
      ],
    );
  }
}
