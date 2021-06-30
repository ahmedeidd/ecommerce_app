import 'package:flutter/material.dart';

enum SnackBarType { Error, Success }

class GlobalSnackBar {
  static showSnackbar(
    GlobalKey<ScaffoldState> scaffoldKey,
    String message,
    SnackBarType type,
  ) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          '$message',
          style: TextStyle(fontSize: 15),
        ),
        backgroundColor:
            type == SnackBarType.Error ? Colors.red[900] : Colors.blue[700],
      ),
    );
  }
}
