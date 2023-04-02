import 'dart:convert';
import 'dart:io';
import 'package:adobe_xd/pinned.dart';
import 'package:ankets/screens/home_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/anket_sorulari.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';

class AnketSayfasi extends StatelessWidget {

  final String anketID;
  String unicID = "";

  AnketSayfasi({Key? key, required this.anketID}) : super(key: key);

  Future<void> sendData(BuildContext context, List<Map<String, String>> answers) async {
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

    print(body);

    final response = await http.post(urlU,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    final returnedData = jsonDecode(response.body);

    print(response.body);

    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage()),(r) => false);
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

                              List<Map<String, String>> answerss = [];
                              Map<String,Map<String,String>> answersData = Map();
                              Map<String,String> cevap = Map();

                              answersData["SoruID"] = result.results[0].results[0].id!.id.toString();
                              answersData["CevapID"] = result.results[0].results[0].id!.id.toString();

                              answersData[answersData["SoruID"],] = result.results[0].results[0].valueIdentifier.toString();
                              answerss.add(answersData);
                              answersData[result.results[1].results[0].id!.id.toString()] = result.results[1].results[0].valueIdentifier.toString();
                              answerss.add(answersData);

                              sendData(context, answerss);
                            },
                            task: task,
                            showProgress: true,
                            localizations: {
                              'cancel': 'Vazgeç',
                              'next': 'Sonraki',
                            },

                            themeData: ThemeData.dark().copyWith(
                              primaryColor:Color(0xFF330099),

                              backgroundColor:Colors.transparent,
                              scaffoldBackgroundColor: const Color(0xffc4000),
                              appBarTheme: AppBarTheme(
                                backgroundColor:Colors.transparent,
                              ),
                              textSelectionTheme: TextSelectionThemeData(
                                cursorColor: const Color(0xffc45d54),
                                selectionColor: const Color(0xffc45d54),
                                selectionHandleColor:const Color(0xffc45d54),
                              ),
                              outlinedButtonTheme: OutlinedButtonThemeData(style: ButtonStyle(
                                  foregroundColor: MaterialStateColor.resolveWith((states) => const Color(0xFF339999)),
                                  backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xffc45d54)))),

                            ),
                            surveyProgressbarConfiguration: SurveyProgressConfiguration(
                              backgroundColor: Colors.black,
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
    //final taskJson = await rootBundle.loadString('assets/example_json.json');
    //final taskMap = json.decode(taskJson);

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