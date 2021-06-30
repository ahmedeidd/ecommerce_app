import 'package:ecommerce_app_eid/constants/screens_ids.dart';
import 'package:ecommerce_app_eid/constants/tasks.dart';
import 'package:ecommerce_app_eid/controllers/auth_controller.dart';
import 'package:ecommerce_app_eid/controllers/order_controller.dart';
import 'package:ecommerce_app_eid/localization/language_constants.dart';
import 'package:ecommerce_app_eid/widgets/guest_user_drawer_widget.dart';
import 'package:ecommerce_app_eid/widgets/no_order_history_found_content.dart';
import 'package:ecommerce_app_eid/widgets/order_history_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderHistroy extends StatefulWidget {
  OrderHistroy({Key key}) : super(key: key);
  static String id = OrderHistoryScreen_Id;
  @override
  _OrderHistroyState createState() => _OrderHistroyState();
}

class _OrderHistroyState extends State<OrderHistroy> {
  var _authController;
  var _orderController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _authController = AuthController();
    _orderController = Provider.of<OrderController>(context, listen: false);
  }

  Future<bool> getTokenValidity() async {
    return await _authController.isTokenValid();
  }

  Future<List<String>> getLoginStatus() async {
    return await _authController.getUserDataAndLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          getTranslated(context, 'OrderHistoryScreen_Title'),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            FutureBuilder(
              future: Future.wait([getTokenValidity(), getLoginStatus()]),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 3),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                var isLoggedInFlag = snapshot.data[1][1];
                var isTokenValid = snapshot.data[0];

                //when user is not signed in
                if (isLoggedInFlag == null || isLoggedInFlag == '0') {
                  return GuestUserDrawerWidget(
                    message: getTranslated(
                      context,
                      'Sign_in_to_see_order_history',
                    ),
                    currentTask: VIEWING_ORDER_HISTORY,
                  );
                }

                //when user token has expired
                if (!isTokenValid) {
                  return GuestUserDrawerWidget(
                    message: getTranslated(
                      context,
                      'Session_expired_Sign_in_to_see_order_history',
                    ),
                    currentTask: VIEWING_ORDER_HISTORY,
                  );
                }

                _orderController.getOrders(_scaffoldKey);

                //user is logged in and token is valid
                return Consumer<OrderController>(
                  builder: (context, orderController, child) {
                    if (orderController.isLoadingOrders) {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 3),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (orderController.orders.length == 0) {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3,
                          ),
                          child: NoOrderHistoryFoundContent(),
                        ),
                      );
                    }
                    return Column(
                      children: [
                        ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: orderController.orders.length,
                          itemBuilder: (context, index) {
                            return OrderHistoryItem(
                              order: orderController.orders[index],
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
