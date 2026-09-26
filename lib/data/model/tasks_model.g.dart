// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TasksModelAdapter extends TypeAdapter<TasksModel> {
  @override
  final int typeId = 1;

  @override
  TasksModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TasksModel(
      taskName: fields[0] as String,
      taskDescription: fields[1] as String,
      Status: fields[2] as StatusTask,
      colorHex: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TasksModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.taskName)
      ..writeByte(1)
      ..write(obj.taskDescription)
      ..writeByte(2)
      ..write(obj.Status)
      ..writeByte(3)
      ..write(obj.colorHex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasksModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StatusTaskAdapter extends TypeAdapter<StatusTask> {
  @override
  final int typeId = 2;

  @override
  StatusTask read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return StatusTask.done;
      case 1:
        return StatusTask.pending;
      case 2:
        return StatusTask.inProgress;
      default:
        return StatusTask.done;
    }
  }

  @override
  void write(BinaryWriter writer, StatusTask obj) {
    switch (obj) {
      case StatusTask.done:
        writer.writeByte(0);
        break;
      case StatusTask.pending:
        writer.writeByte(1);
        break;
      case StatusTask.inProgress:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
