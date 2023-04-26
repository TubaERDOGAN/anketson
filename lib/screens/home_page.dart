import 'dart:convert';
import 'dart:io';
import 'package:ankets/screens/anketler.dart';
import 'package:ankets/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page_screen.dart';
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
    Anketler(),
  ];
  String unicID = '';
  String username = "";
  String email = "";
  String result = "";
  String AnketAdedi = '0';
  String TestAdedi = '0';
  File? imageFile = null;

  Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    unicID = sharedPreferences.getString("unicID") ?? "";
    username = sharedPreferences.getString("username") ?? "";

    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/senduserscores/';
    Uri urlU = Uri.parse(url);

    Map data = {
      'UnicID': unicID,
    };
    //encode Map to JSON
    var body = json.encode(data);

    //print(body);

    final response = await http.post(urlU,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    final returnedData = jsonDecode(utf8.decode(response.bodyBytes));

    //print(response.body);

    if (response.statusCode == 200) {
      AnketAdedi = returnedData['AnketAdedi'].toString();
      TestAdedi = returnedData['TestAdedi'].toString();
    }
  }

  void _GetInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("username")  ?? "";
    email = prefs.getString("email")  ?? "";
    String   user = (username);
    result = user[0];
  }

  void _Cikiss() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('girisyapildi',false);
    prefs.setString('username',"");
    prefs.setString('unicID',"");
    prefs.setString('email',"");
  }

  @override
  Widget build(BuildContext context) {
    _GetInfo();
    getUserData();
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
    return SafeArea( child:Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        drawer: Drawer(
            backgroundColor: const Color(0xff929a94),
            child: Column(
              children: [
                Container(
                  height:MediaQuery.of(context).size.height * 0.27,///responsive yapılacak
                  decoration: const BoxDecoration(
                    color: Color(0x66ffffff),
                    borderRadius: BorderRadius.only(bottomRight:  Radius.circular(21),bottomLeft:Radius.circular(21) ),
                  ),
                  child: Column( children: [
                    UserAccountsDrawerHeader(
                      margin: const EdgeInsets.fromLTRB(20.0,0.0,0.0,0.0),
                      arrowColor: Colors.transparent,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      currentAccountPicture:  GestureDetector(
                        onTap: () {
                          //Navigator.pop(context);
                          //Navigator.of(context).pushNamed('/settingprofile');
                        },
                        child:CircleAvatar(
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                              backgroundColor:const Color(0xff929a94),
                              radius:33,
                              child: Center(child: Text(result,
                                style: const TextStyle(
                                  fontFamily: 'Work Sans',
                                  fontSize: 16,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w600,
                                ),))
                            /*backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80"
                        ),*/
                          ),
                        ),),
                      currentAccountPictureSize: const Size.fromRadius(35),
                      accountName: Text(
                        username,
                        style: const TextStyle(
                          fontFamily: 'Work Sans',
                          fontSize: 16,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      accountEmail: Text(email,
                        style: const TextStyle(
                          fontFamily: 'Work Sans',
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),

                    Padding(padding:const EdgeInsets.fromLTRB(40.0,0.0,0.0,0.0),
                      child : Row(
                        children: [
                          const Text(
                            'Test score',
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                          const Text(
                            'Anket score',
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),),
                    const SizedBox(height: 5),
                    Padding(padding:const EdgeInsets.fromLTRB(40.0,0.0,0.0,0.0),
                      child :Row(children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.18,
                          height: MediaQuery.of(context).size.height * 0.040,
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

                          child:  Text(
                            TestAdedi,
                            style: const TextStyle(
                              fontFamily: 'Work Sans',
                              fontSize: 24,
                              color: Color(0xff000000),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.18,
                          height: MediaQuery.of(context).size.height * 0.040,
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
                          child:  Text(
                            AnketAdedi,
                            style: const TextStyle(
                              fontFamily: 'Work Sans',
                              fontSize: 24,
                              color: Color(0xff000000),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                      ),),
                  ],),),
                SizedBox(height:MediaQuery.of(context).size.height * 0.01,),
                /// Anketler
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
                  title:  const Text(
                    'Anketler',
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 20,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/anketler');
                  },
                ),

                /// testler
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
                  title: const Text('Testler',
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 20,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/testler');
                  },
                ),
                SizedBox(height:MediaQuery.of(context).size.height * 0.32),/// responsive
                const Divider(thickness: 1,),
                ListTile(
                  title: const Text(style: TextStyle(
                    fontFamily: 'Work Sans',
                    fontSize: 18,
                    color: Color(0xff000000),
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
                              color:Color(0xff000000),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: const Alignment(-0.549, 0.238),
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
                                  alignment: const Alignment(0.549, 0.238),
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
                                          color: Color(0xffffffff),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      onPressed: () {
                                        _Cikiss();
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => LoginPage()),(r) => false);
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
                      'lib/assets/icons/menu_icons/test.png',
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height:MediaQuery.of(context).size.height * 0.005),
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
        body:NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 0,
              floating: true,
              snap:true,
              forceElevated: innerBoxIsScrolled,
              elevation: 0,
              //backgroundColor: Colors.transparent,
              centerTitle: true,
              title: const Text(
                'Günlük Anketler',
                style:  TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 18,
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: Builder(
                builder: (BuildContext context) {
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(4.0,0.0,0.0,0.0),
                      child:IconButton(
                        icon: CircleAvatar(
                          radius:25,
                          backgroundColor:Colors.black,
                          child: CircleAvatar(
                            backgroundColor: const Color(0xffffffff),
                            radius:15,
                            child: Center(child: Text(result,
                            )),
                          ),),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                      ));
                },
              ),
            ),
          ],
          body: pages[selectedIndex],
        ) ));

  }

/// Web icin
}