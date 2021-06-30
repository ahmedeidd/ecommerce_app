import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_app_eid/controllers/error_controller.dart';
import 'package:ecommerce_app_eid/models/product.dart';
import 'package:ecommerce_app_eid/services/product_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  final _productService = ProductService();

  var _productList = List<Product>();
  List<Product> get productList => _productList;

  bool _isLoadingAllProducts = true;
  bool get isLoadingAllProducts => _isLoadingAllProducts;
  setIsLoadingAllProducts(bool value) {
    _isLoadingAllProducts = value;
    notifyListeners();
  }

  void getAllProducts(GlobalKey<ScaffoldState> scaffoldKey) async {
    try {
      _isLoadingAllProducts = true;
      _productList.clear();

      var response = await _productService.getAllProducts();

      if (response.statusCode == 200) {
        var responseJsonStr = json.decode(response.body);
        var jsonProd = responseJsonStr['data']['products'];
        _productList.addAll(productFromJson(json.encode(jsonProd)));
        _isLoadingAllProducts = false;
        notifyListeners();
      } else {
        ErrorController.showErrorFromApi(scaffoldKey, response);
      }
    } on SocketException catch (_) {
      ErrorController.showNoInternetError(scaffoldKey);
    } on HttpException catch (_) {
      ErrorController.showNoServerError(scaffoldKey);
    } on FormatException catch (_) {
      ErrorController.showFormatExceptionError(scaffoldKey);
    } catch (e) {
      ErrorController.showUnKownError(scaffoldKey);
    }
  }

  //****************************************************************************

  void getProductByCategory(
    String value,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) async {
    try {
      _isLoadingAllProducts = true;
      var response = value == 'All'
          ? await _productService.getAllProducts()
          : await _productService.getProductByCategory(value);
      if (response.statusCode == 200) {
        var responseJsonStr = json.decode(response.body);
        var jsonProd = value == 'All'
            ? responseJsonStr['data']['products']
            : responseJsonStr['data']['result'];

        _productList.clear();
        _productList.addAll(productFromJson(json.encode(jsonProd)));
        _isLoadingAllProducts = false;

        notifyListeners();
      } else {
        ErrorController.showErrorFromApi(scaffoldKey, response);
      }
    } on SocketException catch (_) {
      ErrorController.showNoInternetError(scaffoldKey);
    } on HttpException catch (_) {
      ErrorController.showNoServerError(scaffoldKey);
    } on FormatException catch (_) {
      ErrorController.showFormatExceptionError(scaffoldKey);
    } catch (e) {
      ErrorController.showUnKownError(scaffoldKey);
    }
  }

  //****************************************************************************
  void getProductByCategoryOrName(String value) async {
    var finalSearchValue = value.trim(); // remove any space
    try {
      _isLoadingAllProducts = true;

      var response = finalSearchValue == ''
          ? await _productService.getAllProducts()
          : await _productService.getProductByCategoryOrName(finalSearchValue);

      if (response.statusCode == 200) {
        var responseJsonStr = json.decode(response.body);
        var jsonProd = finalSearchValue == ''
            ? responseJsonStr['data']['products']
            : responseJsonStr['data']['result'];

        _productList.clear();
        _productList.addAll(productFromJson(json.encode(jsonProd)));
        _isLoadingAllProducts = false;
        notifyListeners();
      } else {
        _isLoadingAllProducts = true;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoadingAllProducts = true;
      notifyListeners();
    } on HttpException catch (_) {
      _isLoadingAllProducts = true;
      notifyListeners();
    } catch (e) {
      print("Error ${e.toString()}");
      _isLoadingAllProducts = true;
      notifyListeners();
    }
  }
}
