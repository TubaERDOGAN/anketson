import 'package:adobe_xd/pinned.dart';
import 'package:ankets/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:ankets/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: AppConstant.SUPPORTED_LOCALE,
        path: AppConstant.LANG_PATH,
        fallbackLocale: Locale('tr', 'TR'),
        child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        /// burası anlaşılmadı
        theme: ThemeData(
          primaryColor:Color(0xffc45d54),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white), // günlük anket yanındaki ikonun rengi değişti
            color: Color(0xffc45d54), // değişiklik yapınca pek farketmedi
            foregroundColor: Colors.black, // değişiklik yapınca farketmedi
            systemOverlayStyle: SystemUiOverlayStyle( //<-- SEE HERE
// Status bar color
              statusBarColor: Color(0xffc45d54), // değişiklik yapınca farkettemedi
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
          ),
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body:
              LoginPage()));
  }

}

const String _svg_xp7tu =
    '<svg viewBox="-243.2 -327.5 779.2 716.5" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 536.04, 219.47)" d="M 1.024306038743816e-05 184.1095581054688 C 7.517889116570586e-06 285.7896118164062 100.297233581543 368.2178955078125 224.0208892822266 368.2178955078125 C 274.1476745605469 368.2178649902344 320.4256591796875 354.6895446777344 357.7494201660156 331.8302612304688 C 352.7652893066406 349.4608764648438 350.0668640136719 368.312255859375 350.0668640136719 387.898193359375 C 350.0668640136719 486.4231567382812 418.3290100097656 566.2928466796875 502.5333862304688 566.2928466796875 C 586.7387084960938 566.2928466796875 654.9998779296875 486.4231262207031 654.9998779296875 387.898193359375 C 654.9998779296875 289.3731994628906 586.7387084960938 209.5035095214844 502.5333862304688 209.5035095214844 C 481.3537902832031 209.5035400390625 461.1823120117188 214.5567932128906 442.8525085449219 223.688720703125 C 446.2498474121094 210.9415893554688 448.0417785644531 197.694580078125 448.0417785644531 184.1095581054688 C 448.0417785644531 82.4283447265625 347.7445373535156 6.103515625e-05 224.0209045410156 6.103515625e-05 C 100.2972412109375 6.103515625e-05 1.296826212637825e-05 82.4283447265625 1.024306038743816e-05 184.1095581054688 Z" fill="#c45d54" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ws6n7 =
    '<svg viewBox="0.0 447.0 393.0 405.0" ><path transform="translate(0.0, 447.0)" d="M 36 0 L 357 0 C 376.8822631835938 0 393 16.11774826049805 393 36 L 393 405 L 0 405 L 0 36 C 0 16.11774826049805 16.11774826049805 0 36 0 Z" fill="#ffffff" stroke="#ffffff" stroke-width="1" stroke-opacity="0.31" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';