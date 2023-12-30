part of 'app_config.dart';

class AppConfigAdapter extends TypeAdapter<AppConfig> {
  @override
  final int typeId = 2;

  @override
  AppConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppConfig(
      fileUrl: fields[0] as String,
      resourceAuthority: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AppConfig obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.fileUrl)
      ..writeByte(1)
      ..write(obj.resourceAuthority);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
