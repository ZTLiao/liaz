part of 'comic_chapter.dart';

class ComicChapterAdapter extends TypeAdapter<ComicChapter> {
  @override
  final int typeId = 9;

  @override
  ComicChapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ComicChapter(
      chapterId: fields[0] as int,
      chapterName: fields[1] as String,
      seqNo: fields[2] as int,
      taskId: fields[3] as String,
      currentIndex: fields[4] as int,
      comicId: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ComicChapter obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.chapterId)
      ..writeByte(1)
      ..write(obj.chapterName)
      ..writeByte(2)
      ..write(obj.seqNo)
      ..writeByte(3)
      ..write(obj.taskId)
      ..writeByte(4)
      ..write(obj.currentIndex)
      ..writeByte(5)
      ..write(obj.comicId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComicChapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
