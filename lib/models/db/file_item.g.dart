part of 'file_item.dart';

class FileItemAdapter extends TypeAdapter<FileItem> {
  @override
  final int typeId = 11;

  @override
  FileItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FileItem(
      path: fields[0] as String,
      expireTime: fields[1] as int,
      requestUri: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FileItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.expireTime)
      ..writeByte(2)
      ..write(obj.requestUri);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
