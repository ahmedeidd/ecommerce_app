import 'package:ecommerce_app_eid/constants/screens_ids.dart';
import 'package:ecommerce_app_eid/constants/screens_titles.dart';
import 'package:ecommerce_app_eid/constants/tasks.dart';
import 'package:ecommerce_app_eid/controllers/activity_tracker_controller.dart';
import 'package:ecommerce_app_eid/controllers/auth_controller.dart';
import 'package:ecommerce_app_eid/localization/language_constants.dart';
import 'package:ecommerce_app_eid/screens/Profile.dart';
import 'package:ecommerce_app_eid/screens/order_histroy.dart';
import 'package:ecommerce_app_eid/screens/shipping_screen.dart';
import 'package:ecommerce_app_eid/utils/validator.dart';
import 'package:ecommerce_app_eid/widgets/auth_screen_custom_painter.dart';
import 'package:ecommerce_app_eid/widgets/dialog.dart';
import 'package:ecommerce_app_eid/widgets/round_icon_button.dart';
import 'package:ecommerce_app_eid/widgets/under_lined_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  //used for navigation using named route
  static String id = AuthScreen_Id;
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

enum AuthScreenId { SignIn_Screen, SignUp_Screen, ForgotPassword_Screen }

class _AuthScreenState extends State<AuthScreen> {
  var _formKey = GlobalKey<FormState>();
  var _screenTitle = SignIn_Screen_Title;
  AuthScreenId _authScreenId = AuthScreenId.SignIn_Screen;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;
  String _password;
  String _name;

  var _authController;
  var _progressDialog;

