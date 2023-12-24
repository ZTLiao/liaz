part of 'oauth2_token.dart';

class OAuth2TokenAdapter extends TypeAdapter<OAuth2Token> {
  @override
  final int typeId = 3;

  @override
  OAuth2Token read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OAuth2Token(
      accessToken: fields[0] as String,
      tokenType: fields[1] as String,
      refreshToken: fields[2] as String,
      expiry: fields[3] as int,
      userId: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, OAuth2Token obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.accessToken)
      ..writeByte(1)
      ..write(obj.tokenType)
      ..writeByte(2)
      ..write(obj.refreshToken)
      ..writeByte(3)
      ..write(obj.expiry)
      ..writeByte(4)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OAuth2TokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
