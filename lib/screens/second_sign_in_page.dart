import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;
import 'package:dropdown_button2/dropdown_button2.dart';
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
  final List<String> genderItems = [
    'Male',
    'Female',
    'Others',
  ];

  final List<String> educationItems = [
    'Primary school',
    'High school',
    'University',
  ];

  final List<String> items1 = [];

  void getYears(int year) {
    int currentYear = DateTime.now().year;

    while (year < currentYear) {
      items1.add(year.toString());
      year++;
    }
  }

  String? selectedValue;
  String? selectedValue2;
  String? selectedValue3;

  @override
  void dispose() {
    yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getYears(1960);
    print(items1);
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
          } else
          if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
            return MobilePage();
          } else {
            return WebPage();
          }
        });
  }
  MaterialApp MobilePage (){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            body:Form(
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
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.15,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
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
                            Border.all(width: 1.0, color: const Color(0x4fffffff)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.2,
                      child:Padding(
                        padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.3 ),
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
                      )),
                  /// 1, sıra country
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.25,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.1 ),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
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
                                icon:  Padding(
                                    padding:  EdgeInsets.only(left:5.0),
                                    child: Icon(
                                        Icons.map,
                                        color: Color(0xff919a94))
                                ),
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
                      ),),
                  ),
                  /// 2. sıra city
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.37,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.1 ),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
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
                                icon:  Padding(
                                    padding:  EdgeInsets.only(left:5.0),
                                    child: Icon(
                                        Icons.location_city,
                                        color: Color(0xff919a94))
                                ),
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
                      ),),
                  ),
                  /// 3. sıra birth
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.49,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.1 ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
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
                        child:DropdownButtonHideUnderline(
                          child:
                          DropdownButtonFormField2(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter birth year';
                              }
                              return null;
                            },
                            value: selectedValue3,
                            isExpanded: true,
                            hint: const Text(
                              'Birth of Year',
                              style: TextStyle(
                                fontFamily: 'Work Sans',
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                            items: items1
                                .map((item) => DropdownMenuItem<String>(
                              value: item.toString(),
                              child: Text(
                                item.toString(),
                                style: const TextStyle(
                                  fontFamily: 'Work Sans',
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                              ),
                            )).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                if(newValue != null) {
                                  selectedValue3 = newValue.toString();
                                }
                              });
                            },

                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.only(left: 20, right: 10),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color:Color(0xff919a94),
                              ),
                              iconSize: 30,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),

                        ),
                      ),),
                  ),

                  /// gender 4. sıra
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.61,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.1 ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
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
                        child:DropdownButtonHideUnderline(
                          child:
                          DropdownButtonFormField2(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter gender';
                              }
                              return null;
                            },
                            value: selectedValue,
                            isExpanded: true,
                            hint: const Text(
                              'Gender',
                              style: TextStyle(
                                fontFamily: 'Work Sans',
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                            items: genderItems
                                .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontFamily: 'Work Sans',
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.only(left: 20, right: 10),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color:Color(0xff919a94),
                              ),
                              iconSize: 30,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),

                        ),),),
                  ),
                  /// en alt 5. sıra education
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.73,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.1 ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
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
                        child:  DropdownButtonHideUnderline(
                          child:
                          DropdownButtonFormField2(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter education';
                              }
                              return null;
                            },
                            value: selectedValue2,
                            isExpanded: true,
                            hint: const Text(
                              'Education',
                              style: TextStyle(
                                fontFamily: 'Work Sans',
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                            items: educationItems
                                .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontFamily: 'Work Sans',
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue2 = newValue!;
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.only(left: 20, right: 10),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color:Color(0xff919a94),
                              ),
                              iconSize: 30,
                            ),

                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),),
                  ),
                  /// Next butonu
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.85,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.1 ),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
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
                                       if (countryController.value.text == ""){
                                      mCheckError = true;
                                      }
                                       if (cityController.value.text == ""){
                                       mCheckError = true;
                                      }
                                       if (yearController.value.text == ""){
                                           mCheckError = true;
                                        }
                                      if (genderController.value.text == ""){
                                         mCheckError = true;
                                      }
                                      if (educationController.value.text == ""){
                                        mCheckError = true;
                                      }


                                      if(!mCheckError){
                                        //showAlertDialog(context, "1");
                                        postRequest (context,countryController.value.text, cityController.value.text, yearController.value.text,genderController.value.text,educationController.value.text);
                                      }
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
                    ),),
                ],
              ),

            )));
  }

  MaterialApp WebPage (){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            body:Form(
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
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.2,
                      child:Padding(
                        padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.3 ),
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
                      )),
                  /// 1, sıra country
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.25,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.1 ),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
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
                                icon:  Padding(
                                    padding:  EdgeInsets.only(left:5.0),
                                    child: Icon(
                                        Icons.map,
                                        color: Color(0xff919a94))
                                ),
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
                      ),),
                  ),
                  /// 2. sıra city
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.37,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.1 ),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
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
                                icon:  Padding(
                                    padding:  EdgeInsets.only(left:5.0),
                                    child: Icon(
                                        Icons.location_city,
                                        color: Color(0xff919a94))
                                ),
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
                      ),),
                  ),
                  /// 3. sıra birth
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.49,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.1 ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
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
                        child:DropdownButtonHideUnderline(
                          child:
                          DropdownButton2(
                            value: items1[0],
                            isExpanded: true,
                            hint: const Text(
                              'Birth of Year',
                              style: TextStyle(
                                fontFamily: 'Work Sans',
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                            items: items1
                                .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item.toString(),
                                style: const TextStyle(
                                  fontFamily: 'Work Sans',
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                              ),
                            )).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                if(newValue != null) {
                                  selectedValue3 = newValue!;
                                }
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              height: 60,
                              padding: EdgeInsets.only(left: 20, right: 10),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color:Color(0xff919a94),
                              ),
                              iconSize: 30,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),

                        ),
                      ),),
                  ),

                  /// gender 4. sıra
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.61,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.1 ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
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
                        child:DropdownButtonHideUnderline(
                          child:
                          DropdownButton2(
                            value: selectedValue,
                            isExpanded: true,
                            hint: const Text(
                              'Gender',
                              style: TextStyle(
                                fontFamily: 'Work Sans',
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                            items: genderItems
                                .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontFamily: 'Work Sans',
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              height: 60,
                              padding: EdgeInsets.only(left: 20, right: 10),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color:Color(0xff919a94),
                              ),
                              iconSize: 30,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),

                        ),),),
                  ),
                  /// en alt 5. sıra education
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.73,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.1 ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
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
                        child:  DropdownButtonHideUnderline(
                          child:
                          DropdownButton2(
                            value: selectedValue2,
                            isExpanded: true,
                            hint: const Text(
                              'Education',
                              style: TextStyle(
                                fontFamily: 'Work Sans',
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                            items: educationItems
                                .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontFamily: 'Work Sans',
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue2 = newValue!;
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              height: 60,
                              padding: EdgeInsets.only(left: 20, right: 10),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color:Color(0xff919a94),
                              ),
                              iconSize: 30,
                            ),

                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),),
                  ),
                  /// Next butonu
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.85,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.1 ),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
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
                    ),),
                ],
              ),

            )));
  }
  Future<http.Response> postRequest (BuildContext context, String country, String city, String year,String gender,String education,) async {
    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/userinformationdata/';
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





