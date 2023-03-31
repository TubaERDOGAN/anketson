import 'dart:convert';
import 'package:ankets/screens/anket_sayfasi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/anket.dart';
import '../model/anketModel.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class Anketler extends StatefulWidget {

  @override
  _AnketlerState createState() => _AnketlerState();

}

class _AnketlerState extends State<Anketler> {

  int _focusedIndex = 0;

  Future<List<AnketModel>> getKategorilerVeAnketler() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String unicId = sharedPreferences.getString("unicID") ?? "";
    String username = sharedPreferences.getString("username") ?? "";
    String password = sharedPreferences.getString("password") ?? "";

    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/kategorilerveanketler/';
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
    print(returnedData);

    List<AnketModel> kategorilerveanketler = [];

    if (response.statusCode == 200) {

      for (var row in returnedData["KategorilerVeAnketler"]) {

        List<Anket> anketler = [];
        for (var rowAnket in row["Anketler"]) {
          Anket anket = Anket(
              rowAnket["Tarih"],
              rowAnket["AnketAdi"],
              rowAnket["ImageUrl"],
              rowAnket["UnicID"],
              rowAnket["OnizlemeAciklamasi"]
          );
          anketler.add(anket);
        }

        AnketModel anketModel = AnketModel(
          row["Kod"],
          row["Tanim"],
          row["ImageUrl"],
          row["Aciklama"],
          row["UnicID"],
          anketler,
          row["AnketAdedi"],
        );

        kategorilerveanketler.add(anketModel);

      }

      return kategorilerveanketler;

    }else{

      print("hata");

      return kategorilerveanketler;

    }
  }

  void _onItemFocus(int index) {
    _focusedIndex = index;
    print(_focusedIndex);
  }

  @override
  Widget build(BuildContext context) {

    //getKategorilerVeAnketler();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Anket Kategorileri',
            style:  TextStyle(
              fontFamily: 'Work Sans',
              fontSize: 18,
              color: const Color(0xffffffff),
              fontWeight: FontWeight.w600,

            ),

          ),
        ),
        extendBodyBehindAppBar: false,
        extendBody: true,
        resizeToAvoidBottomInset: false,
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
              Center(
                  child: FutureBuilder(
                      future: getKategorilerVeAnketler(),
                      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return Center( child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ListView.separated(
                                  separatorBuilder: (BuildContext context, int index) => SizedBox(
                                    height: 10,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (ctx, index) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(16.0),
                                      ),
                                      child: Column( children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          height: 30.0,
                                          child: Text(
                                            snapshot.data[index].Tanim,
                                            style: const TextStyle(
                                              fontFamily: 'Work Sans',
                                              fontSize: 15,
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          alignment: Alignment(-1, 1),
                                        ),
                                        Container(
                                            height: 150.0,
                                            child: ScrollSnapList(
                                              onItemFocus: _onItemFocus,
                                              itemSize: 140,
                                              dynamicItemSize: true,
                                              shrinkWrap: true,
                                              padding: const EdgeInsets.all(6),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: snapshot.data[index].Anketler.length,
                                              itemBuilder: (ctx, indexAnket) => Padding(padding: const EdgeInsets.all(2),child: Container(
                                                color: Colors.white60,
                                                width: 180.0,
                                                height: 150.0,
                                                child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AnketSayfasi(anketID: snapshot.data[index].Anketler[indexAnket].UnicID)));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(snapshot.data[index].Anketler[indexAnket].ImageUrl),
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        snapshot.data[index].Anketler[indexAnket].AnketAdi,
                                                        style: const TextStyle(
                                                          fontFamily: 'Work Sans',
                                                          fontSize: 16,
                                                          color: Color(0xff000000),
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    )
                                                ),
                                              ),
                                              ),
                                            )
                                        )]
                                      )
                                  )
                              )
                          )
                          );
                        }
                      }
                  )
              )
            ]
        )
    );
  }
}
