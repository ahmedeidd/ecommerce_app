import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginApiController extends ChangeNotifier {
  var _apiToken;
  get apiToken => _apiToken;
  sendRequest() async {
    Map data = {
      'username': 'tiger1020',
      'key':
          'kjLLRGiTrCNQvBx1tM7W5XCLwxV4SGX8Ec6MkVLhPIr3hJL5J8xUtOrJCcGcKjp273LoGucxJqWXfQh6st5EPoeZU1awpJbHpZAcTUeOER8EXnf1eANsNEEv2FBE6dM3Dv7zQvT5NCdsc0cZdJJ6nPJ6zwnxbVMuyaKRcD1iqb6HZ02iaih07YSKRKhPIzxHiNi4qqerfHaBUZ0kWlhbfTLS3CnLFGe4wvnV3RlI60KLhMyPHzF7jNtv7ZsIsMHU'
    };

    var url = 'https://shop.matjerwiz.com/index.php?route=api/login';
    http.post(url, body: data).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      var jsonD = json.decode(response.body);
      _apiToken = jsonD['api_token'];
      notifyListeners();
      //print("api_token: ${_apiToken}");
    });
  }
}
