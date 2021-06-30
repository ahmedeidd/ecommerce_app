import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret =
      'sk_test_51I84CUGolL6X5BXWt0Kr8Lz7Gn9UpMXVc90CDxke4nDBZObxpGQRs4yDK2ao4HY6zI5WI3s0Lh1JKDTRHH1ah4qV009hFe2sPx';
  static String publishableKey =
      'pk_test_51I84CUGolL6X5BXWp3gAe9wggEbA7wwktxJ6LWOg4I4m0R3dC5TohDHbsmu1xvGxvAJ9I92RK9XRl0wdkSZrMtUj00pCtVY1Km';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: publishableKey,
        merchantId: "Test",
        androidPayMode: "test",
      ),
    );
  }

  //****************************************************************************
  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }
    return StripeTransactionResponse(message: message, success: false);
  }

  //****************************************************************************
  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        StripeService.paymentApiUrl,
        body: body,
        headers: StripeService.headers,
      );

      return jsonDecode(response.body);
    } catch (err) {
      print('error charging user: ${err.toString()}');
    }
    return null;
  }

  //****************************************************************************
  static Future<StripeTransactionResponse> processPayment(
    String amount,
    currency,
  ) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest(),
      );
      var paymentIntent = await StripeService.createPaymentIntent(
        amount,
        currency,
      );
      var response = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id,
        ),
      );
      if (response.status == 'succeeded') {
        return StripeTransactionResponse(
          message: 'Transaction successful',
          success: true,
        );
      } else {
        return StripeTransactionResponse(
          message: 'Transaction  failed',
          success: false,
        );
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (e) {
      return StripeTransactionResponse(
        message: 'Transaction  failed: ${e.toString()}',
        success: false,
      );
    }
  }
}
