import 'package:ankets/screens/home_page.dart';
import 'package:ankets/screens/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:ankets/screens/forgot_password.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool girisyapildimi = false;

  bool _isObscure = true;//boolean value to track password view enable disable.

  @override
  Widget build(BuildContext context) {

    readySharedPreferences();

    if (girisyapildimi) {
      return HomePage();
    }else{

      return Scaffold(
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
                Pin(size: 480.0, end: 0.0),
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


              ///passwordpinn

              Pinned.fromPins(
                Pin(start: 57.0, end: 57.0),
                Pin(size: 52.0, middle: 0.6000),

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
                    child: Align(
                      alignment: const Alignment(-0.188, 0.478),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        controller: passwordController,
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
                                color:Color(0xffc45d54),
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
                    ),


                ),
              ),
              ///login buton pini
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
                    child: Align(
                        alignment: const Alignment(0.005, 0.169),
                        child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                bool mCheckError = false;

                                if (nameController.value.text == ""){
                                  mCheckError = true;
                                }

                                if (passwordController.value.text == ""){
                                  mCheckError = true;
                                }
                                //devamı buraya
                                if(!mCheckError){
                                  postRequest (context,nameController.value.text,  passwordController.value.text);
                                }

                              }
                            },
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                fontFamily: 'Work Sans',
                                fontSize: 20,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            )
                        )
                    )
                ),
              ),



              ///Usermane Pin
              Pinned.fromPins(
                Pin(start: 57.0, end: 57.0),
                Pin(size: 52.0, middle: 0.5150),
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
                    child: Align(
                      alignment: const Alignment(-0.188, 0.478),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter user name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          icon: Padding(
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
              Pinned.fromPins(
                  Pin(size: 196.0, middle: 0.5025),
                  Pin(size: 14.0, end: 150.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SignInPage()));
                    },
                    child: const Text(
                      'Don\'t have an account? Sing Up!',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff000000),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
              ),


              /// Forgot
              Pinned.fromPins(
                  Pin(size: 196.0, end: 57.0),
                  Pin(size: 14.0, middle: 0.6500),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ForgotPassword()));
                    },
                    child: const Text(
                      'Forgot your password?',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 12,
                        color: Color(0xffc45d54),
                      ),
                      textAlign: TextAlign.right,
                    ),
                  )
              ),
             ], )));

    }
  }
  Future<http.Response> postRequest(BuildContext context, String username,
      String password) async {
    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/checkuser/';
    Uri urlU = Uri.parse(url);
    Map data = {
      'Username': username,
      'Password': password,
    };
    //encode Map to JSON
    var body = json.encode(data);

    final response = await http.post(urlU,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    final returnedData = jsonDecode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      String mUnicID = returnedData['UnicID'];
      print(mUnicID);
      if(mUnicID != "") {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool("girisyapildi", true);
        pref.setString("username", username);
        pref.setString("password", password);
        pref.setString("unicID", mUnicID);

        print(pref.getString("unicID") ?? "-");

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage()));
      }else{
        showAlertDialog(context, "Beklenmeyen hata oluştu!", false);
      }
      //burayı alma
      //devam et
    } else {
      showAlertDialog(context, returnedData['Message'], false);
    }
    return response;
  }
  showAlertDialog(BuildContext context, String message, bool status) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        if (status) {
          Navigator.of(context).pop();
        }
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

  Future<void> readySharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    girisyapildimi = prefs.getBool("girisyapildi") ?? false;
    setState(() {

    });
  }
}


const String _svg_xp7tu =
    '<svg viewBox="-243.2 -327.5 779.2 716.5" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 536.04, 219.47)" d="M 1.024306038743816e-05 184.1095581054688 C 7.517889116570586e-06 285.7896118164062 100.297233581543 368.2178955078125 224.0208892822266 368.2178955078125 C 274.1476745605469 368.2178649902344 320.4256591796875 354.6895446777344 357.7494201660156 331.8302612304688 C 352.7652893066406 349.4608764648438 350.0668640136719 368.312255859375 350.0668640136719 387.898193359375 C 350.0668640136719 486.4231567382812 418.3290100097656 566.2928466796875 502.5333862304688 566.2928466796875 C 586.7387084960938 566.2928466796875 654.9998779296875 486.4231262207031 654.9998779296875 387.898193359375 C 654.9998779296875 289.3731994628906 586.7387084960938 209.5035095214844 502.5333862304688 209.5035095214844 C 481.3537902832031 209.5035400390625 461.1823120117188 214.5567932128906 442.8525085449219 223.688720703125 C 446.2498474121094 210.9415893554688 448.0417785644531 197.694580078125 448.0417785644531 184.1095581054688 C 448.0417785644531 82.4283447265625 347.7445373535156 6.103515625e-05 224.0209045410156 6.103515625e-05 C 100.2972412109375 6.103515625e-05 1.296826212637825e-05 82.4283447265625 1.024306038743816e-05 184.1095581054688 Z" fill="#c45d54" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ws6n7 =
    '<svg viewBox="0.0 447.0 393.0 405.0" ><path transform="translate(0.0, 447.0)" d="M 36 0 L 357 0 C 376.8822631835938 0 393 16.11774826049805 393 36 L 393 405 L 0 405 L 0 36 C 0 16.11774826049805 16.11774826049805 0 36 0 Z" fill="#ffffff" stroke="#ffffff" stroke-width="1" stroke-opacity="0.31" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
