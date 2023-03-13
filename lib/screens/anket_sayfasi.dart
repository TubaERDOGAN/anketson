import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:adobe_xd/pinned.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnketSayfasi extends StatefulWidget {
  const AnketSayfasi({Key? key}) : super(key: key);

  @override
  State<AnketSayfasi> createState() => _AnketSayfasiState();
}
class _AnketSayfasiState extends State<AnketSayfasi> {

  Future<List<String>> getAnketSorulari(String anketUnicID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String unicId = sharedPreferences.getString("unicID") ?? "";

    String url = 'http://172.16.64.200/ANKET/hs/getdata/anketsorulari/';
    Uri urlU = Uri.parse(url);
    Map data = {
      'UserUnicID': unicId,
      'UnicID': anketUnicID,   //??
    };

    print(data);

    //encode Map to JSON
    var body = json.encode(data);

    final response = await http.post(urlU,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    final returnedData = jsonDecode(response.body);

    List<String>sorular = [];
    //print(returnedData);
    if (response.statusCode == 200) {
      print(returnedData["AnketBilgisi"]["Sorular"]);
      for (var row in returnedData["AnketBilgisi"]["Sorular"]) {
        row["Soru"];
      }
      return sorular;
    }else{
      print("hata");
    }
    return sorular;
  }

  @override
  Widget build(BuildContext context) {

    final data = ModalRoute.of(context)!.settings;
    print(data);
    print(data.arguments.toString());
    getAnketSorulari(data.arguments.toString());

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
                  future: getAnketSorulari(data.arguments.toString()),
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
                            ],
                          ),
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
