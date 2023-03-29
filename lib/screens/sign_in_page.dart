//import 'dart:js';
import 'dart:ffi';

import 'package:ankets/screens/forgot_password.dart';
import 'package:ankets/screens/login_page.dart';
import 'package:ankets/screens/second_sign_in_page.dart';
import 'package:flutter/material.dart';
//import 'package:ankets/constants.dart';
//import 'package:ankets/localekeys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class   _SignInPageState extends State<SignInPage> {

  bool girisyapildimi = false;
  bool _isObscure = false; //boolean value to track password view enable disable.
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery
        .of(context)
        .viewInsets
        .bottom;
    final size = MediaQuery
        .of(context)
        .size; //getting the size property
    final orientation = MediaQuery
        .of(context)
        .orientation; //getting the orientation

    return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return MobilePage();
          } else if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
            return MobilePage();
          } else {
            return WebPage();
          }
        });
  }

  MaterialApp MobilePage() {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,

                child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, 1.0),
                            colors: [
                              Color(0xff8fa8a2),
                              Color(0xff9f928b),
                              Color(0xffc45d54)
                            ],
                            stops: [0.0, 0.623, 1.0],
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: -243.2, end: -143.0),
                        Pin(size: 716.5, start: -327.5),
                        child: SvgPicture.string(
                          _svg_xp7tu,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(size: 600.0, end: 0.0),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(
                                sigmaX: 4.0, sigmaY: 4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0x8affffff),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(36.0),
                                  topRight: Radius.circular(36.0),
                                ),
                                border:
                                Border.all(width: 1.0, color: const Color(
                                    0x4fffffff)),
                              ),
                            ),
                          ),
                        ),
                      ),

                      ///Usermane Pin
                      Positioned(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.14,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.1),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.8,
                                decoration: BoxDecoration(
                                  color: const Color(0xc7ffffff),
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x14000000),
                                      offset: Offset(3, 3),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction,
                                  controller: usernameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter user name';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    icon: Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Icon(
                                            Icons.people,
                                            color: Color(0xffc45d54))
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior
                                        .never,
                                    border: InputBorder.none,
                                    labelText: 'Username',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Work Sans',
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ))),

                      ///Email
                      Positioned(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.26,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.1),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.8,
                                decoration: BoxDecoration(
                                  color: const Color(0xc7ffffff),
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x14000000),
                                      offset: Offset(3, 3),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction,
                                  controller: emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    icon: Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Icon(
                                            Icons.email,
                                            color: Color(0xffc45d54))
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior
                                        .never,
                                    border: InputBorder.none,
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Work Sans',
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ))),

                      ///Password
                      Positioned(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.38,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.1),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.8,
                                decoration: BoxDecoration(
                                  color: const Color(0xc7ffffff),
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x14000000),
                                      offset: Offset(3, 3),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  controller: passwordController,
                                  obscureText: _isObscure,
                                  //if passenable == true, show **, else show password character
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter password';
                                    }
                                    if (value.length < 8) {
                                      return 'Must be more than 8 charater';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    icon: const Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Icon(
                                            Icons.lock,
                                            color: Color(0xffc45d54))
                                    ),
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                            color: Color(0xffc45d54),
                                            _isObscure
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        }),
                                    floatingLabelBehavior: FloatingLabelBehavior
                                        .never,
                                    border: InputBorder.none,
                                    labelText: 'Password',
                                    labelStyle: const TextStyle(
                                      fontFamily: 'Work Sans',
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ))),

                      ///   Confirm Password
                      Positioned(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery
                                .of(context)
                                .size
                                .width * 0.1),
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.8,
                              decoration: BoxDecoration(
                                color: const Color(0xc7ffffff),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x14000000),
                                    offset: Offset(3, 3),
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                controller: cpasswordController,
                                obscureText: _isObscure,
                                //if passenable == true, show **, else show password character
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm password';
                                  }
                                  if (value.length < 8) {
                                    return 'Must be more than 8 charater';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  icon: const Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: Icon(
                                          Icons.lock,
                                          color: Color(0xffc45d54))
                                  ),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                          color: Color(0xffc45d54),
                                          _isObscure ? Icons.visibility : Icons
                                              .visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      }),
                                  floatingLabelBehavior: FloatingLabelBehavior
                                      .never,
                                  border: InputBorder.none,
                                  labelText: 'Confirm Password',
                                  labelStyle: const TextStyle(
                                    fontFamily: 'Work Sans',
                                    fontSize: 14,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                          )),

                      ///login buton pini
                      Positioned(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.65,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.1),
                              child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.8,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffc45d54),
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x14000000),
                                        offset: Offset(3, 3),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: TextButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          bool mCheckError = false;
                                          if (emailController.value.text ==
                                              "") {
                                            mCheckError = true;
                                          }
                                          if (usernameController.value.text ==
                                              "") {
                                            mCheckError = true;
                                          }
                                          if (passwordController.value.text ==
                                              "") {
                                            mCheckError = true;
                                          }
                                          if (cpasswordController.value.text ==
                                              "") {
                                            mCheckError = true;
                                          }

                                          if (!mCheckError) {
                                            //showAlertDialog(context, "1");
                                            postRequest(context,
                                                usernameController.value.text,
                                                emailController.value.text,
                                                passwordController.value.text);
                                          }
                                        } else {
                                          showAlertDialog1(context, "2");
                                        }
                                      },
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          fontFamily: 'Work Sans',
                                          fontSize: 20,
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                  )
                              ))),

                      /// Logine geri dönüş
                      Positioned(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.75,
                          child: Padding(
                              padding: EdgeInsets.only(left: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.33),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginPage()));
                                },
                                child: const Text(
                                  'Already have an account?  Log in!',
                                  style: TextStyle(
                                    fontFamily: 'Work Sans',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff000000),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                          )),

                    ]))));
  }

  /// WEB DESIGN
  /// WEB DESIGN
  /// WEB DESIGN
  MaterialApp WebPage() {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, 1.0),
                            colors: [
                              Color(0xff8fa8a2),
                              Color(0xff9f928b),
                              Color(0xffc45d54)
                            ],
                            stops: [0.0, 0.623, 1.0],
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: -243.2, end: -143.0),
                        Pin(size: 716.5, start: -327.5),
                        child: SvgPicture.string(
                          _svg_xp7tu,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(size: 600.0, end: 0.0),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(
                                sigmaX: 4.0, sigmaY: 4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0x8affffff),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(36.0),
                                  topRight: Radius.circular(36.0),
                                ),
                                border:
                                Border.all(width: 1.0, color: const Color(
                                    0x4fffffff)),
                              ),
                            ),
                          ),
                        ),
                      ),

                      ///Usermane Pin
                      Positioned(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.2,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.1),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.8,
                                decoration: BoxDecoration(
                                  color: const Color(0xc7ffffff),
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x14000000),
                                      offset: Offset(3, 3),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction,
                                  controller: usernameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter user name';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    icon: Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Icon(
                                            Icons.people,
                                            color: Color(0xffc45d54))
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior
                                        .never,
                                    border: InputBorder.none,
                                    labelText: 'Username',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Work Sans',
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ))),

                      ///Email
                      Positioned(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.32,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.1),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.8,
                                decoration: BoxDecoration(
                                  color: const Color(0xc7ffffff),
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x14000000),
                                      offset: Offset(3, 3),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction,
                                  controller: emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    icon: Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Icon(
                                            Icons.email,
                                            color: Color(0xffc45d54))
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior
                                        .never,
                                    border: InputBorder.none,
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Work Sans',
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ))),

                      ///Password
                      Positioned(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.44,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.1),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.8,
                                decoration: BoxDecoration(
                                  color: const Color(0xc7ffffff),
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x14000000),
                                      offset: Offset(3, 3),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  controller: passwordController,
                                  obscureText: _isObscure,
                                  //if passenable == true, show **, else show password character
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter password';
                                    }
                                    if (value.length < 8) {
                                      return 'Must be more than 8 charater';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    icon: const Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Icon(
                                            Icons.lock,
                                            color: Color(0xffc45d54))
                                    ),
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                            color: Color(0xffc45d54),
                                            _isObscure
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        }),
                                    floatingLabelBehavior: FloatingLabelBehavior
                                        .never,
                                    border: InputBorder.none,
                                    labelText: 'Password',
                                    labelStyle: const TextStyle(
                                      fontFamily: 'Work Sans',
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ))),

                      ///   Confirm Password
                      Positioned(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.56,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery
                                .of(context)
                                .size
                                .width * 0.1),
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.8,
                              decoration: BoxDecoration(
                                color: const Color(0xc7ffffff),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x14000000),
                                    offset: Offset(3, 3),
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                controller: cpasswordController,
                                obscureText: _isObscure,
                                //if passenable == true, show **, else show password character
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm password';
                                  }
                                  if (value.length < 8) {
                                    return 'Must be more than 8 charater';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  icon: const Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: Icon(
                                          Icons.lock,
                                          color: Color(0xffc45d54))
                                  ),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                          color: Color(0xffc45d54),
                                          _isObscure ? Icons.visibility : Icons
                                              .visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      }),
                                  floatingLabelBehavior: FloatingLabelBehavior
                                      .never,
                                  border: InputBorder.none,
                                  labelText: 'Confirm Password',
                                  labelStyle: const TextStyle(
                                    fontFamily: 'Work Sans',
                                    fontSize: 14,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                          )),

                      ///login buton pini
                      Positioned(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.68,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.1),
                              child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.8,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffc45d54),
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x14000000),
                                        offset: Offset(3, 3),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: TextButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          bool mCheckError = false;
                                          if (emailController.value.text ==
                                              "") {
                                            mCheckError = true;
                                          }
                                          if (usernameController.value.text ==
                                              "") {
                                            mCheckError = true;
                                          }
                                          if (passwordController.value.text ==
                                              "") {
                                            mCheckError = true;
                                          }
                                          if (cpasswordController.value.text ==
                                              "") {
                                            mCheckError = true;
                                          }

                                          if (!mCheckError) {
                                            postRequest(context,
                                                  usernameController.value.text,
                                                  emailController.value.text,
                                                  passwordController.value
                                                      .text);
                                          }
                                        } else {
                                          showAlertDialog1(context, "2");
                                        }
                                      },
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          fontFamily: 'Work Sans',
                                          fontSize: 20,
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                  )
                              ))),

                      /// Logine geri dönüş
                      Positioned(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.79,
                          child: Padding(
                              padding: EdgeInsets.only(left: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.40),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginPage()));
                                },
                                child: const Text(
                                  'Already have an account?  Log in!',
                                  style: TextStyle(
                                    fontFamily: 'Work Sans',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff000000),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                          )),

                    ]))));
  }

  Future<http.Response> postRequest(BuildContext context, String username,
      String email, String password) async {
    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/userdata/';
    Uri urlU = Uri.parse(url);
    Map data = {
      'Username': username,
      'Password': password,
      'Email': email,
    };

    //encode Map to JSON
    var body = json.encode(data);

    final response = await http.post(urlU,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    final returnedData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      //showAlertDialog1(context, response.body);
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      sharedPreferences.setString("UnicID", returnedData["UnicID"]);
      sharedPreferences.setString("email", email);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SecondSignInPage()));

      //bu kadar;)

    } else {
      //hata kontrolü ve uyarısı

      if(returnedData["ErrorCode"] == 1){
        showAlertDialog1(context, "Kullanıcı adı daha önce alınmış!");
      }else if(returnedData["ErrorCode"] == 4){
        showAlertDialog1(context, "Mail adresi ile daha önce kayıt olunmuş!");
      }else{

      }

    }

    return response;
  }

  //username kontrolü - username veritabanında yoksa true değer dönüyor!
  Future<bool> postRequestCheckUsername(BuildContext context,
      String username) async {
    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/userdata/';
    Uri urlU = Uri.parse(url);
    Map data = {
      'Username': username
    };

    //encode Map to JSON
    var body = json.encode(data);

    final response = await http.post(urlU,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    final returnedData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (returnedData["Check"] == true) {
        return true;
      } else {
        return false;
      }
    } else {
      //hata kontrolü ve uyarısı
      showAlertDialog1(context, response.body);
    }

    return false;
  }

  Future<void> readySharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {});
  }

  showAlertDialog1(BuildContext context, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Uyarı!"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<http.Response> postCheckMail(BuildContext context, String mail) async {
    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/checkmail/';
    Uri urlU = Uri.parse(url);
    Map data = {
      'Mail': mail,
    };
    //encode Map to JSON
    var body = json.encode(data);

    print(body);

    final response = await http.post(urlU,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    final returnedData = jsonDecode(response.body);

    print(response.body);

    if (response.statusCode == 200) {
      bool mCheck = bool.hasEnvironment(returnedData['Check']);
      if (!mCheck) {
        showAlertDialog1(context, "Mail daha önce kullanılmıştır!");
      }
      return response;
    }

    return response;
  }
}

