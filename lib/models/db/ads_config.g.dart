part of 'ads_config.dart';

class AdsConfigAdapter extends TypeAdapter<AdsConfig> {
  @override
  final int typeId = 13;

  @override
  AdsConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdsConfig(
      enabled: fields[0] as bool,
      adsType: fields[1] as int,
      adsFlag: fields[2] as int,
      appId: fields[3] as String,
      appName: fields[4] as String,
      splashCodeId: fields[5] as String,
      bannerCodeId: fields[6] as String,
      nativeCodeId: fields[7] as String,
      rewardCodeId: fields[8] as String,
      drawCodeId: fields[9] as String,
      screenCodeId: fields[10] as String,
      detailBannerCodeId: fields[11] as String,
      readBannerCodeId: fields[12] as String,
      bottomBannerCodeId: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AdsConfig obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.enabled)
      ..writeByte(1)
      ..write(obj.adsType)
      ..writeByte(2)
      ..write(obj.adsFlag)
      ..writeByte(3)
      ..write(obj.appId)
      ..writeByte(4)
      ..write(obj.appName)
      ..writeByte(5)
      ..write(obj.splashCodeId)
      ..writeByte(6)
      ..write(obj.bannerCodeId)
      ..writeByte(7)
      ..write(obj.nativeCodeId)
      ..writeByte(8)
      ..write(obj.rewardCodeId)
      ..writeByte(9)
      ..write(obj.drawCodeId)
      ..writeByte(10)
      ..write(obj.screenCodeId)
      ..writeByte(11)
      ..write(obj.detailBannerCodeId)
      ..writeByte(12)
      ..write(obj.readBannerCodeId)
      ..writeByte(13)
      ..write(obj.bottomBannerCodeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdsConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
