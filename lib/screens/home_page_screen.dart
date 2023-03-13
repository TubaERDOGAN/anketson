import 'dart:convert';
import 'package:ankets/screens/anket_sayfasi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:adobe_xd/pinned.dart';
import 'dart:ui' as ui;
import 'package:path/path.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/anket.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  Future<List<Anket>> getAnketler() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String unicId = sharedPreferences.getString("unicID") ?? "";
    String username = sharedPreferences.getString("username") ?? "";
    String password = sharedPreferences.getString("password") ?? "";

    String url = 'http://172.16.64.200/ANKET/hs/getdata/anketler/';
    Uri urlU = Uri.parse(url);
    Map data = {
      'Username': username,
      'Password': password,
      'UnicID': unicId,
    };

    print(data);

    //encode Map to JSON
    var body = json.encode(data);

    final response = await http.post(urlU,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    final returnedData = jsonDecode(response.body);

    List<Anket>anketler = [];
    //print(returnedData);
    if (response.statusCode == 200) {
      print(returnedData["Anketler"]);
      for (var row in returnedData["Anketler"]) {
        Anket anket = Anket(
          row["Tarih"],
          row["AnketAdi"],
          row["ImageUrl"],
          row["UnicID"],
        );
        anketler.add(anket);
      }
      return anketler;
    }else{
      print("hata");
    }
    return anketler;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: const Color(0xffc45d54),
        extendBody: true,
        body:
        Stack(
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
                //Başlık
                Pin(size: 196.0, middle: 0.5025),
                Pin(size: 24.0, start: 40.0),
                child: const Text(
                  'Günün Anketleri',
                  style: TextStyle(
                    fontFamily: 'Work Sans',
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                    child:Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FutureBuilder(
                       future: getAnketler(),
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
                              children: [ListTile(
                                title: Text(
                                    snapshot.data[index].AnketAdi,
                                  style: const TextStyle(
                                    fontFamily: 'Work Sans',
                                    fontSize: 20,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: ReadMoreText(snapshot.data[index].id,
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
                               GestureDetector(
                                 child: Container(
                                   height:170,
                                   child:Image.network(snapshot.data[index].ImageUrl,fit: BoxFit.fill)
                                 ),
                                 onTap: () {
                                   Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (context) =>
                                               AnketSayfasi(snapshot.data[index].UnicID, unicID: '',)));
                                   //buraya anket unic gidecek.snapshot.data[index].UnicID şeklinde
                                 },
                               )
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
        )]
        ));
  }
}


