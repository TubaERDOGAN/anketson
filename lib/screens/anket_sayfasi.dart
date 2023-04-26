import 'dart:convert';
import 'dart:io';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey_kit/survey_kit.dart';
import 'home_page.dart';


class AnketSayfasi extends StatelessWidget {
  final String anketID;
  String unicID = "";

  AnketSayfasi({Key? key, required this.anketID}) : super(key: key);
  Future<void> sendData(BuildContext context, List<Map> answers) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    unicID = sharedPreferences.getString("unicID") ?? "";

    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/getanketanswers/';
    Uri urlU = Uri.parse(url);

    Map data = {
      'UserUnicID': unicID,
      'AnketUnicID': anketID,
      'Answers': answers,
    };
    //encode Map to JSON
    var body = json.encode(data);

    //print(body);

    final response = await http.post(urlU,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    final returnedData = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage()),(r) => false);
    }else{
      SnackBar snack = SnackBar(
        content: Text(
            "Hata Oluştu! Cevaplar kaydedilmedi!"),);
      ScaffoldMessenger.of(context)
          .showSnackBar(snack);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => AnketSayfasi(anketID: anketID)),(r) => false);
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea( child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body:Stack(
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
                //Alttaki gri şekil
                Pin(start: -82.6, end: -50.2),
                Pin(size: 496.2, end: -200.6),
                child: SvgPicture.string(
                  _svg_xyusrl,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
              Center(
                child:Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0 ),
                  child:Align(
                    alignment: Alignment.center,
                    child: FutureBuilder<Task>(
                      future: getJsonTask(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData &&
                            snapshot.data != null) {
                          final task = snapshot.data!;
                          return SurveyKit(
                            onResult: (SurveyResult result) {

                              if(result.finishReason == FinishReason.COMPLETED){
                                if(result.results.length > 0) {
                                  List<Map> answersData = [];
                                  for (var row in result.results) {
                                    Map cevap = Map();
                                    cevap["SoruID"] =
                                        row.results[0].id!.id.toString();
                                    cevap["CevapID"] =
                                        row.results[0].valueIdentifier.toString();
                                    answersData.add(cevap);
                                  }
                                  sendData(context, answersData);
                                  Navigator.of(context, rootNavigator: true).pop(context);
                                }
                              }else{
                                Navigator.of(context, rootNavigator: true).pop(context);
                              }
                            },
                            task: task,
                            showProgress: true,
                            localizations: {
                              'cancel': 'Vazgeç',
                              'next': 'Sonraki',
                            },
                            themeData: ThemeData.dark().copyWith(
                              primaryColor:Colors.white,
                              backgroundColor:Colors.transparent,
                              scaffoldBackgroundColor: Colors.transparent,
                              appBarTheme: const AppBarTheme(
                                backgroundColor:Color(0xffc45d54),
                              ),
                              textSelectionTheme: const TextSelectionThemeData(
                                cursorColor: Color(0xffc45d54),
                                selectionColor: Color(0xffc45d54),
                                selectionHandleColor:Color(0xffc45d54),
                              ),
                              textTheme: const TextTheme(
                                displayMedium: TextStyle(
                                  fontSize: 50.0,/// soru kategorisi
                                  color: Colors.black,
                                ),
                                headlineSmall: TextStyle(
                                  fontFamily: 'Work Sans',
                                  fontSize: 18, /// scevap
                                  color: Colors.black,
                                ),
                                bodyMedium: TextStyle(
                                  fontFamily: 'Work Sans',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,/// soru kısmı
                                  color: Colors.black,
                                ),
                              ),
                              outlinedButtonTheme: OutlinedButtonThemeData(
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                    Size(150.0, 60.0),
                                  ),
                                  side: MaterialStateProperty.resolveWith(
                                        (Set<MaterialState> state) {
                                      if (state.contains(MaterialState.disabled)) {
                                        return BorderSide(
                                          color: Colors.grey,
                                        );
                                      }
                                      return BorderSide(
                                        color: Colors.white,
                                      );
                                    },
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  textStyle: MaterialStateProperty.resolveWith(
                                        (Set<MaterialState> state) {
                                      if (state.contains(MaterialState.disabled)) {
                                        return Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                          color: Colors.grey,
                                        );
                                      }
                                      return Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                        color: Colors.cyan,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                             /// appbar progress ayarları
                            surveyProgressbarConfiguration: SurveyProgressConfiguration(
                              valueProgressbarColor: Colors.white,
                              progressbarColor: Colors.transparent,
                            ),
                          );
                        }
                        return CircularProgressIndicator.adaptive();
                      },
                    ),
                  ),
                ),
              ),],),),));
  }

  Future<Task> getJsonTask() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String unicId = sharedPreferences.getString("unicID") ?? "";
    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/anketsorularisk/';
    Uri urlU = Uri.parse(url);
    Map data = {
      'UserUnicID': unicId,
      'UnicID': anketID,
    };
    //encode Map to JSON
    var body = json.encode(data);
    /*final response = await http.post(urlU,
        headers: {"Content-Type": "application/json"},
        body: body
    );*/
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(data)));
    HttpClientResponse response = await request.close();
    String responsebody = await response.transform(utf8.decoder).join();
    httpClient.close();

    final returnedData = jsonDecode(responsebody);

    return Task.fromJson(returnedData["Anket"]);
  }

}
const String _svg_ahsnb9 =
    '<svg viewBox="-243.2 -327.5 779.2 716.5" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 536.04, 219.47)" d="M 1.024306038743816e-05 184.1095581054688 C 7.517889116570586e-06 285.7896118164062 100.297233581543 368.2178955078125 224.0208892822266 368.2178955078125 C 274.1476745605469 368.2178649902344 320.4256591796875 354.6895446777344 357.7494201660156 331.8302612304688 C 352.7652893066406 349.4608764648438 350.0668640136719 368.312255859375 350.0668640136719 387.898193359375 C 350.0668640136719 486.4231567382812 418.3290100097656 566.2928466796875 502.5333862304688 566.2928466796875 C 586.7387084960938 566.2928466796875 654.9998779296875 486.4231262207031 654.9998779296875 387.898193359375 C 654.9998779296875 289.3731994628906 586.7387084960938 209.5035095214844 502.5333862304688 209.5035095214844 C 481.3537902832031 209.5035400390625 461.1823120117188 214.5567932128906 442.8525085449219 223.688720703125 C 446.2498474121094 210.9415893554688 448.0417785644531 197.694580078125 448.0417785644531 184.1095581054688 C 448.0417785644531 82.4283447265625 347.7445373535156 6.103515625e-05 224.0209045410156 6.103515625e-05 C 100.2972412109375 6.103515625e-05 1.296826212637825e-05 82.4283447265625 1.024306038743816e-05 184.1095581054688 Z" fill="#929a94" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';

