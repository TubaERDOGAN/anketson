import 'dart:convert';
import 'package:ankets/screens/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:ankets/screens/home_page.dart';

class SettingProfilePage extends StatefulWidget {
  @override
  _SettingProfilePageState createState() => _SettingProfilePageState();
}

class _SettingProfilePageState extends State<SettingProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true; //boolean value to track password view enable disable.
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController oldpasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController cnewpasswordController = TextEditingController();

  String unicID = '';
  String Email = '';
  String Country = '';
  String City = '';
  String oldPassword = '';

  late ScrollController scrollController;
  FocusNode focusNode = FocusNode();
  double offset = 0.0;
  double gaydirmarakami = 0.0;

  _onLayoutDone(_){
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  void initState() {

    getUserData();

    scrollController = ScrollController();
    focusNode = FocusNode();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        scrollController.animateTo(gaydirmarakami,
            duration: Duration(milliseconds: 1000), curve: Curves.ease);
      }
    });

    emailController.addListener(() {
      offset = scrollController.offset;
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 1000), curve: Curves.ease);
    });

    oldpasswordController.addListener(() {
      offset = scrollController.offset;
      scrollController.animateTo(60.0,
              duration: Duration(milliseconds: 1000), curve: Curves.ease);
    });

    countryController.addListener(() {
      offset = scrollController.offset;
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 1000), curve: Curves.ease);
    });

    countryController.addListener(() {
      offset = scrollController.offset;
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 1000), curve: Curves.ease);
    });

    WidgetsBinding.instance.addPostFrameCallback(_onLayoutDone);
    super.initState();
  }

  Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    unicID = sharedPreferences.getString("unicID") ?? "";

    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/senduserdata/';
    Uri urlU = Uri.parse(url);

    Map data = {
      'UnicID': unicID,
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
      Email = returnedData['Email'];
      Country = returnedData['Country'];
      City = returnedData['City'];
      oldPassword = returnedData['Password'];

      emailController.value = TextEditingValue(text: Email);
      countryController.value = TextEditingValue(text: Country);
      cityController.value = TextEditingValue(text: City);
    }
  }

  Future<void> updateUserData(String email, String country, String city,
      String newpassword) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    unicID = sharedPreferences.getString("unicID") ?? "";

    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/updateuserdata/';
    Uri urlU = Uri.parse(url);

    Map data = {
      'UnicID': unicID,
      'Email': email,
      'Country': country,
      'City': city,
      'Password': newpassword,
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
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage()),(r) => false);
    }
  }

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
            return MobilePage();
          }
        });
  }

  Scaffold MobilePage() {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Profil Düzenleme',
          style: TextStyle(
            fontFamily: 'Work Sans',
            fontSize: 18,
            color: Color(0xff000000),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff919b95),
      body:
      Form(
        key: _formKey,
        child: Stack(
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
                    stops: [0.0, 0.268, 1.0],
                  ),
                ),
              ),
            ),

            /// ARKA PLANDAKI YEŞİL ŞEY
            Pinned.fromPins(
              Pin(start: -243.2, end: -143.0),
              Pin(size: 716.5, start: -327.5),
              child: SvgPicture.string(
                _svg_ahsnb9,
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.fill,
              ),
            ),

            SingleChildScrollView(
              controller: scrollController,
              primary: false,
              child: SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 1.3,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 1,
                child: Stack(
                  children: [

                    /// Email Box
                    Positioned(
                      top: MediaQuery
                          .of(context)
                          .size
                          .height * 0.01,
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
                            child: Align(
                              alignment: const Alignment(-0.494, -0.196),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.disabled,
                                controller: emailController,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior
                                      .never,
                                  border: InputBorder.none,
                                  icon: const Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: Icon(
                                          Icons.email,
                                          color: Color(0xff919a94))
                                  ),

                                  /// email
                                  labelText: Email,
                                  labelStyle: TextStyle(
                                    fontFamily: 'Work Sans',
                                    fontSize: 14,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            )
                        ),
                      ),),

                    /// Country Box
                    Positioned(
                      top: MediaQuery
                          .of(context)
                          .size
                          .height * 0.13,
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
                                controller: countryController,
                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior
                                      .never,
                                  border: InputBorder.none,
                                  icon: const Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: Icon(
                                          Icons.map,
                                          color: Color(0xff919a94))
                                  ),
                                  label: Text(Country),
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

                    /// City Box
                    Positioned(
                      top: MediaQuery
                          .of(context)
                          .size
                          .height * 0.25,
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
                                controller: cityController,
                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior
                                      .never,
                                  border: InputBorder.none,
                                  icon: const Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: Icon(
                                          Icons.location_city,
                                          color: Color(0xff919a94))
                                  ),
                                  label: Text("City"),
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

                    /// Old Password
                    Positioned(
                      top: MediaQuery
                          .of(context)
                          .size
                          .height * 0.37,
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
                            child: Align(
                              alignment: Alignment(-0.39, 0.289),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction,
                                controller: oldpasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.none,
                                obscureText: _isObscure,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior
                                      .never,
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                          color: Color(0xff919a94),
                                          _isObscure ? Icons.visibility : Icons
                                              .visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      }),
                                  icon: const Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: Icon(
                                          Icons.lock,
                                          color: Color(0xff919a94))
                                  ),
                                  labelText: 'Old Password',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Work Sans',
                                    fontSize: 14,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ),
                            )
                        ),
                      ),),

                    /// New Password
                    Positioned(
                      top: MediaQuery
                          .of(context)
                          .size
                          .height * 0.49,
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
                            child: Align(
                              alignment: Alignment(-0.198, 0.45),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction,
                                controller: newpasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                obscureText: _isObscure,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior
                                      .never,
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                          color: Color(0xff919a94),
                                          _isObscure ? Icons.visibility : Icons
                                              .visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      }),
                                  icon: const Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: Icon(
                                          Icons.lock,
                                          color: Color(0xff919a94))
                                  ),
                                  labelText: 'New Password',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Work Sans',
                                    fontSize: 14,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ),
                            )
                        ),
                      ),),

                    /// Confirm Next Password
                    Positioned(
                      top: MediaQuery
                          .of(context)
                          .size
                          .height * 0.61,
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
                            child: Align(
                              alignment: Alignment(-0.198, 0.61),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction,
                                controller: cnewpasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                obscureText: _isObscure,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior
                                      .never,
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                          color: Color(0xff919a94),
                                          _isObscure ? Icons.visibility : Icons
                                              .visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      }),
                                  icon: const Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: Icon(
                                          Icons.lock,
                                          color: Color(0xff919a94))
                                  ),
                                  labelText: 'Confirm New Password',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Work Sans',
                                    fontSize: 14,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ),
                            )
                        ),
                      ),),

                    /// Save Button
                    Positioned(
                      top: MediaQuery
                          .of(context)
                          .size
                          .height * 0.75,
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
                                      //if (_formKey.currentState!.validate()) {
                                        // If the form is valid, display a snackbar. In the real world,
                                        // you'd often call a server or save the information in a database.
                                        bool mCheckError = false;

                                        if (newpasswordController.value.text !=
                                            "") {
                                          if (cnewpasswordController.value
                                              .text == "") {
                                            mCheckError = true;
                                            print("a");
                                            SnackBar snack = SnackBar(
                                              content: Text(
                                                  "Lütfen iki şifre alanını da doldurun!"),);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snack);
                                          } else {
                                            if (newpasswordController.value
                                                .text !=
                                                cnewpasswordController.value
                                                    .text) {
                                              mCheckError = true;
                                              SnackBar snack = SnackBar(
                                                content: Text(
                                                    "Girilen şifreler uyuşmamaktadır!"),);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snack);
                                            }else{
                                              if (oldpasswordController.value.text == "") {
                                                mCheckError = true;
                                                SnackBar snack = SnackBar(
                                                  content: Text(
                                                      "Şifre değiştirmek için lütfen eski şifrenizi girin!"),);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snack);
                                              }else{
                                                if (oldpasswordController.value.text != oldPassword) {
                                                  mCheckError = true;
                                                  SnackBar snack = SnackBar(
                                                    content: Text(
                                                        "Girilen eski şifre yanlıştır!"),);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snack);
                                                }
                                              }
                                            }
                                          }
                                        }

                                        if (!mCheckError) {
                                          //showAlertDialog(context, "1");
                                          updateUserData(emailController.value.text,countryController.value.text,cityController.value.text,cnewpasswordController.value.text);
                                        }

                                    },
                                    child: const Text(
                                      'Save',
                                      style: TextStyle(
                                        fontFamily: 'Work Sans',
                                        fontSize: 16,
                                        color: Color(0xffffffff),
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                )
                            )
                        ),
                      ),),
                  ],),),),
          ],
        ),
      ),
    );
  }


}

