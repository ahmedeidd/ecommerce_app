import 'package:ecommerce_app_eid/localization/language_constants.dart';
import 'package:ecommerce_app_eid/main.dart';
import 'package:ecommerce_app_eid/models/language.dart';
import 'package:ecommerce_app_eid/screens/Profile.dart';
import 'package:ecommerce_app_eid/screens/favourite_screen.dart';
import 'package:ecommerce_app_eid/screens/order_histroy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cmoon_icons/flutter_cmoon_icons.dart';
import 'package:flutter_phone_state/flutter_phone_state.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

class CDrawer extends StatefulWidget {
  @override
  _CDrawerState createState() => _CDrawerState();
}

class _CDrawerState extends State<CDrawer> {
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image(
              image: AssetImage("assets/images/logo.png"),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: ListTile(
              tileColor: Colors.grey[200],
              leading: Icon(Icons.person),
              trailing: Icon(Icons.people),
              title: Text(
                getTranslated(context, 'ProfileScreen_Title'),
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, Profile.id);
              },
            ),
          ),
          SizedBox(height: 20),
          //OrderHistoryScreen
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: ListTile(
              tileColor: Colors.grey[200],
              leading: Icon(Icons.history),
              trailing: Icon(Icons.history_edu),
              title: Text(
                getTranslated(context, 'OrderHistoryScreen_Title'),
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, OrderHistroy.id);
              },
            ),
          ),
          SizedBox(height: 20),

          // favourite page
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: ListTile(
              tileColor: Colors.grey[200],
              leading: Icon(Icons.favorite),
              trailing: Text(''),
              title: Text(
                getTranslated(context, 'favourite_Screen_Title'),
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, FavouriteScreen.id);
              },
            ),
          ),

          SizedBox(height: 20),
          // language
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: ListTile(
              tileColor: Colors.grey[200],
              trailing: Text(''),
              title: Text(
                getTranslated(context, 'Language_key'),
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              leading: DropdownButton<Language>(
                underline: SizedBox(),
                icon: Icon(
                  Icons.language,
                  color: Colors.black,
                ),
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>(
                      (e) => DropdownMenuItem<Language>(
                        value: e,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              e.flag,
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(e.name)
                          ],
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (Language language) {
                  _changeLanguage(language);
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          // connect with us phone
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: ListTile(
              tileColor: Colors.grey[200],
              trailing: Text(''),
              leading: Icon(
                IconMoon.icon_phone,
              ),
              title: Text(
                getTranslated(context, 'Connect_with_us'),
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {
                FlutterPhoneState.startPhoneCall("01067914459");
              },
            ),
          ),
          SizedBox(height: 20),
          // share by whatsapp
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: ListTile(
              tileColor: Colors.grey[200],
              trailing: Text(''),
              leading: Icon(
                IconMoon.icon_whatsapp,
              ),
              title: Text(
                getTranslated(context, 'share_with_whatsapp'),
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () async {
                Navigator.pop(context);
                await FlutterShareMe().shareToWhatsApp(msg: "");
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: ListTile(
              tileColor: Colors.grey[200],
              trailing: Text(''),
              title: Text(
                'Current Location',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              leading: Icon(
                Icons.pin_drop,
              ),
              onTap: () async {},
            ),
          ),
        ],
      ),
    );
  }
}
