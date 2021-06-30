import 'package:badges/badges.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:ecommerce_app_eid/constants/screens_ids.dart';
import 'package:ecommerce_app_eid/controllers/cart_controller.dart';
import 'package:ecommerce_app_eid/controllers/category_controller.dart';
import 'package:ecommerce_app_eid/controllers/favourite_controller.dart';
import 'package:ecommerce_app_eid/controllers/loginApi_controller.dart';
import 'package:ecommerce_app_eid/controllers/product_controller.dart';
import 'package:ecommerce_app_eid/localization/language_constants.dart';
import 'package:ecommerce_app_eid/screens/product_detail.dart';
import 'package:ecommerce_app_eid/screens/shopping_cart.dart';
import 'package:ecommerce_app_eid/skeletons/category_list_skeleton.dart';
import 'package:ecommerce_app_eid/skeletons/product_list_skeleton.dart';
import 'package:ecommerce_app_eid/widgets/category.dart';
import 'package:ecommerce_app_eid/widgets/drawer.dart';
import 'package:ecommerce_app_eid/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductList extends StatefulWidget {
  ProductList({Key key}) : super(key: key);
  static String id = ProductList_Screen_Id;
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  var _loginApiContriller;

  var _textEditingController = TextEditingController();
  int _categorySelectedIndex;
  var _productController;
  var _cartController;
  var _categoryController;
  var _favouriteController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

    _loginApiContriller =
        Provider.of<LoginApiController>(context, listen: false);
    _loginApiContriller.sendRequest();

    _productController = Provider.of<ProductController>(context, listen: false);
    _productController.getAllProducts(_scaffoldKey);

    _categoryController =
        Provider.of<CategoryController>(context, listen: false);
    _categoryController.getAllCategories(_scaffoldKey);

    _cartController = Provider.of<CartController>(context, listen: false);
    _cartController.getSavedCart();

    _favouriteController =
        Provider.of<FavouriteController>(context, listen: false);

    _textEditingController.addListener(_handleSearchField);
    _categorySelectedIndex = 0;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  _handleSearchField() {
    _productController.getProductByCategoryOrName(
      _textEditingController.text,
    );
    _categorySelectedIndex = null;
  }

  Future _handleRefresh() {
    _productController.setIsLoadingAllProducts(true);
    _categoryController.setIsLoadingCategories(true);
    _categoryController.getAllCategories(_scaffoldKey);
    _productController.getAllProducts(_scaffoldKey);
    _categorySelectedIndex = 0;
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double _leftMargin = 10;
    double _rightMargin = 10;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: Container(
        width: size.width * 0.8,
        child: CDrawer(),
      ),
      appBar: AppBar(
        title: Text(
          getTranslated(context, 'ProductList_Screen_Title'),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20, top: _rightMargin),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ShoppingCart.id);
                print(
                    "api_token ${context.read<LoginApiController>().apiToken}");
              },
              child: Badge(
                padding: EdgeInsets.all(5),
                badgeContent: Text(
                  '${context.watch<CartController>().cart.length}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Carousel
            Container(
              height: size.height * 0.20,
              margin: EdgeInsets.only(
                left: _leftMargin,
                right: _rightMargin,
              ),
              child: Consumer<ProductController>(
                builder: (context, productCtlr, child) {
                  if (productCtlr.isLoadingAllProducts) {
                    return Center(
                      child: Shimmer.fromColors(
                        child: ProductListSkeleton(),
                        baseColor: Colors.grey[200],
                        highlightColor: Colors.grey[400],
                      ),
                    );
                  }
                  if (!productCtlr.isLoadingAllProducts &&
                      productCtlr.productList.length == 0) {
                    return Center(
                      child: Text(
                        getTranslated(context, 'RESULT_N_FOUND'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    );
                  } else {
                    return Carousel(
                      dotIncreaseSize: 2,
                      dotIncreasedColor: Color(0xff2c2c54),
                      dotPosition: DotPosition.bottomCenter,
                      boxFit: BoxFit.cover,
                      images: List.generate(
                        productCtlr.productList.length,
                        (index) => ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            productCtlr.productList[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      dotSize: 6.0,
                      dotSpacing: 15.0,
                      dotColor: Color(0xff1FCCB6),
                      animationDuration: Duration(milliseconds: 800),
                      indicatorBgPadding: 5.0,
                      autoplayDuration: Duration(seconds: 10),
                      dotBgColor: Colors.transparent,
                      borderRadius: true,
                    );
                  }
                },
              ),
            ),
            //search field,title
            RefreshIndicator(
              onRefresh: _handleRefresh,
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  //search field
                  Container(
                    height: size.height / 15,
                    margin: EdgeInsets.only(
                      left: _leftMargin,
                      right: _rightMargin,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: getTranslated(context, 'SEARCH_TEXT'),
                        contentPadding: EdgeInsets.only(
                          top: 8,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        fillColor: Colors.grey[300],
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),

                  //title
                  /* Container(
                    margin: EdgeInsets.only(left: _leftMargin),
                    child: Text(
                      getTranslated(context, 'TITLE_TEXT'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),*/
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),

            // Horizontal list of categories
            Container(
              height: size.height * 0.06,
              margin: EdgeInsets.only(left: _leftMargin, right: _rightMargin),
              child: Consumer<CategoryController>(
                builder: (context, cateogoryCtlr, child) {
                  if (cateogoryCtlr.isLoadingCategories) {
                    return Shimmer.fromColors(
                      child: CategoryListSkeleton(),
                      baseColor: Colors.grey[200],
                      highlightColor: Colors.grey[400],
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cateogoryCtlr.categoryList.length,
                      itemBuilder: (context, index) {
                        return Category(
                          category: cateogoryCtlr.categoryList[index].category,
                          categoryIndex: index,
                          categorySelectedIndex: _categorySelectedIndex,
                          onTapped: () {
                            if (cateogoryCtlr.categoryList[index].category !=
                                null) {
                              setState(() {
                                _categorySelectedIndex = index;
                              });
                              _productController.getProductByCategory(
                                cateogoryCtlr.categoryList[index].category,
                                _scaffoldKey,
                              );
                            }
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),

            SizedBox(
              height: 10,
            ),

            // List of products
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: _leftMargin,
                  right: _rightMargin,
                ),
                child: Consumer<ProductController>(
                  builder: (context, productCtlr, child) {
                    if (productCtlr.isLoadingAllProducts) {
                      return Center(
                        child: Shimmer.fromColors(
                          child: ProductListSkeleton(),
                          baseColor: Colors.grey[200],
                          highlightColor: Colors.grey[400],
                        ),
                      );
                    }
                    if (!productCtlr.isLoadingAllProducts &&
                        productCtlr.productList.length == 0) {
                      return Center(
                        child: Text(
                          getTranslated(context, 'RESULT_N_FOUND'),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      );
                    } else {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 15,
                        ),
                        itemCount: productCtlr.productList.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: productCtlr.productList[index],
                            onProductTapped: () {
                              _cartController.setCurrentItem(
                                productCtlr.productList[index],
                              );
                              _favouriteController.setCurrentItem(
                                productCtlr.productList[index],
                              );
                              Navigator.pushNamed(context, ProductDetail.id);
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
