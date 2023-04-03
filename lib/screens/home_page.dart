import 'package:adobe_xd/pinned.dart';
import 'package:ankets/screens/anketler.dart';
import 'package:ankets/screens/login_page.dart';
import 'package:ankets/screens/testler.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'search_screen.dart';
import 'notification_screen.dart';
import 'settings_screen.dart';
import 'home_page_screen.dart';
import 'package:ankets/screens/profile_screen.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List pages = [
    HomePageScreen(),
    const SearchScreen(),
    const Notifications(),
    const SettingsScreen(),
    const ProfileScreen(),
  ];

  void _Cikiss() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('girisyapildi',false);
    });
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
          } else
          if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
            return MobilePage();
          } else {
            return MobilePage();
          }
        });
  }

  SafeArea MobilePage (){
    return SafeArea(child:Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      drawer: Drawer(
          backgroundColor: const Color(0xff929a94),
          child: Column(
            children: [
              const SizedBox(height: 30),
              ListTile(
                leading: IconButton(
                  onPressed: null,
                  icon: Image.asset(
                    'lib/assets/icons/menu_icons/profil.png',
                    width: 24.0,
                    height: 24.0,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  'Profil',
                  style: TextStyle(
                    fontFamily: 'Work Sans',
                    fontSize: 20,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                },
              ),
              ListTile(
                leading: IconButton(
                  onPressed: null,
                  icon: Image.asset(
                    'lib/assets/icons/menu_icons/anket.png',
                    width: 24.0,
                    height: 24.0,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  'Anketler',
                  style: TextStyle(
                    fontFamily: 'Work Sans',
                    fontSize: 20,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Anketler()));
                },
              ),
              ListTile(
                leading: IconButton(
                  onPressed: null,
                  icon: Image.asset(
                    'lib/assets/icons/menu_icons/test.png',
                    width: 24.0,
                    height: 24.0,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  'Testler',
                  style: TextStyle(
                    fontFamily: 'Work Sans',
                    fontSize: 20,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Testler()));
                },
              ),
               SizedBox(height: MediaQuery.of(context).size.height * 0.55),
              const Divider(
                thickness: 1,
              ),
              ListTile(
                title: const Text(style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 18,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w600,),'Çıkış Yap'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        content: const Text(
                          'Çıkış yapmak istediğinizden emin misiniz ?',
                          style: TextStyle(
                            fontFamily: 'Work Sans',
                            fontSize: 16,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment(-0.549, 0.238),
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
                                  child:
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle:const TextStyle (
                                        fontFamily: 'Work Sans',
                                        fontSize: 16,
                                        color: Color(0xffffffff),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    child: const Text('Hayır',
                                      style: TextStyle(
                                        fontFamily: 'Work Sans',
                                        color: Color(0xffffffff),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),),),
                              SizedBox(width: 15,),
                              Align(
                                alignment: Alignment(0.549, 0.238),
                                child:Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xff929a94),
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x14000000),
                                        offset: Offset(3, 3),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child:
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle:const TextStyle (
                                        fontFamily: 'Work Sans',
                                        fontSize: 16,
                                        color: Color(0xffffffff),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    child: const Text('Evet',
                                      style: TextStyle(
                                        fontFamily: 'Work Sans',
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {
                                      _Cikiss();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
                                    },
                                  ),),),],),
                        ],
                      );
                    },
                  );
                },
                leading: IconButton(
                  onPressed: null,
                  icon: Image.asset(
                    'lib/assets/icons/menu_icons/yakinda.png',
                    width: 24.0,
                    height: 24.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'info@megasoft.com.tr',
                style:TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 15,
                  color: Colors.black26,
                  fontWeight: FontWeight.w600,),
              ),
            ],
          )),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.06),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            'Günlük Anketler',
            style:  TextStyle(
              fontFamily: 'Work Sans',
              fontSize: 18,
              color: const Color(0xffffffff),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),),
      body: pages[selectedIndex],
    ));

  }

/// Web icin
}