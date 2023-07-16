import 'package:find_your_lawyer/database/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DB {
  static final DB instance = DB._internal();
  DB._internal();

  late Box userData;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    userData = await Hive.openBox("userBox");
  }

  Future<void> deleteUserData() async {
    await userData.delete("userData");
  }

  Future<void> saveUserData(UserModel userModel) async {
    await userData.put("userData", userModel);
  }

  UserModel? getUserData() {
    return userData.get("userData");
  }
}