  @override
  void initState() {
    super.initState();
    _authController = AuthController();
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = CDialog(context).dialog;
    var size = MediaQuery.of(context).size;
    var leftMargin = size.width / 10;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height / 2.5,
                      child: CustomPaint(
                        painter: AuthScreenCustomPainter(),
                      ),
                    ),
                    Positioned(
                      child: Text(
                        _screenTitle,
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                      top: size.height / 5,
                      left: leftMargin,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(left: leftMargin, right: leftMargin),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: formTextFields() + formButtons(size),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  //****************************************************************************
  List<Widget> formTextFields() {
    if (_authScreenId == AuthScreenId.SignIn_Screen) {
      return [
        SizedBox(
          height: 15,
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: getTranslated(context, 'Email_key'),
            hintText: "e.g example@gmail.com",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          onSaved: (value) => _email = value,
          validator: (value) {
            if (value.isEmpty) {
              return getTranslated(context, 'Email_is_required');
            }
            if (!Validator.isEmailValid(value)) {
              return getTranslated(context, 'Invalid_email');
            }
            return null;
          },
          key: ValueKey("sign_up_email_field"),
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: getTranslated(context, 'Password_text'),
            hintText: "e.g secret",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          obscureText: true,
          onSaved: (value) => _password = value,
          validator: (value) {
            if (value.isEmpty) {
              return getTranslated(context, 'Password_is_required');
            }
            return null;
          },
          key: ValueKey("sign_up_password_field"),
        ),
        SizedBox(
          height: 30,
        ),
      ];
    } else if (_authScreenId == AuthScreenId.SignUp_Screen) {
      return [
        TextFormField(
          decoration: InputDecoration(
            labelText: getTranslated(context, 'Name_key_2'),
            hintText: "e.g ahmed eid",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          onSaved: (value) => _name = value,
          validator: (value) {
            if (value.isEmpty) {
              return getTranslated(context, 'Name_is_required');
            }
            return null;
          },
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: getTranslated(context, 'Email_key'),
            hintText: "e.g example@gmail.com",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          onSaved: (value) => _email = value,
          validator: (value) {
            if (value.isEmpty) {
              return getTranslated(context, 'Email_is_required');
            }
            if (!Validator.isEmailValid(value)) {
              return getTranslated(context, 'Invalid_email');
            }
            return null;
          },
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: getTranslated(context, 'Password_text'),
            hintText: "e.g secret",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          obscureText: true,
          onSaved: (value) => _password = value,
          validator: (value) {
            if (value.isEmpty) {
              return getTranslated(context, 'Password_is_required');
            }
            if (value.length < 6) {
              return getTranslated(context, 'Too_short');
            }
            return null;
          },
        ),
        SizedBox(
          height: 20,
        ),
      ];
    }
    //forogt password input field
    return [
      TextFormField(
        decoration: InputDecoration(
          labelText: getTranslated(context, 'Email_key'),
          hintText: "e.g example@gmail.com",
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) => _email = value,
        validator: (value) {
          if (value.isEmpty) {
            return getTranslated(context, 'Email_is_required');
          }
          if (!Validator.isEmailValid(value)) {
            return getTranslated(context, 'Invalid_email');
          }
          return null;
        },
      ),
    ];
  }

  //****************************************************************************
  List<Widget> formButtons(size) {
    if (_authScreenId == AuthScreenId.SignIn_Screen) {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getTranslated(context, 'Sign_In'),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            RoundIconButton(
              width: size.width / 5,
              height: size.width / 5,
              backgroundColor: Color(0xff4b515a),
              iconColor: Colors.white,
              iconData: Icons.arrow_forward,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  await _progressDialog.show();

                  if (await _authController.emailAndPasswordSignIn(
                    _email,
                    _password,
                    _scaffoldKey,
                  )) {
                    await _progressDialog.hide();
                    chooseNextScreen();
                  } else {
                    await _progressDialog.hide();
                  }
                }
              },
            ),
          ],
        ),
        SizedBox(
          height: 40,
        ),
        //row with sign up and forgot password link
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // sign up link
            GestureDetector(
              child: UnderlinedText(
                text: getTranslated(context, 'Sign_up'),
                decorationThickness: 3,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              onTap: () {
                setState(() {
                  _screenTitle = SignUp_Screen_Title;
                  _authScreenId = AuthScreenId.SignUp_Screen;
                });
              },
            ),
            // forgot password link
            GestureDetector(
              onTap: () {
                setState(() {
                  _screenTitle = ForgotPassword_Screen_Ttile;
                  _authScreenId = AuthScreenId.ForgotPassword_Screen;
                });
              },
              child: UnderlinedText(
                text: getTranslated(context, 'Forgot_password'),
                decorationThickness: 3,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ];
    }
    if (_authScreenId == AuthScreenId.SignUp_Screen) {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getTranslated(context, 'Sign_up'),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            RoundIconButton(
              width: size.width / 5.5,
              height: size.width / 5.5,
              backgroundColor: Color(0xff4b515a),
              iconData: Icons.arrow_forward,
              iconColor: Colors.white,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  await _progressDialog.show();

                  if (await _authController.emailNameAndPasswordSignUp(
                    _name,
                    _email,
                    _password,
                    _scaffoldKey,
                  )) {
                    await _progressDialog.hide();
                    chooseNextScreen();
                  } else {
                    await _progressDialog.hide();
                  }
                }
              },
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        //row with sign in link
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: UnderlinedText(
                text: getTranslated(context, 'Sign_In'),
                decorationThickness: 3,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              onTap: () {
                setState(() {
                  _screenTitle = SignIn_Screen_Title;
                  _authScreenId = AuthScreenId.SignIn_Screen;
                });
              },
            ),
          ],
        ),
      ];
    }

    //forgot password button
    return [
      SizedBox(
        height: 40,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getTranslated(context, 'Forgot_password'),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          RoundIconButton(
            width: size.width / 5.5,
            height: size.width / 5.5,
            backgroundColor: Color(0xff4b515a),
            iconData: Icons.arrow_forward,
            iconColor: Colors.white,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                await _progressDialog.show();
                if (await _authController.forgotPassword(
                    _email, _scaffoldKey)) {
                  await _progressDialog.hide();
                  _formKey.currentState.reset();
                } else {
                  await _progressDialog.hide();
                }
              }
            },
          ),
        ],
      ),
      SizedBox(
        height: 40,
      ),
      //back to signin link
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: UnderlinedText(
              text: getTranslated(context, 'Sign_In'),
              decorationThickness: 3,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            onTap: () {
              setState(() {
                _screenTitle = SignIn_Screen_Title;
                _authScreenId = AuthScreenId.SignIn_Screen;
              });
            },
          ),
        ],
      ),
    ];
  }

  //****************************************************************************
  void chooseNextScreen() async {
    String _currentTask =
        Provider.of<ActivityTracker>(context, listen: false).currentTask;

    switch (_currentTask) {
      case VIEWING_ORDER_HISTORY:
        Navigator.pushReplacementNamed(context, OrderHistroy.id);
        break;
      case VIEWING_PROFILE:
        Navigator.pushReplacementNamed(context, Profile.id);
        break;
      default:
        Navigator.pushReplacementNamed(context, Shipping.id);
        break;
    }
  }
}
