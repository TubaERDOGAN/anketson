import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ankets/model/anket.dart';
import 'package:ankets/model/anketModel.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnketKategori extends StatelessWidget {
  final String kategoriTanim;

  AnketKategori({Key? key, required this.kategoriTanim}) : super(key: key);
  Future<List<Anket>> getAnketler() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String unicId = sharedPreferences.getString("unicID") ?? "";
    String username = sharedPreferences.getString("username") ?? "";

    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/kategorilerveanketler/';
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
    final returnedData = jsonDecode(utf8.decode(response.bodyBytes));
    //print(returnedData);
    List<Anket> anketler = [];
    if (response.statusCode == 200) {
      if(kategoriTanim != "") {
        for (var row in returnedData["KategorilerVeAnketler"]) {
          if(kategoriTanim == row["Tanim"]) {
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
          }
        }
      }
      return anketler;
    }else{
      print("hata");
      return anketler;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body:NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 0,
              floating: true,
              snap:true,
              forceElevated: innerBoxIsScrolled,
              centerTitle: true,
              title: const Text(
                'Anket Kategorileri',
                style:  TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 18,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: Builder(
                builder: (BuildContext context) {
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(4.0,0.0,0.0,0.0),
                      child:IconButton(
                        icon: Icon(
                            Icons.arrow_back_outlined
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ));
                },
              ),
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                      },
                      child: Icon(
                        Icons.search,
                        size: 26.0,
                      ),
                    )
                ),
              ],
            ),
          ],
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
                        future: getAnketler(),
                        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            return Center( child: Padding(
                                padding: const EdgeInsets.fromLTRB(20.0,0.0,20.0,0.0),
                                child: ListView.separated(
                                    separatorBuilder: (BuildContext context, int index) => SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.009,
                                    ),
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (ctx, index) => Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(16.0),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 180,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                color: Colors.white60,
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  image: NetworkImage(snapshot.data[index].ImageUrl),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Container(
                                              width: 180,
                                              height: 120,
                                              child: Column(
                                                children: [
                                                 Padding(
                                                   padding: const EdgeInsets.fromLTRB(0.0,20.0,0.0,0.0),
                                                   child:SizedBox(
                                                   width: 180,
                                                   child:Text(
                                                    snapshot.data[index].AnketAdi,
                                                    style: const TextStyle(
                                                      fontFamily: 'Work Sans',
                                                      fontSize: 16,
                                                      color: Color(0xff000000),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                     textAlign:TextAlign.left ,
                                                  ),),),
                                                  Text(
                                                    snapshot.data[index].OnizlemeAciklamasi,
                                                    style: const TextStyle(
                                                      fontFamily: 'Work Sans',
                                                      fontSize: 16,
                                                      color: Color(0xff000000),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
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
      ),);
  }



}