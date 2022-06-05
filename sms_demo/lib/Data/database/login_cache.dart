import 'dart:async';

import 'package:sms_demo/Data/database/database_helper.dart';

import '../../Domain/model/auth/user.dart';

class LoginCtr {
  DatabaseHelper con = DatabaseHelper();

  Future<User?> getLogin(String user, String password) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM user WHERE username = '$user' and password = '$password'");

    if (res.length > 0) {
      return User(
          username: res.first['username']!.toString(),
          password: res.first['password']!.toString());
    }
    return null;
  }

  Future<int> saveUser(User user) async {
    var dbClient = await con.db;
    var map = Map<String, dynamic>();
    map['username'] = user.username;
    map['password'] = user.password;
    int res = await dbClient.insert("User", map);
    return res;
  }
}
