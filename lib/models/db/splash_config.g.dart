part of 'splash_config.dart';

class SplashConfigAdapter extends TypeAdapter<SplashConfig> {
  @override
  final int typeId = 12;

  @override
  SplashConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SplashConfig(
      enabled: fields[0] as bool,
      cover: fields[1] as String,
      skipType: fields[2] as int,
      skipValue: fields[3] as String,
      duration: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SplashConfig obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.enabled)
      ..writeByte(1)
      ..write(obj.cover)
      ..writeByte(2)
      ..write(obj.skipType)
      ..writeByte(3)
      ..write(obj.skipValue)
      ..writeByte(4)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SplashConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
