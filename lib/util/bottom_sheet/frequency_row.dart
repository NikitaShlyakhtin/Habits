import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker/data/habit_list.dart';
import 'package:habit_tracker/util/const.dart';

class FrequencyRow extends StatelessWidget {
  const FrequencyRow({super.key});

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: borderRadius);

    return Consumer<HabitList>(builder: (context, habitList, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('Frequency', style: Theme.of(context).textTheme.titleMedium),
              Opacity(
                  opacity: 0.5,
                  child: Text('Times a week',
                      style: Theme.of(context).textTheme.labelMedium))
            ],
          ),
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: boxDecoration,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: IconButton(
                    onPressed: () {
                      habitList.frequency > 1
                          ? habitList.frequency -= 1
                          : habitList.frequency;
                    },
                    icon: const Icon(Icons.remove)),
              ),
              Text(habitList.frequency.toString(),
                  style: Theme.of(context).textTheme.titleMedium),
              Container(
                width: 40,
                height: 40,
                decoration: boxDecoration,
                margin: const EdgeInsets.only(left: 15),
                child: IconButton(
                    onPressed: () {
                      habitList.frequency < 7
                          ? habitList.frequency++
                          : habitList.frequency;
                    },
                    icon: const Icon(Icons.add)),
              )
            ],
          )
        ],
      );
    });
  }
}
