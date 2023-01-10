import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habit_tracker/data/habit.dart';
import 'package:habit_tracker/data/habit_list.dart';
import 'package:habit_tracker/app.dart';
import 'package:habit_tracker/util/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalNoticeService().setup();

  await Hive.initFlutter();
  Hive.registerAdapter(HabitAdapter());
  Box box = await Hive.openBox('box');

  runApp(ChangeNotifierProvider(
    create: (context) => HabitList(),
    child: const MyApp(),
  ));
}
