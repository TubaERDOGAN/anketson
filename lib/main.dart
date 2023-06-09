import 'dart:async';
import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ankets/page/setting_profile_page.dart';
import 'package:ankets/screens/anket_sayfasi.dart';
import 'package:ankets/screens/anketler.dart';
import 'package:ankets/screens/cumhurSecimPage.dart';
import 'package:ankets/screens/genelSecimPage.dart';
import 'package:ankets/screens/home_page.dart';
import 'package:ankets/screens/login_page.dart';
import 'package:ankets/screens/profile_page.dart';
import 'package:ankets/screens/second_sign_in_page.dart';
import 'package:ankets/screens/sign_in_page.dart';
import 'package:ankets/screens/testler.dart';
import 'package:ankets/screens/secimMainPage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:ankets/constants.dart';
import 'package:ankets/screens/mvsecimsonuc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui';
import 'package:flutter/services.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      EasyLocalization(
        supportedLocales: AppConstant.SUPPORTED_LOCALE,
        path: AppConstant.LANG_PATH,
        fallbackLocale: Locale('tr', 'TR'),
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  StreamSubscription? connection;
  bool isoffline = false;
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;

  void CheckInternet() {
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
      _source = source;
      //print('source $_source');
      // 1.
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          isoffline = false;
          break;
        case ConnectivityResult.wifi:
          isoffline = false;
          break;
        case ConnectivityResult.none:
          isoffline = true;
          break;
        default:
          false;
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    CheckInternet();

    if(isoffline){
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child:
            Text("Check your internet connection!")
            ,)
          ,)
        ,);
    }else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (BuildContext context) => LoginPage(),
          '/signup': (BuildContext context) => SignInPage(),
          '/secondsignin': (BuildContext context) => SecondSignInPage(),
          '/home': (BuildContext context) => HomePage(),
          '/anketler': (BuildContext context) => Anketler(),
          '/testler': (BuildContext context) => Testler(),
          '/profile': (BuildContext context) => ProfilePage(),
          '/settingprofile': (BuildContext context) => SettingProfilePage(),
          '/secimAnket': (BuildContext context) => SecimMain(),
          '/cumhurSecimPage': (BuildContext context) => cumhurSecim(),
          '/genelSecimPage': (BuildContext context) => genelSecim(),
          '/mvsecimsonuc': (BuildContext context) => mvSonuc(),

        },
        theme: ThemeData(
          primaryColor: Color(0xffc45d54),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            // günlük anket yanındaki ikonun rengi değişti
            color: Color(0xffc45d54),
            // değişiklik yapınca pek farketmedi
            foregroundColor: Colors.black,
            // değişiklik yapınca farketmedi
            systemOverlayStyle: SystemUiOverlayStyle( //<-- SEE HERE
// Status bar color
              statusBarColor: Color(0xffc45d54),
              // değişiklik yapınca farkettemedi
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
          ),
        ),
        home: AnimatedSplashScreen(splash: Image.asset('assets/megasoft.png'),duration: 3000,
            splashTransition: SplashTransition.scaleTransition,
            backgroundColor: Color(0xffc45d54),
            nextScreen: LoginPage()),
      );
    }
  }
}

class NetworkConnectivity {
  NetworkConnectivity._();
  static final _instance = NetworkConnectivity._();
  static NetworkConnectivity get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;
  void initialise() async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();
    _checkStatus(result);
    _networkConnectivity.onConnectivityChanged.listen((result) {
      print(result);
      _checkStatus(result);
    });
  }
  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }
  void disposeStream() => _controller.close();
}

