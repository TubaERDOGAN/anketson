import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class SettingProfilePage extends StatefulWidget {
  @override
  _SettingProfilePageState createState() => _SettingProfilePageState();
}

class _SettingProfilePageState extends State<SettingProfilePage> {
  final List<String> cityItems = [
    'Adana',
    'Adıyaman',
    'Afyonkarahisar',
    'Ağrı',
    'Amasya',
    'Ankara',
    'Antalya',
    'Artvin',
    'Aydın',
    'Balıkesir',
    'Bilecik',
    'Bingöl',
    'Bitlis',
    'Bolu',
    'Burdur',
    'Bursa',
    'Çanakkale',
    'Çankırı',
    'Çorum',
    'Denizli',
    'Diyarbakır',
    'Edirne',
    'Elazığ',
    'Erzincan',
    'Erzurum',
    'Eskişehir',
    'Gaziantep',
    'Giresun',
    'Gümüşhane',
    'Hakkari',
    'Hatay',
    'Isparta',
    'Mersin',
    'İstanbul',
    'İzmir',
    'Kars',
    'Kastamonu',
    'Kayseri',
    'Kırklareli',
    'Kırşehir',
    'Kocaeli',
    'Konya',
    'Kütahya',
    ' Malatya',
    'Manisa',
    'Kahramanmaraş',
    'Mardin',
    'Muğla',
    'Muş',
    'Nevşehir',
    'Niğde',
    'Ordu',
    'Rize',
    'Sakarya',
    'Samsun',
    'Siirt',
    'Sinop',
    'Sivas',
    'Tekirdağ',
    'Tokat',
    'Trabzon',
    'Tunceli',
    'Şanlıurfa',
    'Uşak',
    'Van',
    'Yozgat',
    'Zonguldak',
    'Aksaray',
    'Bayburt',
    'Karaman',
    'Kırıkkale',
    'Batman',
    'Şırnak',
    'Bartın',
    'Ardahan',
    'Iğdır',
    'Yalova',
    'Karabük',
    'Kilis',
    'Osmaniye',
    'Düzce',
  ];

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
  String? selectedValueCity;
  Image imageFile = new Image.network("");

  @override
  void initState() {
    getUserData();
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

    final returnedData = jsonDecode(utf8.decode(response.bodyBytes));

    print(response.body);

    if (response.statusCode == 200) {
      Email = returnedData['Email'];
      Country = returnedData['Country'];
      City = returnedData['City'];
      oldPassword = returnedData['Password'];
      imageFile = Image.network(returnedData['PicURL']);
      print(returnedData['PicURL']);

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

    final returnedData = jsonDecode(utf8.decode(response.bodyBytes));

    print(response.body);

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
    }
  }

  Future<void> updateUserPic(String photostr) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    unicID = sharedPreferences.getString("unicID") ?? "";
    String username = sharedPreferences.getString("username") ?? "";

    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/getuserpic/';
    Uri urlU = Uri.parse(url);

    Map data = {
      'UnicID': unicID,
      'Username': username,
      'PhotoStr': photostr
    };
    //encode Map to JSON
    var body = json.encode(data);

    print(body);

    final response = await http.post(urlU,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    final returnedData = jsonDecode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      sharedPreferences.setString("photourl", returnedData["picUrl"]);
      imageFile = Image.network(returnedData["picURL"]);
    }


