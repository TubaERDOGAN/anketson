import 'dart:convert';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'dart:ui' as ui;
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/anket_sorulari.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';


class AnketSayfasi extends StatefulWidget {
  AnketSayfasi({Key? key}) : super(key: key);
  @override
  State<AnketSayfasi> createState() => _AnketSayfasiState();
}

enum Answer {cevap}

class _AnketSayfasiState extends State<AnketSayfasi> {

  Future<List<AnketSorulari>> getAnketSorulari() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String unicId = sharedPreferences.getString("unicID") ?? "";

    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/anketsorulari/';
    Uri urlU = Uri.parse(url);
    Map data = {
      'UserUnicID': unicId,
      'UnicID': "e544696e-9706-428f-9a98-ad15f3c80d4e",
    };

    //print(data);

    //encode Map to JSON
    var body = json.encode(data);

    final response = await http.post(urlU,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    final returnedData = jsonDecode(response.body);

    List<AnketSorulari> sorular = [];
    //print(returnedData);

    if (response.statusCode == 200) {
      //print(returnedData["Anket"]["Sorular"]);
      for (var row in returnedData["Anket"]["Sorular"]) {
        print(row["Cevaplar"]);

        List<String> cevaplar = [];
        for (var rowCevap in row["Cevaplar"]) {
          cevaplar.add(rowCevap);
        }


        AnketSorulari anketsorusu = AnketSorulari(
            row["Soru"],
            row["SoruKodu"],
            '',
            '',
            '',
            '',
            '',
            '',
            '',
            cevaplar
        );
        print(anketsorusu);
        sorular.add(anketsorusu);
      }
      return sorular;
    }else{
      print("hata");
    }
    return sorular;
  }

  Map<int, String> answerVal = {};
  @override
  Widget build(BuildContext context) {
    final AUnicID = ModalRoute.of(context)!.settings.arguments.toString();
    print(AUnicID);
    print("Anket soruları alınıyor");

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
                              print(result.finishReason);
                              Navigator.pushNamed(context, '/');
                            },
                            task: task,
                            showProgress: true,
                            localizations: {
                              'cancel': 'Cancel',
                              'next': 'Next',
                            },

