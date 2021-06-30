import 'package:ecommerce_app_eid/constants/screens_ids.dart';
import 'package:ecommerce_app_eid/localization/language_constants.dart';
import 'package:ecommerce_app_eid/screens/Product_list.dart';
import 'package:ecommerce_app_eid/screens/single_order.dart';
import 'package:flutter/material.dart';

class Thanks extends StatelessWidget {
  const Thanks({Key key}) : super(key: key);
  static String id = ThankYou_Screen_Id;
  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      Navigator.pushNamedAndRemoveUntil(
        context,
        ProductList.id,
        (route) => false,
      );
      return Future.value(true);
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              getTranslated(context, 'Thanks_Screen_Title'),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 1,
            backgroundColor: Colors.white,
          ),
          body: Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 40,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    getTranslated(context, 'Payment_made_successfully'),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SingleOrder.id);
                    },
                    child: Text(
                      getTranslated(context, 'VIEW_ORDER'),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
