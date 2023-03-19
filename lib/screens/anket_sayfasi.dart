import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/anket_sorulari.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';

class AnketSayfasi extends StatefulWidget {
  const AnketSayfasi({Key? key}) : super(key: key);

  @override
  State<AnketSayfasi> createState() => _AnketSayfasiState();
}

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
        AnketSorulari anketsorusu = AnketSorulari(
            row["Soru"],
          row["SoruKodu"],
          row["Cevap1"],
          '',
          '',
             '',
             '',
             '',
             '',

        );
        sorular.add(anketsorusu);
      }
      return sorular;
    }else{
      print("hata");
    }
    return sorular;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Align(
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
                      'cancel': 'İptal',
                      'next': 'İleri',
                    },
                    themeData: Theme.of(context).copyWith(
                      primaryColor: Colors.cyan,
                      appBarTheme: const AppBarTheme(
                        color: Colors.white,
                        iconTheme: IconThemeData(
                          color: Colors.cyan,
                        ),
                        titleTextStyle: TextStyle(
                          color: Colors.cyan,
                        ),
                      ),
                      iconTheme: const IconThemeData(
                        color: Colors.cyan,
                      ),
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: Colors.cyan,
                        selectionColor: Colors.cyan,
                        selectionHandleColor: Colors.cyan,
                      ),
                      cupertinoOverrideTheme: CupertinoThemeData(
                        primaryColor: Colors.cyan,
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
                                color: Colors.cyan,
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
                      textButtonTheme: TextButtonThemeData(
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                            Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.cyan,
                            ),
                          ),
                        ),
                      ),
                      textTheme: TextTheme(
                        displayMedium: TextStyle(
                          fontSize: 28.0,
                          color: Colors.black,
                        ),
                        headlineSmall: TextStyle(
                          fontSize: 24.0,
                          color: Colors.black,
                        ),
                        bodyMedium: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        titleMedium: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      colorScheme: ColorScheme.fromSwatch(
                        primarySwatch: Colors.cyan,
                      )
                          .copyWith(
                        onPrimary: Colors.white,
                      )
                          .copyWith(background: Colors.white),
                    ),
                    surveyProgressbarConfiguration: SurveyProgressConfiguration(
                      backgroundColor: Colors.white,
                    ),
                  );
                }
                return CircularProgressIndicator.adaptive();
              },
            ),
          ),
        ),
      ),
    );
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
    final taskJson = await rootBundle.loadString('example_json.json');
    final taskMap = json.decode(taskJson);

    return Task.fromJson(taskMap);
  }
}