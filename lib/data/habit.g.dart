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
      id: fields[10] as int,
    )
      ..done = fields[3] as int
      ..doneThisWeek = (fields[4] as List).cast<dynamic>()
      ..doneThisYear = (fields[9] as Map).cast<String, bool>();
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer
      ..writeByte(10)
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
      ..writeByte(6)
      ..write(obj.reminder)
      ..writeByte(7)
      ..write(obj.reminderText)
      ..writeByte(8)
      ..write(obj.time)
      ..writeByte(9)
      ..write(obj.doneThisYear)
      ..writeByte(10)
      ..write(obj.id);
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
