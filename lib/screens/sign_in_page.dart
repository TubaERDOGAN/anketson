//import 'dart:js';
import 'package:ankets/screens/login_page.dart';
import 'package:ankets/screens/second_sign_in_page.dart';
import 'package:flutter/material.dart';
//import 'package:ankets/screens/second_sign_in_page.dart';
//import 'package:ankets/constants.dart';
//import 'package:ankets/localekeys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:adobe_xd/pinned.dart';
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
  bool _isObscure = false;//boolean value to track password view enable disable.
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffffffff),
      body: Form(
      key: _formKey,
      child:Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0, -1.0),
                end: Alignment(0.0, 1.0),
                colors: [
                  Color(0xff8f9d97),
                  Color(0xff919a94),
                  Color(0xffc45d54)
                ],
                stops: [0.0, 0.402, 1.0],
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
                filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0x8affffff),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(36.0),
                      topRight: Radius.circular(36.0),
                    ),
                    border:
                    Border.all(width: 1.0, color: const Color(0x4fffffff)),
                  ),
                ),
              ),
            ),
          ),
          /// En tepedeki Sign up yazısı
          Pinned.fromPins(
            Pin(start: 98.0, end: 99.0),
            Pin(size: 24.0, middle: 0.2800),
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 20,
                color: Color(0xff000000),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          /// USERNAME
          Pinned.fromPins(
            Pin(start: 56.0, end: 58.0),
            Pin(size: 52.0, middle: 0.3614),
            child: Container(
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
                child:  Align(
                  alignment: const Alignment(-0.198, 0.026),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter user name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: const Padding(
                          padding:  EdgeInsets.only(left:5.0),
                          child: Icon(
                              Icons.people,
                              color: Color(0xffc45d54))
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                )
            ),
          ),

          /// email
          Pinned.fromPins(
            Pin(start: 56.0, end: 58.0),
            Pin(size: 52.0, middle: 0.4464),
            child: Container(
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
                child:  Align(
                  alignment: const Alignment(-0.198, 0.184),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.disabled,
                    controller: emailController,
                    decoration: const InputDecoration(
                      icon: const Padding(
                          padding:  EdgeInsets.only(left:5.0),
                          child: Icon(
                              Icons.email,
                              color: Color(0xffc45d54))
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                )
            ),
          ),

          /// PASWORD
          Pinned.fromPins(
            Pin(start: 57.0, end: 57.0),
            Pin(size: 52.0, middle: 0.5314),
            child: Container(
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
                child:  Align(
                  alignment: const Alignment(-0.188, 0.356),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: _isObscure, //if passenable == true, show **, else show password character
                    validator: (value) {
                      if (value == null || value.isEmpty) {

                        return 'Please enter password';
                      }

                      if (value.length < 8) {
                        return 'Must be more than 8 charater';
                      }
                      return null;

                    },
                    decoration:  InputDecoration(
                      icon: const Padding(
                          padding:  EdgeInsets.only(left:5.0),
                          child: Icon(
                              Icons.lock,
                              color: Color(0xffc45d54))
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(
                              color: Color(0xffc45d54),
                              _isObscure ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                )
            ),
          ),

          /// Confirm Password
          Pinned.fromPins(
            Pin(start: 57.0, end: 57.0),
            Pin(size: 52.0, middle: 0.6164),
            child: Container(
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
                child:  Align(
                  alignment: const Alignment(-0.188, 0.514),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: cpasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: _isObscure, //if passenable == true, show **, else show password character
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      if (value.length < 8) {
                        return 'Must be more than 8 charater';
                      }
                      return null;
                    },
                    decoration:  InputDecoration(
                      icon: const Padding(
                          padding:  EdgeInsets.only(left:5.0),
                          child: Icon(
                              Icons.lock,
                              color: Color(0xffc45d54))
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(
                              color: Color(0xffc45d54),
                              _isObscure ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                )
            ),
          ),

          /// SIGNUPBUTTON
          Pinned.fromPins(
            Pin(start: 57.0, end: 57.0),
            Pin(size: 52.0, end: 175.0),
            child: Container(
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
                child:  Align(
                    alignment: const Alignment(0.005, 0.169),
                    child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            bool mCheckError = false;
                            /*if (emailController.value.text == ""){
                              mCheckError = true;
                            }
                            if (usernameController.value.text == ""){
                              mCheckError = true;
                            }
                            if (passwordController.value.text == ""){
                              mCheckError = true;
                            }
                            if (cpasswordController.value.text == ""){
                              mCheckError = true;
                            }*/

                            if(!mCheckError){
                              //showAlertDialog(context, "1");
                              postRequest (context,usernameController.value.text, emailController.value.text, passwordController.value.text);
                            }
                          }else{
                            showAlertDialog1(context, "2");
                          }
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontFamily: 'Work Sans',
                            fontSize: 16,
                            color:  Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        )
                    )
                )
            ),
          ),
          /// burada boxlar bitiyo
          Pinned.fromPins(
              Pin(size: 196.0, middle: 0.5025),
              Pin(size: 14.0, end: 150.0),
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
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Work Sans',
                    fontSize: 12,
                    color: Color(0xff000000),
                  ),
                  textAlign: TextAlign.center,
                ),
              )
          ),

        ],
      ),
    )
    ));
  }

  Future<http.Response> postRequest (BuildContext context, String username, String email, String password) async {
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

    if(response.statusCode == 200){

      //showAlertDialog1(context, response.body);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("UnicID", returnedData["UnicID"]);
      sharedPreferences.setString("email", email);
      Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => SecondSignInPage()));

      //bu kadar;)

    }else{
      //hata kontrolü ve uyarısı
      showAlertDialog1(context, response.body);

    }

    return response;
  }

  //username kontrolü - username veritabanında yoksa true değer dönüyor!
  Future<bool> postRequestCheckUsername (BuildContext context, String username) async {
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

    if(response.statusCode == 200){

      if(returnedData["Check"] == true){
        return true;
      }else{
        return false;
      }

    }else{
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SecondSignInPage())
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(""),
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
}




const String _svg_xp7tu =
    '<svg viewBox="-243.2 -327.5 779.2 716.5" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 536.04, 219.47)" d="M 1.024306038743816e-05 184.1095581054688 C 7.517889116570586e-06 285.7896118164062 100.297233581543 368.2178955078125 224.0208892822266 368.2178955078125 C 274.1476745605469 368.2178649902344 320.4256591796875 354.6895446777344 357.7494201660156 331.8302612304688 C 352.7652893066406 349.4608764648438 350.0668640136719 368.312255859375 350.0668640136719 387.898193359375 C 350.0668640136719 486.4231567382812 418.3290100097656 566.2928466796875 502.5333862304688 566.2928466796875 C 586.7387084960938 566.2928466796875 654.9998779296875 486.4231262207031 654.9998779296875 387.898193359375 C 654.9998779296875 289.3731994628906 586.7387084960938 209.5035095214844 502.5333862304688 209.5035095214844 C 481.3537902832031 209.5035400390625 461.1823120117188 214.5567932128906 442.8525085449219 223.688720703125 C 446.2498474121094 210.9415893554688 448.0417785644531 197.694580078125 448.0417785644531 184.1095581054688 C 448.0417785644531 82.4283447265625 347.7445373535156 6.103515625e-05 224.0209045410156 6.103515625e-05 C 100.2972412109375 6.103515625e-05 1.296826212637825e-05 82.4283447265625 1.024306038743816e-05 184.1095581054688 Z" fill="#c45d54" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
