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

  Habit({required this.name, required this.color, required this.frequency});
}
