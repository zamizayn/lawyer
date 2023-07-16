// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';

import 'package:find_your_lawyer/database/user_model.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RegistrationAPI {
  static Future<List<CountryModel>?> getAllCountries() async {
    var client = Client();
    try {
      Response response =
          await client.get(Uri.parse("http://117.200.73.2:7075/lawyer/public/api/getAllCountries"));
      if (response.statusCode == 200) {
        log(response.body);
        Map<String, dynamic> json = jsonDecode(response.body);
        log(json.toString());
        List<CountryModel> countries = [];
        for (var element in json["DATA"]) {
          countries
              .add(CountryModel(element["pk_country_id"].toString(), element["cmn_country_name"]));
        }
        client.close();

        return countries;
      } else {
        log("Error getting countries");
        client.close();

        return null;
      }
    } catch (e) {
      log(e.toString());
      client.close();

      return null;
    }
  }

  static Future<List<StateModel>?> getStatesByCountry(String countryValue) async {
    var client = Client();
    try {
      Response response = await client.get(
          Uri.parse("http://117.200.73.2:7075/lawyer/public/api/getStatesByCountry/$countryValue"));
      if (response.statusCode == 200) {
        log(response.body);
        Map<String, dynamic> json = jsonDecode(response.body);
        log(json.toString());
        List<StateModel> states = [];
        for (var element in json["DATA"]) {
          states.add(StateModel(element["pk_cmn_state_id"].toString(), element["cmn_state_name"]));
        }
        client.close();
        return states;
      } else {
        log("Error getting countries");
        client.close();
        return null;
      }
    } catch (e) {
      log(e.toString());
      client.close();

      return null;
    }
  }

  static Future<String?> checkAccountExists(String phone) async {
    Response response = await http.post(
        Uri.parse("http://117.200.73.2:7075/lawyer/public/api/checkOrUpdatePhone"),
        body: {"phone": phone});
    if (response.statusCode == 200) {
      log(response.body);
      Map<String, dynamic> json = jsonDecode(response.body);
      log(json.toString());
      if (json["STATUS"] == "SUCCESS") {
        return json["TOKEN"] as String;
      } else {
        return null;
      }
    } else {
      log("Check Phone Exists${response.statusCode}");
      return null;
    }
  }

  static Future<UserModel?> getUserData(String token) async {
    try {
      Response response = await http.post(
          Uri.parse("http://117.200.73.2:7075/lawyer/public/api/getUserData"),
          body: {"token": token});
      if (response.statusCode == 200) {
        log(response.body);
        Map<String, dynamic> json = jsonDecode(response.body);
        log(json.toString());
        String? profileUrl;
        if (json["DATA"].first["user_mastr_profile_pic"] != null) {
          profileUrl = "http://117.200.73.2:7075/lawyer/public/" +
              json["DATA"].first["user_mastr_profile_pic"].toString();
        }
        String? passportUrl;
        if (json["DATA"].first["user_mastr_passport_pic"] != null) {
          passportUrl = "http://117.200.73.2:7075/lawyer/public/" +
              json["DATA"].first["user_mastr_passport_pic"].toString();
        }
        log(profileUrl.toString());
        log(passportUrl.toString());

        Uint8List passport = await _loadImage(passportUrl ??
            "https://static.vecteezy.com/system/resources/previews/006/414/207/original/passport-icon-in-trendy-flat-style-isolated-on-white-background-passport-symbol-for-your-website-design-logo-app-ui-illustration-free-vector.jpg");
        Uint8List profile = await _loadImage(profileUrl ??
            "https://icons.veryicon.com/png/o/miscellaneous/administration/account-25.png");
        log("passport and profile loaded");
        log("passport size " + passport.length.toString());
        log("profile size " + profile.length.toString());
        return UserModel.fromJson(json["DATA"].first, passport: passport, profile: profile);
      } else {
        log(response.statusCode.toString());
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}

Future<dynamic> _loadImage(String url) async {
  try {
    return await NetworkAssetBundle(Uri.parse(url))
        .load(url)
        .then((value) => value.buffer.asUint8List());
  } catch (e) {
    log(e.toString());
  }
}

class CountryModel {
  String name;
  String value;
  CountryModel(this.value, this.name);
  @override
  bool operator ==(o) => o is CountryModel && o.name == name && o.value == value;
}

class StateModel {
  String stateName;
  String stateValue;
  StateModel(this.stateValue, this.stateName);
  @override
  bool operator ==(o) => o is StateModel && o.stateName == stateName && o.stateValue == stateValue;
}
