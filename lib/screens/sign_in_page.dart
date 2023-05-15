import 'package:ankets/screens/login_page.dart';
import 'package:ankets/screens/second_sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  bool _isObscure = true; //boolean value to track password view enable disable.
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  Pattern pattern =  r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
  RegExp regex = new RegExp('pattern');
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final size = MediaQuery.of(context).size; //getting the size property
    final orientation = MediaQuery.of(context).orientation; //getting the orientation

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
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.21,
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(
                                sigmaX: 4.0, sigmaY: 4.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.9,
                              width:MediaQuery.of(context).size.width * 1,
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
                      Positioned(
                          top: MediaQuery.of(context).size.height * 0.24,
                          child:SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
                            child: const Text(
                              'Kayıt Ol',
                              style: TextStyle(
                                fontFamily: 'Work Sans',
                                fontSize: 20,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )),
                      ///Usermane Pin
                      Positioned(
                          top: MediaQuery.of(context).size.height * 0.29,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width * 0.1),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: MediaQuery.of(context).size.height * 0.06,
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
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  controller: usernameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'lütfen kullanıcı adını giriniz';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    icon: Padding(
                                        padding:  EdgeInsets.fromLTRB(5.0,0.0,0.0,0.0),
                                        child: Icon(
                                            Icons.people,
                                            color: Color(0xffc45d54))
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    border: InputBorder.none,
                                    hintText: 'Kullanıcı adı',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Work Sans',
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ))),

                      ///Email
                      Positioned(
                          top: MediaQuery.of(context).size.height * 0.36,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width * 0.1),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: MediaQuery.of(context).size.height * 0.06,
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
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  controller: emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'lütfen email giriniz';
                                    }
                                    if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                      //regex içinde olan değerler olmadığında içeri girip ifadeyi return olarak döndürür.
                                      return "Geçersiz e-mail";
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    icon: Padding(
                                        padding:  EdgeInsets.fromLTRB(5.0,0.0,0.0,0.0),
                                        child: Icon(
                                            Icons.email,
                                            color: Color(0xffc45d54))
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior
                                        .never,
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Work Sans',
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ))),

                      ///Password
                      Positioned(
                          top: MediaQuery.of(context).size.height * 0.43,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width * 0.1),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: MediaQuery.of(context).size.height * 0.06,
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
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  controller: passwordController,
                                  obscureText: _isObscure,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Lütfen şifreyi giriniz';
                                    }
                                    if (value.length < 8) {
                                      return 'Must be more than 8 character';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    icon: const Padding(
                                        padding:  EdgeInsets.fromLTRB(5.0,0.0,0.0,0.0),
                                        child: Icon(
                                            Icons.lock,
                                            color: Color(0xffc45d54))
                                    ),
                                    suffixIcon: IconButton(padding:EdgeInsets.fromLTRB(0.0,10.0,0.0,0.0) ,
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
                                    labelText: 'Şifre',
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
                          top: MediaQuery.of(context).size.height * 0.5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width * 0.1),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.06,
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
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                controller: cpasswordController,
                                obscureText: _isObscure,
                                //if passenable == true, show **, else show password character
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'lütfen şifrenizi onaylayınz';
                                  }
                                  if (value.length < 8) {
                                    return 'şifre 8 karakteden fazla olmalı';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  icon: const Padding(
                                      padding:  EdgeInsets.fromLTRB(5.0,0.0,0.0,0.0),
                                      child: Icon(
                                          Icons.lock,
                                          color: Color(0xffc45d54))
                                  ),
                                  suffixIcon: IconButton(padding:EdgeInsets.fromLTRB(0.0,10.0,0.0,0.0) ,
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
                                  labelText: 'Şifre Tekrarı',
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
                          top: MediaQuery.of(context).size.height * 0.63,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width * 0.1),
                              child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: MediaQuery.of(context).size.height * 0.06,
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

                                          if (passwordController.value.text != cpasswordController.value.text) {
                                            mCheckError = true;
                                            showAlertDialog1(context, "Şifreler aynı değildir!");
                                          }

                                          if (!mCheckError) {
                                            //showAlertDialog(context, "1");
                                            SharedPreferences sharedPreferences = await SharedPreferences
                                                .getInstance();
                                            if(sharedPreferences.getString("username") != "" ||sharedPreferences.getString("email") != ""){
                                              postRequest(context,
                                                  usernameController.value.text,
                                                  emailController.value.text,
                                                  passwordController.value.text);

                                                  Navigator.of(context).pushNamed('/secondsignin');
                                            }else{
                                              //Navigator.of(context).pushNamed('/secondsignin');
                                            }
                                          }
                                        } else {
                                          showAlertDialog1(context, "Lütfen tüm alanları doldurunuz");
                                        }
                                      },
                                      child: const Text(
                                        'Kayıt Ol',
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
                          top: MediaQuery.of(context).size.height * 0.71,
                          child:SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              height:MediaQuery.of(context).size.height * 0.06,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),(r) => false);
                                },
                                child: const Text(
                                  'Zaten bir hesabın var mı? Giriş Yap!',
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
                      ),]))));}



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
    print('*************************************************');
    print('*************************************************');
    print('*************************************************');
    print('*************************************************');
    print('*************************************************');
    print(response.statusCode);



    if (response.statusCode == 200) {
      print('*************************************************');
      print('GELEN UNIQUE ID ==> ');
      print(returnedData["UnicID"]);
      print('*************************************************');
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      sharedPreferences.setString("email", email);
      sharedPreferences.setString("username", username);
      sharedPreferences.setString("unicID", returnedData["UnicID"]);
      print(email);
      print(username);
      Navigator.of(context).pushNamed('/secondsignin');

      //bu kadar;)

    } else {
      //hata kontrolü ve uyarısı

      if(returnedData["ErrorCode"] == 1){
        showAlertDialog1(context, "Kullanıcı adı daha önce alınmış!");
      }else if(returnedData["ErrorCode"] == 4){
        showAlertDialog1(context, "Mail adresi ile daha önce kayıt olunmuş!");
      }else{
        print('*************************************************');
        print('*************************************************');
        print('*************************************************');
        print('BUYUK IHTIMALLE BURAYA GIRIYOR');
        print('*************************************************');
        print('*************************************************');
        print('*************************************************');
      }

    }

    return response;
  }

  showAlertDialog1(BuildContext context, String message) {
    // set up the button
    Widget okButton = Container(
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
          child:  const Text("Tamam",
            style: TextStyle(
              fontFamily: 'Work Sans',
              color: Color(0xffffffff),
              fontWeight: FontWeight.w600,
            ),

          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text("Uyarı!",
        style: TextStyle(
        fontFamily: 'Work Sans',
        fontSize: 16,
        color: Color(0xff000000),
        fontWeight: FontWeight.w600,
      ),
      ),
      content: Text(message,
        style: const TextStyle(
          fontFamily: 'Work Sans',
          fontSize: 16,
          color: Color(0xff000000),
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
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

String _svg_xp7tu =
    '<svg viewBox="-243.2 -327.5 779.2 716.5" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 536.04, 219.47)" d="M 1.024306038743816e-05 184.1095581054688 C 7.517889116570586e-06 285.7896118164062 100.297233581543 368.2178955078125 224.0208892822266 368.2178955078125 C 274.1476745605469 368.2178649902344 320.4256591796875 354.6895446777344 357.7494201660156 331.8302612304688 C 352.7652893066406 349.4608764648438 350.0668640136719 368.312255859375 350.0668640136719 387.898193359375 C 350.0668640136719 486.4231567382812 418.3290100097656 566.2928466796875 502.5333862304688 566.2928466796875 C 586.7387084960938 566.2928466796875 654.9998779296875 486.4231262207031 654.9998779296875 387.898193359375 C 654.9998779296875 289.3731994628906 586.7387084960938 209.5035095214844 502.5333862304688 209.5035095214844 C 481.3537902832031 209.5035400390625 461.1823120117188 214.5567932128906 442.8525085449219 223.688720703125 C 446.2498474121094 210.9415893554688 448.0417785644531 197.694580078125 448.0417785644531 184.1095581054688 C 448.0417785644531 82.4283447265625 347.7445373535156 6.103515625e-05 224.0209045410156 6.103515625e-05 C 100.2972412109375 6.103515625e-05 1.296826212637825e-05 82.4283447265625 1.024306038743816e-05 184.1095581054688 Z" fill="#c45d54" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';