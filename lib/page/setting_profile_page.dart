
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/profile_widget.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';



class SettingProfilePage extends StatefulWidget {
  @override
  _SettingProfilePageState createState() => _SettingProfilePageState();
}

class _SettingProfilePageState extends State<SettingProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = false;//boolean value to track password view enable disable.
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController odlpasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController cnewpasswordController = TextEditingController();

  String _savedText = '';
  String _savedText2 = '';
  String _savedText3 = '';
  String _savedText4 = '';
  String _savedText5 = '';
  @override
  void initState() {
    super.initState();
    _loadSavedText();
  }

  Future<void> _loadSavedText() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _savedText = sharedPreferences.getString("username") ?? "";
      _savedText2 = sharedPreferences.getString("email") ?? "";
      _savedText3 = sharedPreferences.getString("password") ?? "";
      _savedText4 = sharedPreferences.getString("country") ?? "";
      _savedText5 = sharedPreferences.getString("city") ?? "";
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff919b95),
      body:Form(
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
          /// BİLİNMİYOR
          Pinned.fromPins(
            Pin(size: 32.0, start: 16.0),
            Pin(size: 32.0, start: 11.0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(''),
                  fit: BoxFit.cover,
                ),
                border: Border.all(width: 1.0, color: const Color(0x00000000)),
              ),
            ),
          ),
          /// BİLİNMİYOR
          Align(
            alignment: Alignment(0.36, -0.541),
            child: Container(
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(''),
                  fit: BoxFit.cover,
                ),
                border: Border.all(width: 1.0, color: const Color(0x00000000)),
              ),
            ),
          ),
          /// profil fotografı
          Pinned.fromPins(
            Pin(size: 157.0, middle: 0.5),
            Pin(size: 157.0, start: 57.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffcbcac6),
                borderRadius:
                BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                border: Border.all(width: 1.0, color: const Color(0x33ffffff)),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 81.0, middle: 0.5),
            Pin(size: 33.0, start: 119.0),
            child: const Text(
              'Fotoğraf Ekle',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 14,
                color: Color(0xff000000),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment(0.36, -0.541),
            child: GestureDetector(
              onTap: () {
                /// buraya tıklayınca galeriye gidecek :)
                //Navigator.push(
                //context,
                //MaterialPageRoute(
                //builder: (context) =>
                //??()));
              },
              child: Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: const Color(0x00000000)),
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),),
          ),
          /// Email Box
          Pinned.fromPins(
            Pin(start: 56.0, end: 57.0),
            Pin(size: 52.0, middle: 0.3975),
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
                  alignment: const Alignment(-0.494, -0.196),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.disabled,
                    controller: emailController,
                    decoration:  InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      icon: const Padding(
                          padding:  EdgeInsets.only(left:5.0),
                          child: Icon(
                              Icons.email,
                              color: Color(0xff919a94))
                      ),
                      /// email
                      labelText: _savedText2,
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
          /// Country Box
          Pinned.fromPins(
            Pin(start: 56.0, end: 58.0),
            Pin(size: 52.0, middle: 0.4825),
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
                  alignment: Alignment(-0.198, -0.033),
                  child: TextFormField(
                    controller: countryController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter country';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      icon: const Padding(
                          padding:  EdgeInsets.only(left:5.0),
                          child: Icon(
                              Icons.map,
                              color: Color(0xff919a94))
                      ),
                      labelText: _savedText4.toString(),
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
          /// City Box
          Pinned.fromPins(
            Pin(start: 56.0, end: 58.0),
            Pin(size: 52.0, middle: 0.5675),
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
                  alignment: Alignment(-0.482, 0.127),
                  child: TextFormField(
                    controller: cityController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter city';
                      }
                      return null;
                    },
                    decoration:  InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      icon: const Padding(
                          padding:  EdgeInsets.only(left:5.0),
                          child: Icon(
                              Icons.location_city,
                              color: Color(0xff919a94))
                      ),
                      labelText: _savedText5.toString(),
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
          /// Old Password
          Pinned.fromPins(
            Pin(start: 56.0, end: 58.0),
            Pin(size: 52.0, middle: 0.6525),
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
                  alignment: Alignment(-0.39, 0.289),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: odlpasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: _isObscure,
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
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                          icon: Icon(
                              color: Color(0xff919a94),
                              _isObscure ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      icon: const Padding(
                          padding:  EdgeInsets.only(left:5.0),
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
          ),
          /// New Password
          Pinned.fromPins(
            Pin(start: 57.0, end: 57.0),
            Pin(size: 52.0, middle: 0.7375),
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
                  alignment: Alignment(-0.198, 0.45),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: newpasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: _isObscure,
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
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                          icon: Icon(
                              color: Color(0xff919a94),
                              _isObscure ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      icon: const Padding(
                          padding:  EdgeInsets.only(left:5.0),
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
          ),
          /// Confirm Next Password
          Pinned.fromPins(
            Pin(start: 57.0, end: 57.0),
            Pin(size: 52.0, middle: 0.8225),
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
                  alignment: Alignment(-0.198, 0.61),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: cnewpasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: _isObscure,
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
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                          icon: Icon(
                              color: Color(0xff919a94),
                              _isObscure ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      icon: const Padding(
                          padding:  EdgeInsets.only(left:5.0),
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
          ),
          /// Save Button
          Pinned.fromPins(
            Pin(start: 58.0, end: 56.0),
            Pin(size: 52.0, end: 55.0),
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
                              //postRequest (context,usernameController.value.text, emailController.value.text, passwordController.value.text);
                            }
                          }else{
                            //showAlertDialog1(context, "2");
                          }
                        },
                        child: const Text(
                          'Save',
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
        ],
      ),
    ),
    ));
  }
}

const String _svg_ahsnb9 =
    '<svg viewBox="-243.2 -327.5 779.2 716.5" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 536.04, 219.47)" d="M 1.024306038743816e-05 184.1095581054688 C 7.517889116570586e-06 285.7896118164062 100.297233581543 368.2178955078125 224.0208892822266 368.2178955078125 C 274.1476745605469 368.2178649902344 320.4256591796875 354.6895446777344 357.7494201660156 331.8302612304688 C 352.7652893066406 349.4608764648438 350.0668640136719 368.312255859375 350.0668640136719 387.898193359375 C 350.0668640136719 486.4231567382812 418.3290100097656 566.2928466796875 502.5333862304688 566.2928466796875 C 586.7387084960938 566.2928466796875 654.9998779296875 486.4231262207031 654.9998779296875 387.898193359375 C 654.9998779296875 289.3731994628906 586.7387084960938 209.5035095214844 502.5333862304688 209.5035095214844 C 481.3537902832031 209.5035400390625 461.1823120117188 214.5567932128906 442.8525085449219 223.688720703125 C 446.2498474121094 210.9415893554688 448.0417785644531 197.694580078125 448.0417785644531 184.1095581054688 C 448.0417785644531 82.4283447265625 347.7445373535156 6.103515625e-05 224.0209045410156 6.103515625e-05 C 100.2972412109375 6.103515625e-05 1.296826212637825e-05 82.4283447265625 1.024306038743816e-05 184.1095581054688 Z" fill="#929a94" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