const String _svg_ahsnb9 =
    '<svg viewBox="-243.2 -327.5 779.2 716.5" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 536.04, 219.47)" d="M 1.024306038743816e-05 184.1095581054688 C 7.517889116570586e-06 285.7896118164062 100.297233581543 368.2178955078125 224.0208892822266 368.2178955078125 C 274.1476745605469 368.2178649902344 320.4256591796875 354.6895446777344 357.7494201660156 331.8302612304688 C 352.7652893066406 349.4608764648438 350.0668640136719 368.312255859375 350.0668640136719 387.898193359375 C 350.0668640136719 486.4231567382812 418.3290100097656 566.2928466796875 502.5333862304688 566.2928466796875 C 586.7387084960938 566.2928466796875 654.9998779296875 486.4231262207031 654.9998779296875 387.898193359375 C 654.9998779296875 289.3731994628906 586.7387084960938 209.5035095214844 502.5333862304688 209.5035095214844 C 481.3537902832031 209.5035400390625 461.1823120117188 214.5567932128906 442.8525085449219 223.688720703125 C 446.2498474121094 210.9415893554688 448.0417785644531 197.694580078125 448.0417785644531 184.1095581054688 C 448.0417785644531 82.4283447265625 347.7445373535156 6.103515625e-05 224.0209045410156 6.103515625e-05 C 100.2972412109375 6.103515625e-05 1.296826212637825e-05 82.4283447265625 1.024306038743816e-05 184.1095581054688 Z" fill="#929a94" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
