import 'package:habit_tracker/data/habit_conversion.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'habit.g.dart';

@HiveType(typeId: 1, adapterName: 'HabitAdapter')
class Habit {
  @HiveField(0)
  String name;

  @HiveField(1)
  String color;

  @HiveField(2)
  int frequency;

  @HiveField(3)
  int done = 0;

  @HiveField(4)
  List doneThisWeek = [false, false, false, false, false, false, false];

  @HiveField(5)
  int startOfCurrentWeek =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)).day;

  @HiveField(6)
  bool reminder = false;

  @HiveField(7)
  String reminderText;

  @HiveField(8)
  String time;

  @HiveField(9)
  Map<String, bool> doneThisYear = {};

  Habit(
      {required this.name,
      required this.color,
      required this.frequency,
      required this.reminder,
      required this.reminderText,
      required this.time});

  int get times {
    int times = 0;
    for (var day in doneThisYear.values) {
      if (day) times++;
    }
    return times;
  }

  int get all {
    int all = doneThisYear.values.length;
    return all;
  }

  int get missed {
    int n = 0;
    for (var day in doneThisYear.values) {
      if (!day) n++;
    }
    int passedWeeks = (all / 7).round();
    int missed = (frequency * passedWeeks) - times;
    return missed > 0 ? missed : 0;
  }

  int get month {
    int monthDone = 0;
    int monthAll = 0;
    DateTime now = DateTime.now();
    DateTime startOfCurrentMonth = DateTime(now.year, now.month, 1);
    Map<DateTime, bool> map = yearMapFromMemory(doneThisYear);
    for (var day in map.keys) {
      if (day.compareTo(startOfCurrentMonth) > 0) {
        monthAll++;
        if (map[day] == true) monthDone++;
      }
    }
    int passedWeeks = (monthAll / 7).round();
    return ((monthDone / (passedWeeks * frequency)) * 100).round();
  }

  int get total {
    int total = 0;
    int passedWeeks = (all / 7).round();
    total = ((times / (passedWeeks * frequency)) * 100).round();
    return total;
  }

  void updateDoneThisYear() {
    Map<DateTime, bool> map = yearMapFromMemory(doneThisYear);
    DateTime now = DateTime.now();
    DateTime now2 = DateTime(now.year, now.month, now.day);
    DateTime monday = now2.subtract(Duration(days: now2.weekday - 1));
    for (int i = 0; i < 7; i++) {
      DateTime nextDay = monday.add(Duration(days: i));
      map[nextDay] = doneThisWeek[i];
    }
    doneThisYear = yearMapToMemory(map);
  }
}
