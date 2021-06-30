import 'package:ecommerce_app_eid/localization/language_constants.dart';
import 'package:ecommerce_app_eid/screens/shopping_cart.dart';
import 'package:ecommerce_app_eid/widgets/cart_button.dart';
import 'package:flutter/material.dart';

class ProductDetailBottomSheetContent extends StatelessWidget {
  const ProductDetailBottomSheetContent({
    Key key,
    @required cartCtlr,
  })  : _cartCtlr = cartCtlr,
        super(key: key);

  final _cartCtlr;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      color: Colors.grey[200],
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            '${_cartCtlr.selectedItem.product.name} already in cart',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red),
                ),
                color: Colors.red,
                onPressed: () {
                  _cartCtlr.removeFromCart(_cartCtlr.selectedItem);
                  Navigator.pop(context);
                },
                child: Text(
                  getTranslated(context, 'REMOVE_BTN'),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Text(getTranslated(context, 'OR_key')),
              InkWell(
                child: CartButton(
                  text: getTranslated(context, 'View_cart_key'),
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, ShoppingCart.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
