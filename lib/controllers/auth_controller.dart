import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_app_eid/controllers/error_controller.dart';
import 'package:ecommerce_app_eid/services/auth_service.dart';
import 'package:ecommerce_app_eid/widgets/global_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthController {
  final _storage = FlutterSecureStorage();
  final _authService = AuthService();

  saveUserDataAndLoginStatus(
    String userId,
    String isLoggedFlag,
    String jwt,
    String email,
    String name,
  ) async {
    await _storage.write(key: 'UserId', value: userId);
    await _storage.write(key: 'IsLoggedFlag', value: isLoggedFlag);
    await _storage.write(key: 'jwt', value: jwt);
    await _storage.write(key: 'email', value: email);
    await _storage.write(key: 'name', value: name);
  }

  //****************************************************************************
  getUserDataAndLoginStatus() async {
    String userId = await _storage.read(key: 'UserId');
    String isLoggedFlag = await _storage.read(key: 'IsLoggedFlag');
    String token = await _storage.read(key: 'jwt');
    String email = await _storage.read(key: 'email');
    String name = await _storage.read(key: 'name');
    return [userId, isLoggedFlag, token, email, name];
  }

  //****************************************************************************
  deleteUserDataAndLoginStatus() async {
    await _storage.deleteAll();
  }

  //****************************************************************************
  Future<bool> emailNameAndPasswordSignUp(
    String name,
    String email,
    String password,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) async {
    try {
      var response = await _authService.emailNameAndPasswordSignUp(
        name,
        email,
        password,
      );
      if (response.statusCode == 201) {
        var jsonResponse = json.decode(response.body);
        var token = jsonResponse['data']['token'];
        var userId = jsonResponse['data']['user']['id'];
        var email = jsonResponse['data']['user']['email'];
        var name = jsonResponse['data']['user']['name'];

        await saveUserDataAndLoginStatus(userId, '1', token, email, name);
        return true;
      } else {
        ErrorController.showErrorFromApi(scaffoldKey, response);
        return false;
      }
    } on SocketException catch (_) {
      ErrorController.showNoInternetError(scaffoldKey);
      return false;
    } on HttpException catch (_) {
      ErrorController.showNoServerError(scaffoldKey);
      return false;
    } on FormatException catch (_) {
      ErrorController.showFormatExceptionError(scaffoldKey);
      return false;
    } catch (e) {
      ErrorController.showUnKownError(scaffoldKey);
      return false;
    }
  }

  //****************************************************************************
  Future<bool> emailAndPasswordSignIn(
    String email,
    String password,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) async {
    try {
      var response = await _authService.emailAndPasswordSignIn(email, password);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var token = jsonResponse['data']['token'];
        var userId = jsonResponse['data']['user']['id'];
        var email = jsonResponse['data']['user']['email'];
        var name = jsonResponse['data']['user']['name'];

        await saveUserDataAndLoginStatus(userId, '1', token, email, name);
        return true;
      } else {
        ErrorController.showErrorFromApi(scaffoldKey, response);
        return false;
      }
    } on SocketException catch (_) {
      ErrorController.showNoInternetError(scaffoldKey);
      return false;
    } on HttpException catch (_) {
      ErrorController.showNoServerError(scaffoldKey);
      return false;
    } on FormatException catch (_) {
      ErrorController.showFormatExceptionError(scaffoldKey);
      return false;
    } catch (e) {
      ErrorController.showUnKownError(scaffoldKey);
      return false;
    }
  }

  //****************************************************************************
  Future<bool> isTokenValid() async {
    String token = await _storage.read(key: 'jwt');

    if (token == null || token.isEmpty) {
      return false;
    }
    var response = await _authService.checkTokenExpiry(token);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //****************************************************************************
  Future<bool> changeName(
    String name,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) async {
    try {
      var data = await getUserDataAndLoginStatus();
      var response = await _authService.changeName(name, data[0], data[2]);
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        await _storage.write(key: 'name', value: responseBody['data']['name']);
        return true;
      } else {
        ErrorController.showErrorFromApi(scaffoldKey, response);
        return false;
      }
    } on SocketException catch (_) {
      ErrorController.showNoInternetError(scaffoldKey);
      return false;
    } on HttpException catch (_) {
      ErrorController.showNoServerError(scaffoldKey);
      return false;
    } on FormatException catch (_) {
      ErrorController.showFormatExceptionError(scaffoldKey);
      return false;
    } catch (e) {
      print("Error ${e.toString()}");
      ErrorController.showUnKownError(scaffoldKey);
      return false;
    }
  }

  //****************************************************************************
  Future<bool> changeEmail(
    String email,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) async {
    try {
      var data = await getUserDataAndLoginStatus();
      var response = await _authService.changeEmail(email, data[0], data[2]);
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        await _storage.write(
          key: 'email',
          value: responseBody['data']['email'],
        );
        return true;
      } else {
        ErrorController.showErrorFromApi(scaffoldKey, response);
        return false;
      }
    } on SocketException catch (_) {
      ErrorController.showNoInternetError(scaffoldKey);
      return false;
    } on HttpException catch (_) {
      ErrorController.showNoServerError(scaffoldKey);
      return false;
    } on FormatException catch (_) {
      ErrorController.showFormatExceptionError(scaffoldKey);
      return false;
    } catch (e) {
      print("Error ${e.toString()}");
      ErrorController.showUnKownError(scaffoldKey);
      return false;
    }
  }

  //****************************************************************************
  Future<bool> forgotPassword(
    String email,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) async {
    try {
      var response = await _authService.forgotPassword(email);
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        GlobalSnackBar.showSnackbar(
          scaffoldKey,
          responseBody['message'],
          SnackBarType.Success,
        );

        return true;
      } else {
        ErrorController.showErrorFromApi(scaffoldKey, response);
        return false;
      }
    } on SocketException catch (_) {
      ErrorController.showNoInternetError(scaffoldKey);
      return false;
    } on HttpException catch (_) {
      ErrorController.showNoServerError(scaffoldKey);
      return false;
    } on FormatException catch (_) {
      ErrorController.showFormatExceptionError(scaffoldKey);
      return false;
    } catch (e) {
      ErrorController.showUnKownError(scaffoldKey);
      return false;
    }
  }
}
