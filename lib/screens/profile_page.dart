import 'package:ankets/page/setting_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adobe_xd/pinned.dart';
import 'dart:ui' as ui;
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _savedText = '';

  @override
  void initState() {
    super.initState();
    _loadSavedText();
  }

  Future<void> _loadSavedText() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _savedText = sharedPreferences.getString("username") ?? "";

    });
  }

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
          } else
          if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
            return MobilePage();
          } else {
            return WebPage();
          }
        });

  }

  SafeArea MobilePage (){
    return SafeArea(child:Scaffold(
      backgroundColor: const Color(0xff919b95),
      body: Stack(
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
            top: MediaQuery.of(context).size.height * 0.4,
            child: ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
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
            top: MediaQuery.of(context).size.height * 0.44,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.2 ),
              child: const Text(
                'Test score',
                style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 18,
                  color: Color(0xff000000),
                ),
                textAlign: TextAlign.center,
              ),
            ),),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.44,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.58 ),
              child: const Text(
                'Survey score',
                style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 18,
                  color: Color(0xff000000),
                ),
                textAlign: TextAlign.center,
              ),
            ),),

          /// text scorun boxı
          Positioned(
            top: MediaQuery.of(context).size.height * 0.48,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.2 ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.24,
                height:MediaQuery.of(context).size.width * 0.16,
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
              ),
            ),),

          ///  Survey scorun Boxı
          Positioned(
            top: MediaQuery.of(context).size.height * 0.48,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.58 ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.24,
                height:MediaQuery.of(context).size.width * 0.16,
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
              ),
            ),),
          /// test score burası veri tabanından gelecek
          Positioned(
            top: MediaQuery.of(context).size.height * 0.49,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.21 ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                height:MediaQuery.of(context).size.width * 0.14,
                child: Text(
                  '99',
                  style: TextStyle(
                    fontFamily: 'Work Sans',
                    fontSize: 36,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),),

          /// survey score burası veri tabanından gelecek
          Positioned(
            top: MediaQuery.of(context).size.height * 0.49,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.59 ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                height:MediaQuery.of(context).size.width * 0.14,
                child: Text(
                  '99',
                  style: TextStyle(
                    fontFamily: 'Work Sans',
                    fontSize: 36,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),),
          /// buraya username gelecek
          Positioned(
            top: MediaQuery.of(context).size.height * 0.33,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.45 ),
              child: Text(
                _savedText,
                style: const TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 20,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),),
          /// fotograf eklenin boxı burası düzenlecek sanırım
          Positioned(
            top: MediaQuery.of(context).size.height * 0.09,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.3 ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.39,
                height:MediaQuery.of(context).size.width * 0.39,
                decoration: BoxDecoration(
                  color: const Color(0xffcbcac6),
                  borderRadius:
                  BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  border: Border.all(width: 1.0, color: const Color(0x33ffffff)),
                ),
              ),
            ),),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.4 ),
              child: const Text(
                'Fotoğraf Ekle',
                style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
                textAlign: TextAlign.center,
              ),
            ),),

          /// profil düzenleme kısmı
          Positioned(
              top: MediaQuery.of(context).size.height * 0.04,
              child: Padding(
                padding:EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.85),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SettingProfilePage()));
                  },
                  child: Container(
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              )),

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

        ],
      ),
    ));
  }


  /// Web kısmı

  SafeArea WebPage (){
    return SafeArea(child:Scaffold(
      backgroundColor: const Color(0xff919b95),
      body: Stack(
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
            top: MediaQuery.of(context).size.height * 0.4,
            child: ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
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
            top: MediaQuery.of(context).size.height * 0.44,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.2 ),
              child: const Text(
                'Test score',
                style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 18,
                  color: Color(0xff000000),
                ),
                textAlign: TextAlign.center,
              ),
            ),),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.44,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.58 ),
              child: const Text(
                'Survey score',
                style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 18,
                  color: Color(0xff000000),
                ),
                textAlign: TextAlign.center,
              ),
            ),),

          /// text scorun boxı
          Positioned(
            top: MediaQuery.of(context).size.height * 0.48,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.2 ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.16,
                height:MediaQuery.of(context).size.width * 0.08,
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
              ),
            ),),

          ///  Survey scorun Boxı
          Positioned(
            top: MediaQuery.of(context).size.height * 0.48,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.58 ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.16,
                height:MediaQuery.of(context).size.width * 0.08,
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
              ),
            ),),
          /// test score burası veri tabanından gelecek
          Positioned(
            top: MediaQuery.of(context).size.height * 0.49,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.21 ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                height:MediaQuery.of(context).size.width * 0.14,
                child: Text(
                  '99',
                  style: TextStyle(
                    fontFamily: 'Work Sans',
                    fontSize: 36,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),),

          /// survey score burası veri tabanından gelecek
          Positioned(
            top: MediaQuery.of(context).size.height * 0.49,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.59 ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                height:MediaQuery.of(context).size.width * 0.14,
                child: Text(
                  '99',
                  style: TextStyle(
                    fontFamily: 'Work Sans',
                    fontSize: 36,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),),
          /// buraya username gelecek
          Positioned(
            top: MediaQuery.of(context).size.height * 0.33,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.45 ),
              child: Text(
                _savedText,
                style: const TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 20,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),),
          /// fotograf eklenin boxı burası düzenlecek sanırım
          Positioned(
            top: MediaQuery.of(context).size.height * 0.09,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.43 ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.1,
                height:MediaQuery.of(context).size.width * 0.1,
                decoration: BoxDecoration(
                  color: const Color(0xffcbcac6),
                  borderRadius:
                  BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  border: Border.all(width: 1.0, color: const Color(0x33ffffff)),
                ),
              ),
            ),),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.45 ),
              child: const Text(
                'Fotoğraf Ekle',
                style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
                textAlign: TextAlign.center,
              ),
            ),),

          /// profil düzenleme kısmı
          Positioned(
              top: MediaQuery.of(context).size.height * 0.04,
              child: Padding(
                padding:EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.85),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SettingProfilePage()));
                  },
                  child: Container(
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              )),

      Positioned(
        top: MediaQuery.of(context).size.height * 0.28,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.60 ),
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

      ),],
      ),
    ));
  }

}