import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:adobe_xd/pinned.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/anket_sorulari.dart';
enum SingingCharacter { cevap1, cevap2,cevap3,cevap4,cevap5, }


class AnketSayfasi extends StatefulWidget {
  const AnketSayfasi({Key? key}) : super(key: key);
  @override
  State<AnketSayfasi> createState() => _AnketSayfasiState();
}
class _AnketSayfasiState extends State<AnketSayfasi> {

  Future<List<AnketSorulari>> getAnketSorulari() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String unicId = sharedPreferences.getString("unicID") ?? "";

    String url = 'http://172.16.64.200/ANKET/hs/getdata/anketsorulari/';
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
    print(returnedData);

    if (response.statusCode == 200) {
      print(returnedData["Anket"]["Sorular"]);
      for (var row in returnedData["Anket"]["Sorular"]) {
        AnketSorulari anketsorusu = AnketSorulari(
            row["Soru"],
            row["SoruKodu"],
            row["Cevap1"],
            row["Cevap2"],
            row["Cevap3"],
            row["Cevap5"],
            row["LineUnicID"],
            row["LineNumber"],
            "",
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
    final AUnicID = ModalRoute.of(context)!.settings.arguments.toString();
    print(AUnicID);
    print("Anket soruları alınıyor");


    return Scaffold(
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
                              Divider(),
                              RadioListTile<int>(
                                title: Text(snapshot.data[index].Cevap1),
                                value: snapshot.data[index].SoruKodu + "1",
                                groupValue: snapshot.data[index].SoruKodu + "1",
                                onChanged: ( int? value) {
                                  setState(() {
                                    snapshot.data[index].SoruKodu = value;
                                  });
                                },
                              ),
                              RadioListTile<int>(
                                title: Text(snapshot.data[index].Cevap2),
                                value: snapshot.data[index].SoruKodu + "2",
                                groupValue: snapshot.data[index].SoruKodu + "2",
                                onChanged: ( int? value) {
                                  setState(() {
                                    snapshot.data[index].SoruKodu= value;
                                  });
                                },
                              ),
                              RadioListTile<int>(
                                title: Text(snapshot.data[index].Cevap3),
                                value: snapshot.data[index].SoruKodu,
                                groupValue: snapshot.data[index].SoruKodu,
                                onChanged: (int? value) {
                                  setState(() {
                                    snapshot.data[index].SoruKodu = value;
                                  });
                                },
                              ),
                          ]),
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
    );
  }
}
