import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'dart:ui' as ui;
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/anket_sorulari.dart';




class AnketSayfasi extends StatefulWidget {
  const AnketSayfasi({Key? key}) : super(key: key);
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


    return SafeArea(child:Scaffold(
      backgroundColor: const Color(0xffc45d54),
      extendBody: true,
      body: Stack(
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
          ///burada gradient bitiyor
          Center(
              child:Padding(
                padding: const EdgeInsets.all(12.0),
                child: FutureBuilder(
                  future: getAnketSorulari(),
                  builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return ListView.separated(
                        itemCount: snapshot.data.length,
                        itemBuilder: (ctx, index) =>Container(
                          width: 337.0,
                          decoration: BoxDecoration(
                            color: const Color(0x66ffffff),
                            borderRadius:
                            BorderRadius.circular(21.0),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                              subtitle: ReadMoreText(snapshot.data[index].Soru,
                                style: const TextStyle(
                                  fontFamily: 'Work Sans',
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                                trimMode: TrimMode.Line,
                                trimLines: 3,
                                colorClickableText: Colors.black,
                                trimCollapsedText:
                                'Daha fazla göster',
                                trimExpandedText: ' Daha az göster',
                              ),
                            ),
                              _buildSection1ListItems(snapshot.data[index].Cevaplar),
                          ]
                          ),

                          //_buildSection1ListItems(Map<int, Answer> answers),
                        ),
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(
                          height: 10,
                        ),
                      );
                    }
                  },
                ),)
          )
        ],
      ),
    ));
  }
  Widget _buildSection1ListItems(List<String> cevaplar) {
    /*List<Widget> a = [];
    for(int k = 0; k < cevaplar.length; k++) {
      a.add(RadioListTile<String>(
          groupValue: answerVal[k],
          title: Text(cevaplar[k]),
          value: cevaplar[k],
          onChanged: (String? val) {
            setState(() {
              answerVal[k]= val!;
            });
          },
        ));
      }
    return a;*/

    return RadioListTile<String>(
      groupValue: answerVal[0],
      title: Text(cevaplar[0]),
      value: cevaplar[0],
      onChanged: (String? val) {
        setState(() {
          answerVal[0]= val!;
        });
      },
    );

    }
  }






