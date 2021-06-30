import 'package:ecommerce_app_eid/constants/screens_ids.dart';
import 'package:ecommerce_app_eid/controllers/cart_controller.dart';
import 'package:ecommerce_app_eid/controllers/favourite_controller.dart';
import 'package:ecommerce_app_eid/localization/language_constants.dart';
import 'package:ecommerce_app_eid/models/favourite_item.dart';
import 'package:ecommerce_app_eid/models/product.dart';
import 'package:ecommerce_app_eid/screens/product_detail.dart';
import 'package:ecommerce_app_eid/widgets/cart_button.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  static String id = favourite_screen_Id;

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  var _favouriteController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _cartCtlr;

  @override
  void initState() {
    _cartCtlr = Provider.of<CartController>(context, listen: false);

    _favouriteController =
        Provider.of<FavouriteController>(context, listen: false);
    super.initState();
  }

  _handleRemoveFavouriteCartItem(FavouriteItem favouriteItem) {
    setState(() {
      _favouriteController.removeFromFavouriteCart(favouriteItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          getTranslated(context, 'favourite_Screen_Title'),
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 18, right: 18, top: 20),
          child: ListView(
            children: [
              //list of items
              Consumer<FavouriteController>(
                builder: (context, favtCtlr, child) {
                  if (favtCtlr.favouritecart.length == 0) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 100,
                          bottom: 10,
                        ),
                        child: Text(
                          getTranslated(
                            context,
                            'favourite_is_clean_and_empty',
                          ),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: favtCtlr.favouritecart.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Divider(
                            thickness: 2.0,
                            height: 2,
                          ),
                          //particular item
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Product image
                              Container(
                                height: size.height * 0.20,
                                width: size.width * 0.4,
                                margin: EdgeInsets.only(
                                  right: 18,
                                  bottom: 18,
                                  top: 10,
                                ),
                                child: Image.network(
                                  '${favtCtlr.favouritecart[index].product.imageUrl}',
                                  fit: BoxFit.fill,
                                  errorBuilder: (
                                    BuildContext context,
                                    Object exception,
                                    StackTrace stackTrace,
                                  ) {
                                    return Center(child: Icon(Icons.error));
                                  },
                                  loadingBuilder: (
                                    BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress,
                                  ) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // name,price
                              Expanded(
                                child: Container(
                                  height: size.height * 0.20,
                                  margin: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // product name
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 5.0),
                                        child: Text(
                                          '${favtCtlr.favouritecart[index].product.name}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      //product price
                                      Text(
                                        getTranslated(context, 'L_E') +
                                            "${favtCtlr.favouritecart[index].product.price}",
                                      ),

                                      //show product details
                                      GestureDetector(
                                        onTap: () {
                                          _cartCtlr.setCurrentItem(
                                            Product(
                                              id: favtCtlr.favouritecart[index]
                                                  .product.id,
                                              name: favtCtlr
                                                  .favouritecart[index]
                                                  .product
                                                  .name,
                                              price: favtCtlr
                                                  .favouritecart[index]
                                                  .product
                                                  .price,
                                              imageUrl: favtCtlr
                                                  .favouritecart[index]
                                                  .product
                                                  .imageUrl,
                                              category: favtCtlr
                                                  .favouritecart[index]
                                                  .product
                                                  .category,
                                              details: favtCtlr
                                                  .favouritecart[index]
                                                  .product
                                                  .details,
                                              v: favtCtlr.favouritecart[index]
                                                  .product.v,
                                            ),
                                          );
                                          Navigator.pushNamed(
                                              context, ProductDetail.id);
                                        },
                                        child: CartButton(
                                          text: 'show',
                                          width: size.width * 0.25,
                                        ),
                                      ),

                                      //remove from cart button
                                      GestureDetector(
                                        onTap: () {
                                          _handleRemoveFavouriteCartItem(
                                            favtCtlr.favouritecart[index],
                                          );
                                        },
                                        child: CartButton(
                                          text: getTranslated(
                                            context,
                                            'REMOVE_BTN',
                                          ),
                                          width: size.width * 0.25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),

              Divider(
                thickness: 2.0,
                height: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