String _svg_xp7tu =
    '<svg viewBox="-243.2 -327.5 779.2 716.5" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 536.04, 219.47)" d="M 1.024306038743816e-05 184.1095581054688 C 7.517889116570586e-06 285.7896118164062 100.297233581543 368.2178955078125 224.0208892822266 368.2178955078125 C 274.1476745605469 368.2178649902344 320.4256591796875 354.6895446777344 357.7494201660156 331.8302612304688 C 352.7652893066406 349.4608764648438 350.0668640136719 368.312255859375 350.0668640136719 387.898193359375 C 350.0668640136719 486.4231567382812 418.3290100097656 566.2928466796875 502.5333862304688 566.2928466796875 C 586.7387084960938 566.2928466796875 654.9998779296875 486.4231262207031 654.9998779296875 387.898193359375 C 654.9998779296875 289.3731994628906 586.7387084960938 209.5035095214844 502.5333862304688 209.5035095214844 C 481.3537902832031 209.5035400390625 461.1823120117188 214.5567932128906 442.8525085449219 223.688720703125 C 446.2498474121094 210.9415893554688 448.0417785644531 197.694580078125 448.0417785644531 184.1095581054688 C 448.0417785644531 82.4283447265625 347.7445373535156 6.103515625e-05 224.0209045410156 6.103515625e-05 C 100.2972412109375 6.103515625e-05 1.296826212637825e-05 82.4283447265625 1.024306038743816e-05 184.1095581054688 Z" fill="#c45d54" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
