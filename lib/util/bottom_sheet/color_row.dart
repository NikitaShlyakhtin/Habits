import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker/data/habit_list.dart';

class ColorRow extends StatefulWidget {
  const ColorRow({super.key});

  @override
  State<ColorRow> createState() => _ColorRowState();
}

class _ColorRowState extends State<ColorRow> {
  int value = 0;

  Widget customRadioButton(color, int index) {
    return Consumer<HabitList>(
      builder: (context, habitList, child) {
        return SizedBox(
          width: 30,
          height: 30,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                value = index;
                habitList.color = color;
              });
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
              backgroundColor: color,
            ),
            child: Icon((value == index) ? Icons.check : null,
                color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var colors = [
      Colors.red[400],
      Colors.yellow[400],
      Colors.green[400],
      Colors.blue[400],
      Colors.purple[400],
      Colors.brown[400],
      Colors.grey[400]
    ];
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      for (int i = 1; i < 8; i++) customRadioButton(colors[i - 1], i)
    ]);
  }
}
