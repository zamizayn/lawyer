// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      name: fields[2] as String,
      address: fields[5] as String,
      city: fields[8] as String,
      email: fields[3] as String,
      passport: fields[1] as Uint8List,
      phone: fields[4] as String,
      postal: fields[9] as String,
      profile: fields[0] as Uint8List,
      state: fields[6] as String,
      street: fields[7] as String?,
      token: fields[10] as String,
      country: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.profile)
      ..writeByte(1)
      ..write(obj.passport)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.state)
      ..writeByte(7)
      ..write(obj.street)
      ..writeByte(8)
      ..write(obj.city)
      ..writeByte(9)
      ..write(obj.postal)
      ..writeByte(10)
      ..write(obj.token)
      ..writeByte(11)
      ..write(obj.country);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
