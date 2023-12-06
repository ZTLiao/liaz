part of 'device_info.dart';

class DeviceInfoAdapter extends TypeAdapter<DeviceInfo> {
  @override
  final int typeId = 1;

  @override
  DeviceInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeviceInfo(
      deviceId: fields[0] as String,
      os: fields[1] as String,
      osVersion: fields[2] as String,
      model: fields[3] as String,
      imei: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeviceInfo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.deviceId)
      ..writeByte(1)
      ..write(obj.os)
      ..writeByte(2)
      ..write(obj.osVersion)
      ..writeByte(3)
      ..write(obj.model)
      ..writeByte(4)
      ..write(obj.imei);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
