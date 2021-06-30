import 'dart:convert';
import 'package:ecommerce_app_eid/application_url/app_url.dart';
import 'package:http/http.dart' as http;

class CartService {
  static CartService _cartService;
  CartService._internal() {
    _cartService = this;
  }
  factory CartService() => _cartService ?? CartService._internal();

  static Map<String, String> headers = {'Content-Type': 'application/json'};

  Future saveCart(
    String productId,
    String userId,
    String quantity,
    String jwtToken,
  ) async {
    var bodyObject = Map<String, String>();
    bodyObject.putIfAbsent('productId', () => productId);
    bodyObject.putIfAbsent('userId', () => userId);
    bodyObject.putIfAbsent('quantity', () => quantity);

    headers.putIfAbsent('Authorization', () => 'Bearer $jwtToken');

    return await http.post(
      AppUrl.cartUrl,
      body: json.encode(bodyObject),
      headers: headers,
    );
  }

  //****************************************************************************
  Future getCart(
    String userId,
    String jwtToken,
  ) async {
    headers.putIfAbsent('Authorization', () => 'Bearer $jwtToken');
    return await http.get(
      '${AppUrl.cartUrl}/$userId',
      headers: headers,
    );
  }

  //****************************************************************************
  Future deleteCart(
    String userId,
  ) async {
    return await http.delete('${AppUrl.cartUrl}/$userId');
  }
}
