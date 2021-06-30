import 'package:ecommerce_app_eid/controllers/activity_tracker_controller.dart';
import 'package:ecommerce_app_eid/localization/language_constants.dart';
import 'package:ecommerce_app_eid/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GuestUserDrawerWidget extends StatelessWidget {
  final String message;
  final String currentTask;
  const GuestUserDrawerWidget(
      {Key key, @required this.message, @required this.currentTask})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
      child: Column(
        children: [
          Text(
            '$message',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          ButtonTheme(
            minWidth: 150,
            child: RaisedButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              color: Colors.orange,
              onPressed: () {
                Provider.of<ActivityTracker>(context, listen: false)
                    .setTaskCurrentTask(currentTask);
                Navigator.pushReplacementNamed(context, AuthScreen.id);
              },
              child: Text(
                getTranslated(context, 'Sign_In'),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
