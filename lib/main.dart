import 'package:ecommerce_app_eid/controllers/activity_tracker_controller.dart';
import 'package:ecommerce_app_eid/controllers/cart_controller.dart';
import 'package:ecommerce_app_eid/controllers/category_controller.dart';
import 'package:ecommerce_app_eid/controllers/favourite_controller.dart';
import 'package:ecommerce_app_eid/controllers/loginApi_controller.dart';
import 'package:ecommerce_app_eid/controllers/order_controller.dart';
import 'package:ecommerce_app_eid/controllers/product_controller.dart';
import 'package:ecommerce_app_eid/controllers/shipping_controller.dart';
import 'package:ecommerce_app_eid/localization/language_constants.dart';
import 'package:ecommerce_app_eid/screens/Product_list.dart';
import 'package:ecommerce_app_eid/screens/Profile.dart';
import 'package:ecommerce_app_eid/screens/auth_screen.dart';
import 'package:ecommerce_app_eid/screens/favourite_screen.dart';
import 'package:ecommerce_app_eid/screens/order_histroy.dart';
import 'package:ecommerce_app_eid/screens/payment_method_screen.dart';
import 'package:ecommerce_app_eid/screens/product_detail.dart';
import 'package:ecommerce_app_eid/screens/shipping_screen.dart';
import 'package:ecommerce_app_eid/screens/shopping_cart.dart';
import 'package:ecommerce_app_eid/screens/single_order.dart';
import 'package:ecommerce_app_eid/screens/thank_you_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'localization/demo_localization.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.grey,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.grey,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    if (_locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800]),
          ),
        ),
      );
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => CategoryController()),
        ChangeNotifierProvider(create: (context) => CartController()),
        ChangeNotifierProvider(create: (context) => ShippingController()),
        ChangeNotifierProvider(create: (context) => OrderController()),
        ChangeNotifierProvider(create: (context) => ActivityTracker()),
        ChangeNotifierProvider(create: (context) => FavouriteController()),
        ChangeNotifierProvider(create: (context) => LoginApiController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce app',
        locale: _locale,
        supportedLocales: [
          Locale("en", "US"),
          Locale("ar", "SA"),
        ],
        localizationsDelegates: [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        theme: ThemeData(
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: ProductList.id,
        routes: {
          ProductList.id: (context) => ProductList(),
          ShoppingCart.id: (context) => ShoppingCart(),
          ProductDetail.id: (context) => ProductDetail(),
          Shipping.id: (context) => Shipping(),
          PaymentMethod.id: (context) => PaymentMethod(),
          Thanks.id: (context) => Thanks(),
          SingleOrder.id: (context) => SingleOrder(),
          AuthScreen.id: (context) => AuthScreen(),
          OrderHistroy.id: (context) => OrderHistroy(),
          Profile.id: (context) => Profile(),
          FavouriteScreen.id: (context) => FavouriteScreen(),
        },
      ),
    );
  }
}
