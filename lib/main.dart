import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habit_tracker/data/habit.dart';
import 'package:habit_tracker/data/habit_list.dart';
import 'package:habit_tracker/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:habit_tracker/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(HabitAdapter());
  Box box = await Hive.openBox('box');

  runApp(ChangeNotifierProvider(
    create: (context) => HabitList(),
    child: const MyApp(),
  ));
}
