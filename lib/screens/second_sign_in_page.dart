import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

import 'home_page.dart';
import 'login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class SecondSignInPage extends StatefulWidget {

  const SecondSignInPage({Key? key}) : super(key: key);

  _SecondSignInPage createState() => _SecondSignInPage();
}

class _SecondSignInPage extends State<SecondSignInPage> {
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController educationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff919b95),
     body: Form(
     key: _formKey,
      child:Stack(
          children: <Widget>[
            Transform.rotate(
              angle: 3.1416,
              child: Container(
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
            ),
            Pinned.fromPins(
              Pin(start: 0.0, end: 0.0),
              Pin(size: 563.0, end: 0.0),
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
            /// 2. sıra city
            Pinned.fromPins(
              Pin(start: 56.0, end: 58.0),
              Pin(size: 52.0, middle: 0.5688),
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
                    alignment: const Alignment(-0.198, 0.132),
                    child: TextFormField(
                      controller: cityController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter city';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: InputBorder.none,
                        labelText: 'City',
                        labelStyle: TextStyle(
                          fontFamily: 'Work Sans',
                          fontSize: 14,
                          color:  Color(0xff000000),
                        ),
                      ),
                    ),
                  )
              ),
            ),
            /// en alt 5. sıra education
            Pinned.fromPins(
              Pin(start: 57.0, end: 57.0),
              Pin(size: 52.0, middle: 0.8238),
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
                    alignment: const Alignment(-0.198, 0.615),
                    child: TextFormField(
                      controller: educationController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter education level';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: InputBorder.none,
                        labelText: 'Education',
                        labelStyle: TextStyle(
                          fontFamily: 'Work Sans',
                          fontSize: 14,
                          color:  Color(0xff000000),
                        ),
                      ),
                    ),
                  )
              ),
            ),
            /// Next butonu
            Pinned.fromPins(
              Pin(start: 58.0, end: 56.0),
              Pin(size: 52.0, end: 50.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff919b95),
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
                                postRequest (context,countryController.value.text, cityController.value.text, yearController.value.text,genderController.value.text,educationController.value.text);
                              }
                            }else{
                              showAlertDialog2(context, "2");
                            }
                          },
                          child: const Text(
                            'Next',
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
            /// 1, sıra country
            Pinned.fromPins(
              Pin(start: 56.0, end: 57.0),
              Pin(size: 52.0, middle: 0.4838),
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
                    alignment: const Alignment(-0.494, -0.031),
                    child: TextFormField(
                      controller: countryController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter country';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: InputBorder.none,
                        labelText: 'Country',
                        labelStyle: TextStyle(
                          fontFamily: 'Work Sans',
                          fontSize: 14,
                          color:  Color(0xff000000),
                        ),
                      ),
                    ),
                  )
              ),
            ),
            /// 3. sıra birth
            Pinned.fromPins(
              Pin(start: 56.0, end: 58.0),
              Pin(size: 52.0, middle: 0.6538),
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
                    alignment: const Alignment(-0.482, 0.292),
                    child: TextFormField(
                      controller: yearController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter birth of year';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: InputBorder.none,
                        labelText: 'Birth of Year',
                        labelStyle: TextStyle(
                          fontFamily: 'Work Sans',
                          fontSize: 14,
                          color:  Color(0xff000000),
                        ),
                      ),
                    ),
                  )
              ),
            ),
            /// gender 4. sıra
            Pinned.fromPins(
              Pin(start: 56.0, end: 58.0),
              Pin(size: 52.0, middle: 0.7388),
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
                    alignment: const Alignment(-0.494, 0.455),
                    child: TextFormField(
                      controller: genderController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter gender';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: InputBorder.none,
                        labelText: 'Gender',
                        labelStyle: TextStyle(
                          fontFamily: 'Work Sans',
                          fontSize: 14,
                          color:  Color(0xff000000),
                        ),
                      ),
                    ),
                  )
              ),
            ),
            Pinned.fromPins(
              Pin(start: 98.0, end: 99.0),
              Pin(size: 24.0, middle: 0.4000),
              child: const Text(
                'Complete Profile',
                style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 20,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],

     ),
     )
    );
  }

  Future<http.Response> postRequest (BuildContext context, String country, String city, String year,String gender,String education,) async {
    String url = 'http://172.16.64.200/ANKET/hs/getdata/userinformationdata/';
    Uri urlU = Uri.parse(url);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String unicId = sharedPreferences.getString("UnicID") ?? "";
    sharedPreferences.setString("country", country);
    sharedPreferences.setString("city", city);


    Map data = {
      'UnicID': unicId,
      'Country': country,
      'City': city,
      'BirthYear': year,
      'Gender': gender,
      'EducationLevel': education,
    };

    //encode Map to JSON
    var body = json.encode(data);

    final response = await http.post(urlU,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    final returnedData = jsonDecode(response.body);

    if(response.statusCode == 200){
      Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => HomePage()));
    }else{
      //hata kontrolü ve uyarısı
      showAlertDialog2(context, response.body);
    }

    return response;
  }


  showAlertDialog2(BuildContext context, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage())
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