const String _svg_xyusrl =
    '<svg viewBox="-82.6 556.3 525.7 496.2" ><path transform="matrix(0.920505, -0.390731, 0.390731, 0.920505, -82.55, 719.49)" d="M 1.024306038743816e-05 117.6346893310547 C 8.505850928486325e-06 182.6019897460938 63.93630218505859 235.2685852050781 142.8061981201172 235.2685852050781 C 174.7604217529297 235.2685699462891 204.2611694335938 226.6248016357422 228.0538940429688 212.0191192626953 C 224.8766632080078 223.2840118408203 223.156494140625 235.3288726806641 223.156494140625 247.8430786132812 C 223.156494140625 310.7944641113281 266.6714477539062 361.8262634277344 320.3490600585938 361.8262634277344 C 374.0272827148438 361.8262634277344 417.5415954589844 310.79443359375 417.5415954589844 247.8430786132812 C 417.5415954589844 184.8916778564453 374.0272827148438 133.85986328125 320.3490600585938 133.85986328125 C 306.8477478027344 133.8598785400391 293.9890747070312 137.0885925292969 282.3043823242188 142.9233551025391 C 284.4700927734375 134.7787017822266 285.6123962402344 126.3146743774414 285.6123962402344 117.6346893310547 C 285.6123962402344 52.66665649414062 221.6760864257812 6.103515261202119e-05 142.8061981201172 6.103515261202119e-05 C 63.93630599975586 6.103515261202119e-05 1.198028985527344e-05 52.66665649414062 1.024306038743816e-05 117.6346893310547 Z" fill="#919b95" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
