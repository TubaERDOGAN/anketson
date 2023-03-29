import 'dart:convert';
import 'package:adobe_xd/pinned.dart';
import 'package:ankets/screens/login_page.dart';
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

  List<String> listKategoriler = [];

  void _Cikiss() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('girisyapildi',false);
    });
  }

  void getAnketKategorileri() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String unicId = sharedPreferences.getString("unicID") ?? "";
    String username = sharedPreferences.getString("username") ?? "";
    String password = sharedPreferences.getString("password") ?? "";

    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/kategoriler/';
    Uri urlU = Uri.parse(url);
    Map data = {
      'Username': username,
      'Password': password,
      'UnicID': unicId,
    };

    //encode Map to JSON
    var body = json.encode(data);

    final response = await http.post(urlU,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    final returnedData = jsonDecode(response.body);
    //print(returnedData);
    if (response.statusCode == 200) {

      for (var row in returnedData["Kategoriler"]) {
        if(!listKategoriler.contains(row["Tanim"])) {
          listKategoriler.add(row["Tanim"]);
        }
      }

    }else{
      print("hata");
    }

  }

  List<Widget> kategorilerList(){
    List<Widget> list = [];
    for(var tanim in listKategoriler){
      list.add(ListTile(
        title: Text(tanim),
        trailing: const Icon(Icons.arrow_right),
        onTap: () {
          //Navigator.pushNamed(context, "");
        },
      ),);
    }
    return list;
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

    getAnketKategorileri();

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
              ExpansionTile(
                  leading: IconButton(
                    onPressed: null,
                    icon: Image.asset(
                      'lib/assets/icons/menu_icons/test.png',
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                  title: const Text(
                    'Testler',
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 20,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  children: [ SingleChildScrollView( child: Column( children: [
                    ListTile(
                      title: const Text('İlişki Testleri'),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, "");
                      },
                    ),
                    ListTile(
                      title: const Text('Psikoloji Testleri'),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, "");
                      },
                    ),
                    ListTile(
                      title: const Text('Astroloji Testleri'),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, "");
                      },
                    ),
                    ListTile(
                      title: const Text('Yemek Testleri'),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, "");
                      },
                    ),
                    ListTile(
                      title: const Text('Kişilik Testleri'),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, "");
                      },
                    ),
                    ListTile(
                      title: const Text('Genel Kültür Testleri'),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, "");
                      },
                    ),
                  ],), ), ]),
              ExpansionTile(
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
                  trailing: const Icon(Icons.arrow_drop_down),
              children: kategorilerList()),
              ExpansionTile(
                  leading: IconButton(
                    onPressed: null,
                    icon: Image.asset(
                      'lib/assets/icons/menu_icons/yakinda.png',
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: const Text(
                    'Yakında',
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 20,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                  children: [
                    ListTile(
                      title: const Text('Seçim 2023'),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, "");
                      },
                    ),
                  ]),
              ListTile(
                title: const Text(style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 20,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w600,),'Bize Ulaşın'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Bize ulaşabilirsiniz'),
                        content: const Text(''),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Tamam'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Git'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
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
              ListTile(
                title: const Text(style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 20,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w600,),'Çıkış Yap'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text('Çıkış yapmak istediğinizden emin misiniz ?'),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Hayır'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Evet'),
                            onPressed: () {
                              _Cikiss();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoginPage()));
                            },
                          ),
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
            ],
          )),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: pages[selectedIndex],
      bottomNavigationBar: Pinned.fromPins(
        Pin(start: 0.0, end: 0.0),
        Pin(size: 73.0, end: 0.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xffc45d54),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(23.0),
              topRight: Radius.circular(23.0),
            ),
          ),
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home, color: Colors.white, size: 40),
                label: "",
              ),
              NavigationDestination(
                  icon: Icon(Icons.search, color: Colors.white, size: 40),
                  label: ""),
              NavigationDestination(
                icon: Icon(Icons.notifications, color: Colors.white, size: 40), label: '',
              ),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          ),),),
    ));

  }


  /// Web icin
  SafeArea WebPage (){
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
              ExpansionTile(
                  leading: IconButton(
                    onPressed: null,
                    icon: Image.asset(
                      'lib/assets/icons/menu_icons/test.png',
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                  title: const Text(
                    'Testler',
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 20,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  children: [ SingleChildScrollView( child: Column( children: [
                    ListTile(
                      title: const Text('İlişki Testleri'),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, "");
                      },
                    ),
                    ListTile(
                      title: const Text('Psikoloji Testleri'),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, "");
                      },
                    ),
                    ListTile(
                      title: const Text('Astroloji Testleri'),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, "");
                      },
                    ),
                    ListTile(
                      title: const Text('Yemek Testleri'),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, "");
                      },
                    ),
                    ListTile(
                      title: const Text('Kişilik Testleri'),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, "");
                      },
                    ),
                    ListTile(
                      title: const Text('Genel Kültür Testleri'),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, "");
                      },
                    ),
                  ],), ), ]),
              ExpansionTile(
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
                  trailing: const Icon(Icons.arrow_drop_down),
                  children: [
                    ListTile(
                      title: const Text('Seçim 2023'),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, "");
                      },
                    ),
                  ]),
              ExpansionTile(
                  leading: IconButton(
                    onPressed: null,
                    icon: Image.asset(
                      'lib/assets/icons/menu_icons/yakinda.png',
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: const Text(
                    'Yakında',
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 20,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                  children: [
                    ListTile(
                      title: const Text('Seçim 2023'),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, "");
                      },
                    ),
                  ]),
              ListTile(
                title: const Text(style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 20,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w600,),'Bize Ulaşın'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Bize ulaşabilirsiniz'),
                        content: const Text(''),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Tamam'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Git'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
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
              ListTile(
                title: const Text(style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 20,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w600,),'Çıkış Yap'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text('Çıkış yapmak istediğinizden emin misiniz ?'),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Hayır'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Evet'),
                            onPressed: () {
                              _Cikiss();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoginPage()));
                            },
                          ),
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
            ],
          )),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: pages[selectedIndex],
      bottomNavigationBar: Pinned.fromPins(
        Pin(start: 0.0, end: 0.0),
        Pin(size: 73.0, end: 0.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xffc45d54),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(23.0),
              topRight: Radius.circular(23.0),
            ),
          ),
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home, color: Colors.white, size: 40),
                label: "",
              ),
              NavigationDestination(
                  icon: Icon(Icons.search, color: Colors.white, size: 40),
                  label: ""),
              NavigationDestination(
                icon: Icon(Icons.notifications, color: Colors.white, size: 40), label: '',
              ),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          ),),),
    ));

  }
}
