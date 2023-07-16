import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  late Uint8List profile;
  @HiveField(1)
  late Uint8List passport;
  @HiveField(2)
  late String name;
  @HiveField(3)
  late String email;
  @HiveField(4)
  late String phone;
  @HiveField(5)
  late String address;
  @HiveField(6)
  String state;
  @HiveField(7)
  String? street;
  @HiveField(8)
  late String city;
  @HiveField(9)
  late String postal;
  @HiveField(10)
  late String token;
  @HiveField(11)
  String country;
  UserModel(
      {required this.name,
      required this.address,
      required this.city,
      required this.email,
      required this.passport,
      required this.phone,
      required this.postal,
      required this.profile,
      required this.state,
      required this.street,
      required this.token,
      required this.country});

  factory UserModel.fromJson(Map<String, dynamic> json, {required passport, required profile}) {
    return UserModel(
        name: json["user_mastr_name"],
        email: json["user_mastr_email"],
        phone: json["user_mastr_phone"],
        street: json["user_mastr_street"],
        state: json["fk_user_mastr_state_mastr_id"].toString(),
        country: json["fk_user_mastr_country_mastr_id"].toString(),
        token: json["user_mastr_access_key"],
        postal: json["user_mastr_postal_code"],
        city: json["user_mastr_city"],
        address: json["user_mastr_address"],
        passport: passport,
        profile: profile);
  }
}
// http://117.200.73.2:7075/lawyer/public/