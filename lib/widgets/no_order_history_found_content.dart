import 'package:ecommerce_app_eid/localization/language_constants.dart';
import 'package:flutter/material.dart';

class NoOrderHistoryFoundContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          getTranslated(context, 'No_orders_found'),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          getTranslated(
            context,
            'This_could_be_because_you_bought_products_as_a_guest',
          ),
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        SizedBox(height: 10),
        Text(
          getTranslated(
            context,
            'Or_you_not_have_bought_any_item_yet',
          ),
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
