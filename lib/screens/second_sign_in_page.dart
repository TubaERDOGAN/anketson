import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:adobe_xd/pinned.dart';
import 'package:ankets/screens/login_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


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

  final List<String> genderItems = [
    'Kadın',
    'Erkek',
    'Diğer',
  ];

  final List<String> educationItems = [
    'İlkokul',
    'Ortakokul',
    'Lise',
    'Üniversite',
  ];
  String? selectedValueCity;
  String? selectedValueGender;
  String? selectedValueEducation;
  String? selectedValueYear;

  @override
  Widget build(BuildContext context) {
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
                    top: MediaQuery.of(context).size.height * 0.37,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.63,
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
                      top: MediaQuery.of(context).size.height * 0.40,
                      child:SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        child: const Text(
                          'Profili Tamamla',
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
                    top: MediaQuery.of(context).size.height * 0.45,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.1 ),
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
                          child: Row(children: const [
                             Padding(
                                padding:  EdgeInsets.only(left:5.0),
                               /* child: Icon(
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
                          )],)
                      ),),
                  ),
                  /// 2. sıra city
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.52,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.1 ),
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
                          child:DropdownButtonHideUnderline(
                            child:DropdownButtonFormField2<String>(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                               /* prefixIcon: Icon(
                                  Icons.school_sharp,
                                  //size: 30,
                                  color: Color(0xff919a94) ,
                                ),*/
                              ),
                              hint: const Text(
                                'Şehir',
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
                              dropdownSearchData: DropdownSearchData(
                                searchController: cityController,
                                searchInnerWidgetHeight: 50,
                                searchInnerWidget: Container(
                                  height: 50,
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 4,
                                    right: 8,
                                    left: 8,
                                  ),
                                  child: TextFormField(
                                    expands: true,
                                    maxLines: null,
                                    controller: cityController,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      hintText: 'Şehir yazınız...',
                                      hintStyle: const TextStyle(fontSize: 12),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                searchMatchFn: (item, searchValue) {
                                  return (item.value.toString().contains(searchValue));
                                },
                              ),
                              onMenuStateChange: (isOpen) {
                                if (!isOpen) {
                                  cityController.clear();
                                }
                              },
                            ),
                          ),
                      ),),
                  ),
                  /// 3. sıra birth
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.59,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.1 ),
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
                        child:Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0.0, 0.0, 0.0),
                          child:TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputAction: TextInputAction.done,
                          controller: yearController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'lütfen doğum yılınızı giriniz';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            /*icon: Padding(
                                padding:  EdgeInsets.fromLTRB(5.0,0.0,0.0,0.0),
                                child: Icon(
                                    Icons.calendar_month_sharp,
                                    color: Color(0xff919a94))
                            ),*/
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: InputBorder.none,
                           hintText: 'Doğum Yılı',
                            hintStyle: TextStyle(
                              fontFamily: 'Work Sans',
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                          ),
                            onChanged: (String? value) {
                              selectedValueYear = value;
                            },
                        ),)
                      ),),
                  ),

                  /// gender 4. sıra
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.66,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.1 ),
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
                        child:DropdownButtonHideUnderline(
                          child:
                          DropdownButtonFormField2(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              /*prefixIcon: Icon(
                                Icons.people_outline_rounded,
                                //size: 30,
                                color: Color(0xff919a94) ,
                              ),*/
                            ),
                            hint: const Text(
                              'Cinsiyet',
                              style: TextStyle(
                                fontFamily: 'Work Sans',
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'lütfen cinsiyetinizi giriniz';
                              }
                              return null;
                            },
                            value: selectedValueGender,
                            isExpanded: true,
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
                              selectedValueGender = value;
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.only(left: 0, right: 10),
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
                        child:  DropdownButtonHideUnderline(
                          child:
                          DropdownButtonFormField2(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              /*prefixIcon: Icon(
                                Icons.school_sharp,
                                //size: 30,
                                color: Color(0xff919a94) ,
                              ),*/
                            ),
                            hint: const Text(
                              'Eğitim durumu',
                              style: TextStyle(
                                fontFamily: 'Work Sans',
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'lütfen eğitim durumunuzu giriniz';
                              }
                              return null;
                            },
                            value: selectedValueEducation,
                            isExpanded: true,


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
                              selectedValueEducation = newValue!;
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
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation:0,
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
                          height: MediaQuery.of(context).size.height * 0.06,
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
                                    //if (_formKey.currentState!.validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    bool mCheckError = false;
                                    if (selectedValueCity.toString() == ""){
                                      mCheckError = true;
                                    }
                                    if (yearController.value.text.toString() == ""){
                                      mCheckError = true;
                                    }
                                    if (selectedValueGender.toString() == ""){
                                      mCheckError = true;
                                    }
                                    if (selectedValueEducation.toString() == ""){
                                      mCheckError = true;
                                    }
                                    if(!mCheckError){
                                      postRequest (context, selectedValueCity.toString(),yearController.value.text.toString(),selectedValueGender.toString(),selectedValueEducation.toString());
                                    }else{
                                      showAlertDialog2(context, "Tüm alanları doldurun!");
                                    }
                                    },
                                  child: const Text(
                                    'Devam',
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
                  ),],),)));
  }

  Future<http.Response> postRequest (BuildContext context, String city, String year,String gender,String education,) async {

    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/userinformationdata/';
    Uri urlU = Uri.parse(url);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String unicId = sharedPreferences.getString("unicID") ?? "";

    Map data = {
      'UnicID': unicId,
      'City': city,
      'BirthYear': year,
      'Gender': gender,
      'EducationLevel': education,
    };
    var body = json.encode(data);
    final response = await http.post(urlU,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    final returnedData = jsonDecode(response.body);
    if(response.statusCode == 200){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) => const LoginPage()), (Route route) => false);
    }else{
      showAlertDialog2(context, "Hata: " + response.body);
    }
    return response;
  }
  showAlertDialog2(BuildContext context, String message) {
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

const String _svg_ahsnb9 =
    '<svg viewBox="-243.2 -327.5 779.2 716.5" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 536.04, 219.47)" d="M 1.024306038743816e-05 184.1095581054688 C 7.517889116570586e-06 285.7896118164062 100.297233581543 368.2178955078125 224.0208892822266 368.2178955078125 C 274.1476745605469 368.2178649902344 320.4256591796875 354.6895446777344 357.7494201660156 331.8302612304688 C 352.7652893066406 349.4608764648438 350.0668640136719 368.312255859375 350.0668640136719 387.898193359375 C 350.0668640136719 486.4231567382812 418.3290100097656 566.2928466796875 502.5333862304688 566.2928466796875 C 586.7387084960938 566.2928466796875 654.9998779296875 486.4231262207031 654.9998779296875 387.898193359375 C 654.9998779296875 289.3731994628906 586.7387084960938 209.5035095214844 502.5333862304688 209.5035095214844 C 481.3537902832031 209.5035400390625 461.1823120117188 214.5567932128906 442.8525085449219 223.688720703125 C 446.2498474121094 210.9415893554688 448.0417785644531 197.694580078125 448.0417785644531 184.1095581054688 C 448.0417785644531 82.4283447265625 347.7445373535156 6.103515625e-05 224.0209045410156 6.103515625e-05 C 100.2972412109375 6.103515625e-05 1.296826212637825e-05 82.4283447265625 1.024306038743816e-05 184.1095581054688 Z" fill="#929a94" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