                            themeData: ThemeData.dark().copyWith(
                              primaryColor:Color(0xff8fa8a2),

                              backgroundColor:Colors.transparent,
                              scaffoldBackgroundColor: const Color(0x66ffffff),
                              appBarTheme: AppBarTheme(
                                backgroundColor:const Color(0x66ffffff),
                                shape: BeveledRectangleBorder(
                                  borderRadius:BorderRadius.circular(0) ,
                                ),
                                iconTheme: IconThemeData(
                                  color: Colors.white,
                                  size: 30,
                                ) ,
                                titleTextStyle: TextStyle(
                                  fontFamily: 'Work Sans',
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                              ),
                              textSelectionTheme: TextSelectionThemeData(
                                cursorColor: const Color(0xff000000),
                                selectionColor: const Color(0xff919a94),
                                selectionHandleColor:const Color(0xffc45d54),
                              ),

                              /// ne işe yaradığı anlaşılmadı
                              cupertinoOverrideTheme: CupertinoThemeData(
                                primaryColor: const Color(0xffc45d54),
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
                                          color: const Color(0xffcbcac6),
                                        );
                                      }
                                      return BorderSide(
                                        color:const Color(0xffc45d54),
                                      );
                                    },
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  textStyle: MaterialStateProperty.resolveWith(
                                        (Set<MaterialState> state) {
                                      if (state.contains(MaterialState.disabled)) {
                                        return Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                          color: Color(0xff000000),
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
                              /// ne işe yaradığı anlaşılmadı
                              textButtonTheme: TextButtonThemeData(
                                style: ButtonStyle(
                                  textStyle: MaterialStateProperty.all(
                                    Theme.of(context).textTheme.labelLarge?.copyWith(
                                      color: Colors.cyan,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            surveyProgressbarConfiguration: SurveyProgressConfiguration(
                              backgroundColor: Colors.lime,
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

  Future<Task> getSampleTask() {
    var task = NavigableTask(
      id: TaskIdentifier(),
      steps: [
        InstructionStep(
          title: 'Welcome to the\nQuickBird Studios\nHealth Survey',
          text: 'Get ready for a bunch of super random questions!',
          buttonText: 'Let\'s go!',
        ),
        QuestionStep(
          title: 'How old are you?',
          answerFormat: IntegerAnswerFormat(
            defaultValue: 25,
            hint: 'Please enter your age',
          ),
          isOptional: true,
        ),
        QuestionStep(
          title: 'Medication?',
          text: 'Are you using any medication',
          answerFormat: BooleanAnswerFormat(
            positiveAnswer: 'Yes',
            negativeAnswer: 'No',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Tell us about you',
          text:
          'Tell us about yourself and why you want to improve your health.',
          answerFormat: TextAnswerFormat(
            maxLines: 5,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),
        QuestionStep(
          title: 'Select your body type',
          answerFormat: ScaleAnswerFormat(
            step: 1,
            minimumValue: 1,
            maximumValue: 5,
            defaultValue: 3,
            minimumValueDescription: '1',
            maximumValueDescription: '5',
          ),
        ),
        QuestionStep(
          title: 'Known allergies',
          text: 'Do you have any allergies that we should be aware of?',
          isOptional: false,
          answerFormat: MultipleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Penicillin', value: 'Penicillin'),
              TextChoice(text: 'Latex', value: 'Latex'),
              TextChoice(text: 'Pet', value: 'Pet'),
              TextChoice(text: 'Pollen', value: 'Pollen'),
            ],
          ),
        ),
        QuestionStep(
          title: 'Done?',
          text: 'We are done, do you mind to tell us more about yourself?',
          isOptional: true,
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Yes', value: 'Yes'),
              TextChoice(text: 'No', value: 'No'),
            ],
            defaultSelection: TextChoice(text: 'No', value: 'No'),
          ),
        ),
        QuestionStep(
          title: 'When did you wake up?',
          answerFormat: TimeAnswerFormat(
            defaultValue: TimeOfDay(
              hour: 12,
              minute: 0,
            ),
          ),
        ),
        QuestionStep(
          title: 'When was your last holiday?',
          answerFormat: DateAnswerFormat(
            minDate: DateTime.utc(1970),
            defaultDate: DateTime.now(),
            maxDate: DateTime.now(),
          ),
        ),
        CompletionStep(
          stepIdentifier: StepIdentifier(id: '321'),
          text: 'Thanks for taking the survey, we will contact you soon!',
          title: 'Done!',
          buttonText: 'Submit survey',
        ),
      ],
    );
    task.addNavigationRule(
      forTriggerStepIdentifier: task.steps[6].stepIdentifier,
      navigationRule: ConditionalNavigationRule(
        resultToStepIdentifierMapper: (input) {
          switch (input) {
            case "Yes":
              return task.steps[0].stepIdentifier;
            case "No":
              return task.steps[7].stepIdentifier;
            default:
              return null;
          }
        },
      ),
    );
    return Future.value(task);
  }

  Future<Task> getJsonTask() async {
    final taskJson = await rootBundle.loadString('assets/example_json.json');
    final taskMap = json.decode(taskJson);

    return Task.fromJson(taskMap);
  }

}
const String _svg_ahsnb9 =
    '<svg viewBox="-243.2 -327.5 779.2 716.5" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 536.04, 219.47)" d="M 1.024306038743816e-05 184.1095581054688 C 7.517889116570586e-06 285.7896118164062 100.297233581543 368.2178955078125 224.0208892822266 368.2178955078125 C 274.1476745605469 368.2178649902344 320.4256591796875 354.6895446777344 357.7494201660156 331.8302612304688 C 352.7652893066406 349.4608764648438 350.0668640136719 368.312255859375 350.0668640136719 387.898193359375 C 350.0668640136719 486.4231567382812 418.3290100097656 566.2928466796875 502.5333862304688 566.2928466796875 C 586.7387084960938 566.2928466796875 654.9998779296875 486.4231262207031 654.9998779296875 387.898193359375 C 654.9998779296875 289.3731994628906 586.7387084960938 209.5035095214844 502.5333862304688 209.5035095214844 C 481.3537902832031 209.5035400390625 461.1823120117188 214.5567932128906 442.8525085449219 223.688720703125 C 446.2498474121094 210.9415893554688 448.0417785644531 197.694580078125 448.0417785644531 184.1095581054688 C 448.0417785644531 82.4283447265625 347.7445373535156 6.103515625e-05 224.0209045410156 6.103515625e-05 C 100.2972412109375 6.103515625e-05 1.296826212637825e-05 82.4283447265625 1.024306038743816e-05 184.1095581054688 Z" fill="#929a94" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';