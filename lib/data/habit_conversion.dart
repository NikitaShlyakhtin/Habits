import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit.dart';

Color stringToColor(String s) {
  return Color(int.parse(s, radix: 16));
}

String colorToString(Color? c) {
  return c.toString().split('(0x')[1].split(')')[0];
}

String timeToString(TimeOfDay time) {
  final hours = time.hour.toString().padLeft(2, '0');
  final minutes = time.minute.toString().padLeft(2, '0');
  return '$hours:$minutes';
}

TimeOfDay stringToTime(String time) {
  var s = time.split(":");
  final hours = int.parse(s[0]);
  final minutes = int.parse(s[1]);
  return TimeOfDay(hour: hours, minute: minutes);
}

DateTime stringToDate(String dateString) {
  DateTime date = DateTime.parse(dateString);
  return date;
}

String dateToString(DateTime date) {
  String dateString = date.toString();
  return dateString;
}

Map<DateTime, bool> yearMapFromMemory(Map<String, bool> savedMap) {
  Map<DateTime, bool> yearMap = {};
  for (var k in savedMap.keys) {
    yearMap[stringToDate(k)] = savedMap[k]!;
  }
  return yearMap;
}

Map<String, bool> yearMapToMemory(Map<DateTime, bool> yearMap) {
  Map<String, bool> savedMap = {};
  for (var k in yearMap.keys) {
    savedMap[dateToString(k)] = yearMap[k]!;
  }
  return savedMap;
}

List convertForHeatmap(Map<String, bool> savedMap) {
  Map<DateTime, bool> yearMap = yearMapFromMemory(savedMap);
  List data = [];
  for (var day in yearMap.keys) {
    if (yearMap[day] == true) {
      data.add([day.year, day.month, day.day]);
    }
  }
  return data;
}

List<double> convertForGraph(Habit habit) {
  List<double> data = [];
  for (int i = 0; i < 12; i++) {
    int monthDone = 0;
    int monthAll = 0;
    DateTime now = DateTime.now().subtract(Duration(days: 31 * i));
    DateTime startOfCurrentMonth = DateTime(now.year, now.month, 1);
    DateTime endOfCurrentMonth = DateTime(now.year, now.month + 1, 0);
    Map<DateTime, bool> map = yearMapFromMemory(habit.doneThisYear);
    bool flag = false;
    for (var day in map.keys) {
      if (day.compareTo(startOfCurrentMonth) >= 0 &&
          day.compareTo(endOfCurrentMonth) <= 0) {
        monthAll++;
        flag = true;
        if (map[day] == true) monthDone++;
      }
    }

    if (flag) {
      int passedWeeks = (monthAll / 7).ceil();

      double n = ((monthDone / (passedWeeks * habit.frequency)) * 100);
      data.add(n > 100 ? 100 : n);
    } else {
      data.add(0);
    }
  }
  return data.reversed.toList();
}
