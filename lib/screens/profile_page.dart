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
    return SafeArea(child:Scaffold(
      backgroundColor: const Color(0xff919b95),
      body: Stack(
        children: <Widget>[
          Transform.rotate(
            angle: 3.1416,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.0, -1.0),
                  end: Alignment(0.0, 1.0),
                  colors: [
                    const Color(0xff8f9d97),
                    const Color(0xff919a94),
                    const Color(0xffc45d54)
                  ],
                  stops: [0.0, 0.402, 1.0],
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(size: 450.0, end: 0.0),
            child: ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0x8affffff),
                    borderRadius: BorderRadius.only(
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
          Pinned.fromPins(
            Pin(size: 196.0, start: 22.0),
            Pin(size: 21.0, middle: 0.4717),
            child: Text(
              'Test score',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 18,
                color: const Color(0xff000000),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 196.0, end: 22.0),
            Pin(size: 21.0, middle: 0.4717),
            child: Text(
              'Survey score',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 18,
                color: const Color(0xff000000),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          /// text scorun boxı
          Align(
            alignment: Alignment(-0.521, 0.076),
            child: Container(
              width: 101.0,
              height: 62.0,
              decoration: BoxDecoration(
                color: const Color(0xffc45d54),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x14000000),
                    offset: Offset(3, 3),
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
          ),

          ///  Survey scorun Boxı
          Align(
            alignment: Alignment(0.527, 0.076),
            child: Container(
              width: 101.0,
              height: 62.0,
              decoration: BoxDecoration(
                color: const Color(0xff919b95),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x14000000),
                    offset: Offset(3, 3),
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
          ),
          /// test score burası veri tabanından gelecek
          Align(
            alignment: Alignment(-0.508, 0.069),
            child: SizedBox(
              width: 92.0,
              height: 42.0,
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
          ),

          /// survey score burası veri tabanından gelecek
          Align(
            alignment: Alignment(0.508, 0.069),
            child: SizedBox(
              width: 92.0,
              height: 42.0,
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
          ),
          /// buraya username gelecek
          Align(
            alignment: Alignment(0.005, -0.345),
              child: Text(
                _savedText,
                style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 20,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),

          ),
          /// fotograf eklenin boxı burası düzenlecek sanırım
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
            child: Text(
              'Fotoğraf Ekle',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 14,
                color: const Color(0xff000000),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          /// profil düzenleme kısmı
          Pinned.fromPins(
            Pin(size: 30.0, end: 16.0),
            Pin(size: 30.0, start: 17.0),
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
          ),

        ],
      ),
    ));
  }
}