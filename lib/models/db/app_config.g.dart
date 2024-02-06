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
      shareUrl: fields[2] as String,
      signKey: fields[3] as String,
      publicKey: fields[4] as String,
      downloadApp: fields[5] as String,
      splash: fields[6] as SplashConfig,
      emptyPage: fields[7] as String,
      advert: fields[8] as AdsConfig,
    );
  }

  @override
  void write(BinaryWriter writer, AppConfig obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.fileUrl)
      ..writeByte(1)
      ..write(obj.resourceAuthority)
      ..writeByte(2)
      ..write(obj.shareUrl)
      ..writeByte(3)
      ..write(obj.signKey)
      ..writeByte(4)
      ..write(obj.publicKey)
      ..writeByte(5)
      ..write(obj.downloadApp)
      ..writeByte(6)
      ..write(obj.splash)
      ..writeByte(7)
      ..write(obj.emptyPage)
      ..writeByte(8)
      ..write(obj.advert);
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
