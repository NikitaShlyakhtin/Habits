// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitAdapter extends TypeAdapter<Habit> {
  @override
  final int typeId = 1;

  @override
  Habit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Habit(
      name: fields[0] as String,
      color: fields[1] as String,
      frequency: fields[2] as int,
      reminder: fields[6] as bool,
      reminderText: fields[7] as String,
      time: fields[8] as String,
    )
      ..done = fields[3] as int
      ..doneThisWeek = (fields[4] as List).cast<dynamic>()
      ..startOfCurrentWeek = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.color)
      ..writeByte(2)
      ..write(obj.frequency)
      ..writeByte(3)
      ..write(obj.done)
      ..writeByte(4)
      ..write(obj.doneThisWeek)
      ..writeByte(5)
      ..write(obj.startOfCurrentWeek)
      ..writeByte(6)
      ..write(obj.reminder)
      ..writeByte(7)
      ..write(obj.reminderText)
      ..writeByte(8)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
