import 'package:ecommerce_app_eid/constants/screens_ids.dart';
import 'package:ecommerce_app_eid/constants/tasks.dart';
import 'package:ecommerce_app_eid/controllers/activity_tracker_controller.dart';
import 'package:ecommerce_app_eid/controllers/order_controller.dart';
import 'package:ecommerce_app_eid/localization/language_constants.dart';
import 'package:ecommerce_app_eid/screens/Product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleOrder extends StatefulWidget {
  SingleOrder({Key key}) : super(key: key);
  static String id = SingleOrder_Screen_Id;
  @override
  _SingleOrderState createState() => _SingleOrderState();
}

class _SingleOrderState extends State<SingleOrder> {
  Future<bool> _onBackPressed() {
    var currentTask =
        Provider.of<ActivityTracker>(context, listen: false).currentTask;
    if (currentTask == VIEWING_SINGLE_OLD_ORDER_HISTORY) {
      Navigator.pop(context);
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        ProductList.id,
        (route) => false,
      );
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              getTranslated(context, 'SingleOrder_Screen_Title') +
                  "${context.watch<OrderController>().singleOrder.id ?? ''}",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 1,
            backgroundColor: Colors.white,
          ),
          body: Container(
            margin: EdgeInsets.only(left: 20.0, right: 10.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //order details
                    SizedBox(height: 20.0),
                    Text(
                      getTranslated(context, 'SHIPPING_DETAILS'),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      getTranslated(context, 'Date_and_time_ordered') +
                          " ${context.watch<OrderController>().singleOrder.dateOrdered ?? ''}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      getTranslated(context, 'Payment_method') +
                          "${context.watch<OrderController>().singleOrder.paymentMethod ?? ''}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      getTranslated(context, 'Shipping_cost') +
                          getTranslated(context, 'L_E') +
                          "${context.watch<OrderController>().singleOrder.shippingCost ?? ''}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      getTranslated(context, 'Tax') +
                          getTranslated(context, 'L_E') +
                          "${context.watch<OrderController>().singleOrder.tax ?? ''}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      getTranslated(context, 'Total_item_price') +
                          getTranslated(context, 'L_E') +
                          "${context.watch<OrderController>().singleOrder.totalItemPrice ?? ''}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${getTranslated(context, 'Total_key')}" +
                          "${getTranslated(context, 'L_E')}" +
                          "${context.watch<OrderController>().singleOrder.total ?? ''}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),

                    //shipping details
                    SizedBox(height: 20.0),
                    Text(
                      getTranslated(context, 'ORDER_DETAILS'),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      getTranslated(context, 'Name_key') +
                          "${context.watch<OrderController>().singleOrder.shippingDetails.name ?? ''}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      getTranslated(context, 'Phone_Contact') +
                          "${context.watch<OrderController>().singleOrder.shippingDetails.phoneContact ?? ''}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      getTranslated(context, 'Address_Line') +
                          "${context.watch<OrderController>().singleOrder.shippingDetails.addressLine ?? ''}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      getTranslated(context, 'City_key') +
                          "${context.watch<OrderController>().singleOrder.shippingDetails.city ?? ''}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      getTranslated(context, 'Postal_code') +
                          "${context.watch<OrderController>().singleOrder.shippingDetails.postalCode ?? ''}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      getTranslated(context, 'Country_key') +
                          "${context.watch<OrderController>().singleOrder.shippingDetails.country ?? ''}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 20.0),

                    //items
                    Text(
                      getTranslated(context, 'ITEMS_key'),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Consumer<OrderController>(
                      builder: (context, ctlr, child) {
                        if (ctlr.isProcessingOrder &&
                            ctlr.singleOrder.cartItems == null) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: ctlr.singleOrder.cartItems.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getTranslated(context, 'Name_key') +
                                      "${ctlr.singleOrder.cartItems[index].product.name}",
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  getTranslated(context, 'Price_key') +
                                      "${ctlr.singleOrder.cartItems[index].product.price}",
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  getTranslated(context, 'Quantity_key') +
                                      "${ctlr.singleOrder.cartItems[index].quantity}",
                                ),
                                Divider(
                                  thickness: 5,
                                  color: Colors.grey,
                                ),
                                Center(
                                  child: RaisedButton(
                                    elevation: 0,
                                    onPressed: () {},
                                    child: Text(
                                      "${context.watch<ActivityTracker>().currentTask == VIEWING_SINGLE_OLD_ORDER_HISTORY ? getTranslated(context, 'Thank_you_for_the_support') : getTranslated(context, 'WE_will_CONTACT_YOU_SHORTLY')}",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    color: Colors.orange[900],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                              ],
                            );
                          },
                        );
                      },
                    ),

                    SizedBox(height: 10.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
