/*import 'package:auto_size_text/auto_size_text.dart';
//import 'package:ecommerce_app_eid/controllers/cart_controller.dart';

import 'package:ecommerce_app_eid/localization/language_constants.dart';
//import 'package:ecommerce_app_eid/models/product.dart';
//import 'package:ecommerce_app_eid/screens/product_detail.dart';
import 'package:ecommerce_app_eid/utils/get_cache_image.dart';
import 'package:ecommerce_app_eid/utils/screen_util.dart';
//import 'package:ecommerce_app_eid/widgets/product_detail_bottom_sheet_content.dart';

import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class FavoriteProductCard extends StatelessWidget {
  final int id;
  final String name;
  final int price;
  final String imageUrl;
  final String category;
  final String details;
  final int v;
  final Function onUnFavorite;

  FavoriteProductCard({
    Key key,
    this.id,
    this.name,
    this.price,
    this.imageUrl,
    this.category,
    this.details,
    this.v,
    this.onUnFavorite,
  }) : super(key: key);

  final screenUtil = ScreenUtil.instance;

  /* var _cartCtlr;
  @override
  void initState() {
    _cartCtlr = Provider.of<CartController>(context, listen: false);
    _cartCtlr.getSavedCart();
    super.initState();
  }

  _handleButtonTap(context) {
    if (!_cartCtlr.isItemInCart(_cartCtlr.selectedItem)) {
      _cartCtlr.addToCart(_cartCtlr.selectedItem);
    } else {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) =>
            ProductDetailBottomSheetContent(cartCtlr: _cartCtlr),
      );
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: <Widget>[
              getCacheImage(imageUrl, 100),
            ],
          ),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: screenUtil.setSp(18)),
              ),
              AutoSizeText(
                '${price}' + getTranslated(context, 'L_E'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: screenUtil.setSp(18)),
              ),
            ],
          ),
          Row(
            children: [
              /* IconButton(
                icon: Image.asset(
                  'assets/icons/add_to_cart.png',
                  height: 25,
                  width: 25,
                ),
                tooltip: getTranslated(context, 'Add_to_cart'),
                onPressed: () async {
                  _handleButtonTap(context);
                },
              ),*/
              /*  IconButton(
                icon: Image.asset(
                  'assets/icons/view_product.png',
                  height: 25,
                  width: 25,
                ),
                tooltip: getTranslated(context, 'Show_Product'),
                onPressed: () {
                  _cartCtlr.setCurrentItem(
                    Product(id: widget.id),
                  );
                  Navigator.pushNamed(context, ProductDetail.id);
                },
              ),*/
              IconButton(
                icon: Icon(Icons.delete),
                tooltip: getTranslated(context, 'delete_btn'),
                onPressed: onUnFavorite,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
*/