    print(response.body);

  }

  String selectedImagePath ='';


  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final size = MediaQuery.of(context).size; //getting the size property
    final orientation = MediaQuery.of(context).orientation; //getting the orientation

    getUserData();

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
    final double coverH=MediaQuery.of(context).size.height * 0.110;
    final double profileH=MediaQuery.of(context).size.height * 0.070;
    final top=coverH-profileH;
    final double fleft=MediaQuery.of(context).size.width * 0.5;
    final left=fleft-profileH;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Profil Düzenleme',
          style: TextStyle(
            fontFamily: 'Work Sans',
            fontSize: 18,
            color: Color(0xffffffff),
            fontWeight: FontWeight.w600,
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
            Positioned(
              top: top,
              left: left,
              child: GestureDetector(
                  onTap:() {
                    _show(context);
                  },
                  child: CircleAvatar(
                    radius:profileH,
                    backgroundColor:Colors.black,
                    child: imageFile == null
                        ? Center(child:Icon(
                      Icons.camera_alt_outlined,
                      size: 50,
                      color: Color(0xffc45d54) ,

                    ) ) : Container(
                      child: imageFile,
                    ),
                  )),
            ),
                    /// Country Box
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.23,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.0985),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                          height:MediaQuery.of(context).size.height * 0.05,
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
                            child:Row(children: const [
                              Padding(
                                  padding:  EdgeInsets.only(left:5.0),
                                  /*child: Icon(
                                      Icons.map,
                                      color: Color(0xff919a94))*/
                              ),
                              SizedBox(width: 10),
                              Align(
                                alignment: Alignment(-0.650, -0.031),
                                child: Text(
                                  //controller: countryController,
                                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                  /*validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter country';
                                }
                                return null;
                              },*/
                                  'Türkiye',
                                  style: TextStyle(
                                    fontFamily: 'Work Sans',
                                    fontSize: 14,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              )],),
                            )
                        ),
                      ),

                    /// City Box
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.29,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                          height:MediaQuery.of(context).size.height * 0.05,
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
                            child:DropdownButtonFormField2<String>(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                /*prefixIcon: Icon(
                                  Icons.school_sharp,
                                  //size: 30,
                                  color: Color(0xff919a94) ,
                                ),*/
                              ),
                              hint:  const Text(
                                'City',
                                style: TextStyle(
                                  fontFamily: 'Work Sans',
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter city';
                                }
                                return null;
                              },
                              value: selectedValueCity,
                              isExpanded: false,
                              items: cityItems
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
                                selectedValueCity = newValue!;
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.only(left: 0, right: 10),
                                elevation: 0,
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation:0,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),

                            ),
                          ),
                            )
                        ),
                      ),

                    /// Old Password
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.35,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height:MediaQuery.of(context).size.height * 0.05,
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
                                  hintText: 'Old Password',
                                  hintStyle: TextStyle(
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
                      top: MediaQuery.of(context).size.height * 0.41,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height:MediaQuery.of(context).size.height * 0.05,
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
                                  hintText: 'New Password',
                                  hintStyle: TextStyle(
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
                      top: MediaQuery.of(context).size.height * 0.47,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height:MediaQuery.of(context).size.height * 0.05,
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
                                  hintText: 'Confirm New Password',
                                  hintStyle: TextStyle(
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
                      top: MediaQuery.of(context).size.height * 0.75,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height:MediaQuery.of(context).size.height * 0.05,
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
                  ],),),);

  }
  void _show(BuildContext ctx) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Color(0x66ffffff),
        context: ctx,
        builder: (ctx) => Container(
          width: 300,
          height: 250,
          decoration: const BoxDecoration(
            color: Color(0x66ffffff),
          ),

          child:Padding(

              padding: EdgeInsets.fromLTRB(50, 50, 50, 50),
              child:Column(children: [
                 TextButton(
                     style: ButtonStyle(
                       shape: MaterialStateProperty.all(
                         RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10.0),
                         ),
                       ),
                       backgroundColor: MaterialStateProperty.all(const Color(0xffc45d54)),
                       fixedSize: MaterialStateProperty.all(
                         Size(200.0, 60.0),
                       ),
                     ),
                     onPressed: null,
                   child:Row(children:const[
                         Icon(
                         Icons.camera_alt_rounded,
                         size: 25,
                        color: Color(0xff000000) ,
                           ),
                          SizedBox(width: 10),
                          Text('Fotoğraf Çek',
                          style: TextStyle(
                          fontFamily: 'Work Sans',
                           fontSize: 18,
                           color: Color(0xff000000),
                   ),),
                 ],),),
                 SizedBox(height: 20,),
              TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(const Color(0xff929a94)),
                  fixedSize: MaterialStateProperty.all(
                    Size(200.0, 60.0),
                  ),
                ),
                  onPressed: (){
                    _getFromGallery();
                  }, child:Row(children: const [
                        Icon(
                        Icons.photo,
                         size: 25,
                          color: Color(0xff000000) ,
                           ),
                       SizedBox(width: 10),
                    Text('Galeriden Seç',
                    style: TextStyle(
                     fontFamily: 'Work Sans',
                     fontSize: 18,
                     color: Color(0xff000000),
                ),
              )]),

              ),
          ])),
        ));
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File SelectedImageFile = File(pickedFile.path);
      Uint8List imagebytes = SelectedImageFile.readAsBytesSync();
      String img64 = base64.encode(imagebytes);
      imageFile = Image.file(SelectedImageFile);
      setState(() {});

      updateUserPic(img64);

      /*imageFile = (await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        maxWidth: 400,
        maxHeight: 400,
      ))!;
      setState(() {});*/
    }
  }

}



const String _svg_ahsnb9 =
    '<svg viewBox="-243.2 -327.5 779.2 716.5" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 536.04, 219.47)" d="M 1.024306038743816e-05 184.1095581054688 C 7.517889116570586e-06 285.7896118164062 100.297233581543 368.2178955078125 224.0208892822266 368.2178955078125 C 274.1476745605469 368.2178649902344 320.4256591796875 354.6895446777344 357.7494201660156 331.8302612304688 C 352.7652893066406 349.4608764648438 350.0668640136719 368.312255859375 350.0668640136719 387.898193359375 C 350.0668640136719 486.4231567382812 418.3290100097656 566.2928466796875 502.5333862304688 566.2928466796875 C 586.7387084960938 566.2928466796875 654.9998779296875 486.4231262207031 654.9998779296875 387.898193359375 C 654.9998779296875 289.3731994628906 586.7387084960938 209.5035095214844 502.5333862304688 209.5035095214844 C 481.3537902832031 209.5035400390625 461.1823120117188 214.5567932128906 442.8525085449219 223.688720703125 C 446.2498474121094 210.9415893554688 448.0417785644531 197.694580078125 448.0417785644531 184.1095581054688 C 448.0417785644531 82.4283447265625 347.7445373535156 6.103515625e-05 224.0209045410156 6.103515625e-05 C 100.2972412109375 6.103515625e-05 1.296826212637825e-05 82.4283447265625 1.024306038743816e-05 184.1095581054688 Z" fill="#929a94" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
