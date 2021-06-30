import 'package:ecommerce_app_eid/constants/screens_ids.dart';
import 'package:ecommerce_app_eid/controllers/auth_controller.dart';
import 'package:ecommerce_app_eid/controllers/cart_controller.dart';
import 'package:ecommerce_app_eid/controllers/order_controller.dart';
import 'package:ecommerce_app_eid/controllers/shipping_controller.dart';
import 'package:ecommerce_app_eid/localization/language_constants.dart';
import 'package:ecommerce_app_eid/screens/thank_you_screen.dart';
import 'package:ecommerce_app_eid/services/stripe_service.dart';
import 'package:ecommerce_app_eid/widgets/dialog.dart';
import 'package:ecommerce_app_eid/widgets/global_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentMethod extends StatefulWidget {
  PaymentMethod({Key key}) : super(key: key);
  static String id = PaymentMethod_Screen_Id;
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  var _authController;
  var _cartController;
  var _shippingController;
  var _orderController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _progressDialog;

  @override
  void initState() {
    super.initState();
    _authController = AuthController();
    _cartController = Provider.of<CartController>(context, listen: false);
    _shippingController =
        Provider.of<ShippingController>(context, listen: false);
    _orderController = Provider.of<OrderController>(context, listen: false);
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var totalItemPrice = _cartController.cart.fold(
      0,
      (
        previousValue,
        element,
      ) =>
          previousValue + (element.product.price * element.quantity),
    );
    int tax = _orderController.tax;
    int shippingCost = _orderController.shippingCost;
    var total = totalItemPrice + tax + shippingCost;
    String totalToString = total.toString() + '100';

    _progressDialog = CDialog(context).dialog;

    //**************************************************************************
    _performStateReset() {
      _cartController.resetCart();
      _shippingController.reset();
    }

    //**************************************************************************
    _handlecashOnDeliverySucessPayment() async {
      var data = await _authController.getUserDataAndLoginStatus();

      _orderController.registerOrderWithStripePayment(
        _shippingController.getShippingDetails(),
        shippingCost.toString(),
        tax.toString(),
        total.toString(),
        totalItemPrice.toString(),
        data[0],
        getTranslated(context, 'cash_on_delivery'),
        _cartController.cart,
        _scaffoldKey,
      );

      await _progressDialog.hide();
      _performStateReset();
      Navigator.pushNamed(context, Thanks.id);
    }

    //**************************************************************************
    _handleStripeSucessPayment() async {
      var data = await _authController.getUserDataAndLoginStatus();

      _orderController.registerOrderWithStripePayment(
        _shippingController.getShippingDetails(),
        shippingCost.toString(),
        tax.toString(),
        total.toString(),
        totalItemPrice.toString(),
        data[0],
        getTranslated(context, 'STRIPE_PAYMENT'),
        _cartController.cart,
        _scaffoldKey,
      );

      await _progressDialog.hide();
      _performStateReset();
      Navigator.pushNamed(context, Thanks.id);
    }

    //**************************************************************************
    _handleStripeFailurePayment() async {
      await _progressDialog.hide();

      GlobalSnackBar.showSnackbar(
        _scaffoldKey,
        getTranslated(context, 'Process_cancelled'),
        SnackBarType.Error,
      );
    }
    //**************************************************************************

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            getTranslated(context, 'Payment_Screen_Title'),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 1,
          backgroundColor: Colors.white,
        ),
        body: Container(
          margin: EdgeInsets.only(
            left: 18,
            top: 18,
            right: 18,
          ),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  //title
                  Text(
                    getTranslated(context, 'Order_summary'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Table(
                    border: TableBorder(
                      horizontalInside: BorderSide(
                        width: .5,
                      ),
                      bottom: BorderSide(
                        width: .5,
                      ),
                      top: BorderSide(
                        width: .5,
                      ),
                    ),
                    children: [
                      //item
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            child: Text(
                              getTranslated(context, 'ITEMS_key'),
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            child: Text(
                              getTranslated(context, 'L_E') + '$totalItemPrice',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      //shipping
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            child: Text(
                              getTranslated(context, 'Shipping_key'),
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            child: Text(
                              getTranslated(context, 'L_E') + '$shippingCost',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      //tax
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: Text(
                              getTranslated(context, 'Tax_key'),
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            child: Text(
                              getTranslated(context, 'L_E') + '$tax',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      //total
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            child: Text(
                              getTranslated(context, 'Total'),
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            child: Text(
                              getTranslated(context, 'L_E') + '$total',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // Payment
                  Text(
                    getTranslated(context, 'Choose_Payment_method'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // cash on Dlivery
                  RaisedButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () async {
                      await _progressDialog.show();

                      _handlecashOnDeliverySucessPayment();

                      await _progressDialog.hide();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delivery_dining,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          getTranslated(context, 'cash_on_delivery'),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    getTranslated(context, 'OR_key'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  //credit or debit button
                  RaisedButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () async {
                      await _progressDialog.show();

                      var result = await StripeService.processPayment(
                          totalToString, 'usd');

                      if (result.success) {
                        _handleStripeSucessPayment();
                      } else {
                        _handleStripeFailurePayment();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.credit_card,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          getTranslated(context, 'Credit_or_Debit_card'),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
