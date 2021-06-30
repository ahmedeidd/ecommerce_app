import 'package:ecommerce_app_eid/localization/language_constants.dart';
import 'package:ecommerce_app_eid/screens/auth_screen.dart';
import 'package:ecommerce_app_eid/screens/shipping_screen.dart';
import 'package:flutter/material.dart';

class ShoppingCartBottomSheet extends StatelessWidget {
  final String message;
  const ShoppingCartBottomSheet({
    this.message,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "${message != null ? message : ''}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: Colors.red[900],
            onPressed: () {
              Navigator.pushNamed(context, AuthScreen.id);
            },
            child: Text(
              getTranslated(context, 'Sign_In'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            getTranslated(context, 'OR_key'),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: Colors.orange[900],
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Shipping.id);
            },
            child: Text(
              getTranslated(context, 'continue_as_guest'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
