part of 'comic.dart';

class ComicAdapter extends TypeAdapter<Comic> {
  @override
  final int typeId = 6;

  @override
  Comic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Comic(
      comicId: fields[0] as int,
      title: fields[1] as String,
      cover: fields[2] as String,
      categories: fields[3] as String,
      authors: fields[4] as String,
      flag: fields[5] as int,
      browseChapterId: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Comic obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.comicId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.cover)
      ..writeByte(3)
      ..write(obj.categories)
      ..writeByte(4)
      ..write(obj.authors)
      ..writeByte(5)
      ..write(obj.flag)
      ..writeByte(6)
      ..write(obj.browseChapterId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
