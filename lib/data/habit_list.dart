import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habit_tracker/data/habit.dart';

class HabitList extends ChangeNotifier {
  final NewHabit newHabit = NewHabit();
  final box = Hive.box('box');

  List<Habit> _habits = [];

  HabitList() {
    if (box.values.toList().isEmpty) {
      createInitialData();
    } else {
      loadData();
    }
  }

  List<Habit> get getHabits => (_habits);

  set controller(controller) => (newHabit.controller = controller);

  set color(color) {
    newHabit.color = color;
  }

  int get frequency => (newHabit.frequency);

  set frequency(int n) {
    newHabit.frequency = n;
    notifyListeners();
  }

  void closeBottomSheet(context) {
    newHabit.controller?.text = '';
    newHabit.frequency = 3;
    Navigator.of(context).pop();
  }

  void add() {
    String title = newHabit.controller?.text ?? '';
    int frequency = newHabit.frequency;
    Color? color = newHabit.color;
    _habits.add(
        Habit(name: title, frequency: frequency, color: colorToString(color)));
    saveData();
    notifyListeners();
  }

  void createInitialData() {
    _habits = [
      Habit(
          name: 'Reading', color: colorToString(Colors.red[400]), frequency: 7),
      Habit(name: 'Sport', color: colorToString(Colors.blue[400]), frequency: 3)
    ];
  }

  void loadData() {
    _habits = box.values.toList().cast<Habit>();
    updateWeek();
  }

  void saveData() {
    box.clear();
    box.addAll(_habits);
  }

  void updateWeek() {
    DateTime d = DateTime.now();
    int weekDay = d.weekday;
    int startOfCurrentWeek = d.subtract(Duration(days: weekDay - 1)).day;
    if (_habits[0].startOfCurrentWeek != startOfCurrentWeek) {
      for (var element in _habits) {
        element.doneThisWeek = [for (int i = 0; i < 7; i++) false];
        element.startOfCurrentWeek = startOfCurrentWeek;
      }
    }
    saveData();
  }
}

class NewHabit {
  TextEditingController? controller;
  int frequency = 3;
  Color? color = Colors.red[400];
}

Color stringToColor(String s) {
  return Color(int.parse(s, radix: 16));
}

String colorToString(Color? c) {
  return c.toString().split('(0x')[1].split(')')[0];
}
