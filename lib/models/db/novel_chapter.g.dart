part of 'novel_chapter.dart';

class NovelChapterAdapter extends TypeAdapter<NovelChapter> {
  @override
  final int typeId = 10;

  @override
  NovelChapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NovelChapter(
      chapterId: fields[0] as int,
      chapterName: fields[1] as String,
      seqNo: fields[2] as int,
      taskId: fields[3] as String,
      currentIndex: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NovelChapter obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.chapterId)
      ..writeByte(1)
      ..write(obj.chapterName)
      ..writeByte(2)
      ..write(obj.seqNo)
      ..writeByte(3)
      ..write(obj.taskId)
      ..writeByte(4)
      ..write(obj.currentIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NovelChapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
