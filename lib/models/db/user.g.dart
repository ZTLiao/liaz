part of 'user.dart';

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 4;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      userId: fields[0] as int,
      username: fields[1] as String,
      nickname: fields[2] as String,
      phone: fields[3] as String,
      email: fields[4] as String,
      avatar: fields[5] as String,
      description: fields[6] as String,
      gender: fields[7] as int,
      country: fields[8] as String,
      province: fields[9] as String,
      city: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.nickname)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.avatar)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.gender)
      ..writeByte(8)
      ..write(obj.country)
      ..writeByte(9)
      ..write(obj.province)
      ..writeByte(10)
      ..write(obj.city);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
