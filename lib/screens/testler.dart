import 'dart:convert';
import 'package:ankets/screens/anket_sayfasi.dart';
import 'package:ankets/screens/test_sayfasi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/test.dart';
import '../model/testModel.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class Testler extends StatefulWidget {
  @override
  _TestlerState createState() => _TestlerState();
}
class _TestlerState extends State<Testler> {
  Future<List<TestModel>> getKategorilerVeTestler() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String unicId = sharedPreferences.getString("unicID") ?? "";
    String username = sharedPreferences.getString("username") ?? "";

    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/kategorilervetestler/';
    Uri urlU = Uri.parse(url);
    Map data = {
      'Username': username,
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

    List<TestModel> kategorilervetestler = [];

    if (response.statusCode == 200) {

      for (var row in returnedData["KategorilerVeTestler"]) {

        List<Test> testler = [];
        for (var rowTest in row["Testler"]) {
          Test test = Test(
              rowTest["Tarih"],
              rowTest["TestAdi"],
              rowTest["ImageUrl"],
              rowTest["UnicID"],
              rowTest["OnizlemeAciklamasi"]
          );
          testler.add(test);
        }
        TestModel testModel = TestModel(
          row["Kod"],
          row["Tanim"],
          row["ImageUrl"],
          row["Aciklama"],
          row["UnicID"],
          testler,
          row["TestAdedi"],
        );

        kategorilervetestler.add(testModel);
      }
      return kategorilervetestler;
    }else{
      print("hata");
      return kategorilervetestler;
    }
  }
  @override
  Widget build(BuildContext context) {
    //getKategorilerVeAnketler();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Test Kategorileri',
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
                      future: getKategorilerVeTestler(),
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
                                    height: MediaQuery.of(context).size.height * 0.003,
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
                                          height: MediaQuery.of(context).size.height * 0.03,
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
                                            height: MediaQuery.of(context).size.height * 0.25,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              padding: const EdgeInsets.all(6),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: snapshot.data[index].Testler.length,
                                              itemBuilder: (ctx, indexTest) => Padding(padding: const EdgeInsets.all(2),child: Container(
                                                width: 120.0,
                                                height: MediaQuery.of(context).size.height * 0.25,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TestSayfasi(TestID: snapshot.data[index].Testler[indexTest].UnicID)));
                                                  },
                                                    child: Column(
                                                        children: [
                                                      Container(
                                                        width: MediaQuery.of(context).size.height * 0.15,
                                                        height: MediaQuery.of(context).size.height * 0.2,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(21.0),
                                                          color: Colors.white60,
                                                          image: DecorationImage(
                                                            image: NetworkImage(snapshot.data[index].Testler[indexTest].ImageUrl),
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),

                                                      ),
                                                    SizedBox(
                                                        width: MediaQuery.of(context).size.height * 0.15,
                                                        child:Text(
                                                          snapshot.data[index].Testler[indexTest].TestAdi,
                                                          style: const TextStyle(
                                                            fontFamily: 'Work Sans',
                                                            fontSize: 16,
                                                            color: Color(0xff000000),
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          textAlign: TextAlign.left,
                                                        )

                                                    ),
                                                        ],
                                                    )
                                                )
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
