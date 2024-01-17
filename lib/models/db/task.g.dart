part of 'task.dart';

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 8;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      taskId: fields[0] as String,
      taskName: fields[1] as String,
      path: fields[2] as String,
      files: (fields[3] as List).cast<String>(),
      urls: (fields[4] as List).cast<String>(),
      index: fields[5] as int,
      total: fields[6] as int,
      status: fields[7] as int,
      createdAt: fields[8] as int,
      seqNo: fields[9] as int,
      types: (fields[10] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.taskId)
      ..writeByte(1)
      ..write(obj.taskName)
      ..writeByte(2)
      ..write(obj.path)
      ..writeByte(3)
      ..write(obj.files)
      ..writeByte(4)
      ..write(obj.urls)
      ..writeByte(5)
      ..write(obj.index)
      ..writeByte(6)
      ..write(obj.total)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.seqNo)
      ..writeByte(10)
      ..write(obj.types);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
