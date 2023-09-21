import 'dart:developer';

import 'package:adecco_ahmad_test/api_url.dart';
import 'package:adecco_ahmad_test/login/models/login_response_model.dart';
import 'package:adecco_ahmad_test/login/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<LoginResponseModel?> loginRequest(
      UserModel model, bool saveLogin) async {
    try {
      var response = await http.post(
        Uri.parse(URLs.LOGIN),
        body: model.toJson(),
      );

      var responseModel = LoginResponseModel.fromRawJson(response.body);
      if (saveLogin) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', responseModel.token ?? '');
      }

      return responseModel;
    } catch (e, s) {
      log("$s");
      return null;
    }
  }
}
