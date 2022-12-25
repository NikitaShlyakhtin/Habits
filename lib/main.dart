import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habit_tracker/habit.dart';

const borderRadius = BorderRadius.all(Radius.circular(10));

late Box box;

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HabitAdapter());
  box = await Hive.openBox('box');

  runApp(ChangeNotifierProvider(
    create: (context) => HabitList(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blue, brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
          title: 'Habits',
          theme: ThemeData(
            colorScheme: lightColorScheme ?? _defaultLightColorScheme,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
            useMaterial3: true,
          ),
          themeMode: ThemeMode.dark,
          home: const HomePage());
    });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text(
            'Habits',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: const HabitView());
  }
}

class HabitView extends StatelessWidget {
  const HabitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitList>(builder: (context, habitList, child) {
      return ListView.builder(
          itemCount: habitList.getHabits.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == habitList.getHabits.length) {
              return const NewHabitRow();
            } else {
              return HabitTile(habitList.getHabits[index]);
            }
          });
    });
  }
}

class HabitTile extends StatelessWidget {
  final Habit habit;
  const HabitTile(this.habit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: borderRadius),
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          HabitTileText(habit.name, habit.frequency),
          const SizedBox(height: 10),
          HabitTileWeek(habit)
        ],
      ),
    );
  }
}

class HabitTileText extends StatelessWidget {
  final String name;
  final int frequency;
  const HabitTileText(this.name, this.frequency, {super.key});

  String frequencyToString(int n) {
    return n == 7 ? 'Everyday' : '$n times a week';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        Opacity(
            opacity: 0.5,
            child: Text(
              frequencyToString(frequency),
            ))
      ],
    );
  }
}

class HabitTileWeek extends StatelessWidget {
  final Habit habit;
  const HabitTileWeek(this.habit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      for (int index = 0; index < 7; index++) CustomCheckbox(habit, index)
    ]);
  }
}

class CustomCheckbox extends StatefulWidget {
  final Habit habit;
  final int index;
  const CustomCheckbox(this.habit, this.index, {super.key});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  final week = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    var d = DateTime.now();
    var weekDay = d.weekday;
    var dayOfWeek = d.subtract(Duration(days: weekDay - 1)).day + widget.index;
    return Column(
      children: [
        Opacity(
            opacity: 0.5,
            child: Text(
              week[widget.index],
            )),
        SizedBox(
          width: 30,
          height: 30,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                checked = !checked;
                checked ? widget.habit.done++ : widget.habit.done--;
              });
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
              backgroundColor: checked
                  ? stringToColor(widget.habit.color)
                  : Theme.of(context).backgroundColor,
            ),
            child: Text(dayOfWeek.toString(),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground)),
          ),
        )
      ],
    );
  }
}

class NewHabitRow extends StatelessWidget {
  const NewHabitRow({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => const BottomSheet(),
            ),
        icon: const Icon(Icons.add_circle_outline));
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: borderRadius),
              child: const BottomSheetColumn());
        });
  }
}

class BottomSheetColumn extends StatelessWidget {
  const BottomSheetColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 20,
      children: const [
        SheetTitleRow(),
        InputHabitRow(),
        ColorRow(),
        Divider(thickness: 2),
        FrequencyRow(),
        Divider(thickness: 2),
      ],
    );
  }
}

class SheetTitleRow extends StatelessWidget {
  const SheetTitleRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitList>(
      builder: (context, habitList, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  habitList.closeBottomSheet(context);
                },
                child: Opacity(
                    opacity: 0.5,
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                    ))),
            const Text('New habit',
                style: TextStyle(fontWeight: FontWeight.w600)),
            TextButton(
                onPressed: () {
                  habitList.add();
                  habitList.closeBottomSheet(context);
                },
                child: Opacity(
                    opacity: 0.5,
                    child: Text(
                      'Done',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                    ))),
          ],
        );
      },
    );
  }
}

class InputHabitRow extends StatefulWidget {
  const InputHabitRow({super.key});

  @override
  State<InputHabitRow> createState() => _InputHabitRowState();
}

class _InputHabitRowState extends State<InputHabitRow> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitList>(builder: (context, habitList, child) {
      habitList.controller = myController;
      return SizedBox(
        height: 45,
        child: TextField(
          controller: myController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10.0),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceVariant,
              border: const OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide.none,
              ),
              labelText: 'Title'),
        ),
      );
    });
  }
}

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

class HabitList extends ChangeNotifier {
  final NewHabit newHabit = NewHabit();

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
  }

  void saveData() {
    box.clear();
    box.addAll(_habits);
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
