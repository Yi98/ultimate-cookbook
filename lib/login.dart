import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:food_recipe/index.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

import 'sizeConfig.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({Key key}) : super(key: key);

  String title = 'Sign in';
  String enquiryText = 'Don\'t have an account?';
  String oppositeTitle = 'Sign up';

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/login.jpg',
              height: SizeConfig.safeBlockVertical * 100,
              fit: BoxFit.cover,
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 100,
              color: Color.fromRGBO(0, 0, 0, 0.55),
            ),
            Column(
              children: <Widget>[
                Center(
                  child: Container(
                    width: SizeConfig.safeBlockHorizontal * 35,
                    padding: EdgeInsets.only(
                      top: SizeConfig.safeBlockVertical * 5,
                    ),
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                Container(
                  width: SizeConfig.safeBlockHorizontal * 85,
                  padding: EdgeInsets.only(
                    top: SizeConfig.safeBlockVertical * 8,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.title.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.safeBlockHorizontal * 6,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: SizeConfig.safeBlockHorizontal * 85,
                    padding: EdgeInsets.only(
                      top: SizeConfig.safeBlockVertical * 2,
                    ),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        // prefixIcon: Icon(
                        //   Icons.email,
                        //   color: Colors.white70,
                        // ),
                        contentPadding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * 1,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Email address',
                        labelStyle: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white70,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: SizeConfig.safeBlockVertical * 2,
                    ),
                    width: SizeConfig.safeBlockHorizontal * 85,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        // prefixIcon: Icon(
                        //   Icons.lock,
                        //   color: Colors.white70,
                        // ),
                        contentPadding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * 1,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 17.0,
                          color: Colors.grey,
                        ),
                      ),
                      style: new TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.safeBlockHorizontal * 85,
                  padding: EdgeInsets.only(
                    top: 20.0,
                    bottom: 30.0,
                  ),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forget password?',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: SizeConfig.safeBlockHorizontal * 85,
                  child: RaisedButton(
                    color: Colors.deepOrange,
                    onPressed: () {},
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.safeBlockHorizontal * 85,
                  padding: EdgeInsets.symmetric(
                    vertical: 50.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.enquiryText,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: onChooseSignUp,
                        child: Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.safeBlockHorizontal * 2),
                          child: Text(
                            widget.oppositeTitle,
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: SizeConfig.safeBlockHorizontal * 85,
                  child: RaisedButton(
                    color: Colors.blueGrey,
                    onPressed: onContinueAsGuest,
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal * 11,
                          ),
                          child: Icon(
                            Icons.people,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal * 5,
                          ),
                          child: Text(
                            'Continue as guest',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    top: SizeConfig.safeBlockVertical * 2,
                  ),
                  child: Container(
                    width: SizeConfig.safeBlockHorizontal * 85,
                    height: SizeConfig.safeBlockVertical * 6,
                    child: SignInButton(
                      Buttons.Facebook,
                      text: '${widget.title} with Facebook',
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  void onContinueAsGuest() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IndexWidget(),
      ),
    );
  }

  void onChooseSignUp() {
    setState(() {
      if (widget.title == 'Sign in') {
        widget.title = 'Sign up';
        widget.enquiryText = 'Don\'t have an account?';
        widget.oppositeTitle = 'Sign in';
      } else {
        widget.title = 'Sign in';
        widget.enquiryText = 'Already have an account?';
        widget.oppositeTitle = 'Sign up';
      }
    });
  }
}
