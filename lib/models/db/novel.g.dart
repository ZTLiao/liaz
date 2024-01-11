part of 'novel.dart';

class NovelAdapter extends TypeAdapter<Novel> {

  @override
  final int typeId = 7;

  @override
  Novel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Novel(
      novelId: fields[0] as int,
      title: fields[1] as String,
      cover: fields[2] as String,
      categories: fields[3] as String,
      authors: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Novel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.novelId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.cover)
      ..writeByte(3)
      ..write(obj.categories)
      ..writeByte(4)
      ..write(obj.authors);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NovelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
