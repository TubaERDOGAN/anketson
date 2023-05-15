import 'dart:async';
import 'dart:convert';
import 'package:adobe_xd/pinned.dart';
import 'package:ankets/screens/anket_kategori.dart';
import 'package:ankets/screens/anket_sayfasi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/anket.dart';
import '../model/anketModel.dart';

const Color igodoOrange = Color(0xFFF6994D);

class FullScreenModal extends ModalRoute {
  List<AnketModel> kategorilerveanketler = [];
  String searchText = "";

  Future<List<AnketModel>> getKategorilerVeAnketler() async {
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
    kategorilerveanketler.clear();
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
        if (searchText != "") {
          if (row["Tanim"].toString().contains(searchText.trim().toString())) {
            kategorilerveanketler.add(anketModel);
          }
        } else {
          kategorilerveanketler.add(anketModel);
        }
      }
      return kategorilerveanketler;
    } else {
      print("hata");
      return kategorilerveanketler;
    }
  }

  // variables passed from the parent widget
  final String title;
  final String description;

  // constructor
  FullScreenModal({
    required this.title,
    required this.description,
  });


  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.86);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  List filteredTempCropList = [];
  final FocusNode _textFocusNode = FocusNode();
  TextEditingController? _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textFocusNode.dispose();
    _textEditingController!.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,) {
    return Material(
        type: MaterialType.transparency, child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder(
            future: getKategorilerVeAnketler(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.8,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.05,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            onChanged: (value) {
                              if (value != "") {
                                setState(() {
                                  searchText = value;
                                });
                              }
                            },
                            controller: _textEditingController,
                            decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior
                                    .never,
                                border: InputBorder.none,
                                hintText: 'Search...',
                                hintStyle: TextStyle(
                                  color: Colors.white,

                                ),
                                suffixIcon: IconButton(
                                  color: Colors.white,
                                  onPressed: () =>
                                      setState(() {
                                        searchText = "";
                                        _textEditingController?.clear();
                                      }),
                                  icon: Icon(Icons.clear),
                                ),
                                prefixIcon: IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.search),
                                  onPressed: () {},
                                )
                            ),
                          ),
                        ),


                        Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.75,
                            //color: Colors.tealAccent,
                            child: ListView.separated(
                                separatorBuilder: (BuildContext context,
                                    int index) =>
                                    SizedBox(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.013,
                                    ),
                                itemCount: _textEditingController!.text
                                    .isNotEmpty
                                    ? snapshot.data!.length
                                    : snapshot.data.length,
                                itemBuilder: (ctx, index) =>
                                    Center(child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                            child: Column(children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AnketKategori(
                                                                  kategoriTanim: snapshot
                                                                      .data[index]
                                                                      .Tanim)));
                                                },
                                                child: Text(
                                                  snapshot.data[index].Tanim,
                                                  style: const TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.white
                                                  ),
                                                ),),
                                            ],)))
                                    )
                            ))
                      ],
                    )
                )
                );
              }
            },
          ),)
    ));
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // add fade animation
    return FadeTransition(
      opacity: animation,
      // add slide animation
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(animation),
        // add scale animation
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      ),
    );
  }
}


class mvSonuc extends StatefulWidget {
  @override
  _mvSonucMainState createState() => _mvSonucMainState();
}

class _mvSonucMainState extends State<mvSonuc> {
  Future<List<AnketModel>> getKategorilerVeAnketler() async {
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
    } else {
      print("hata");
      return kategorilerveanketler;
    }
  }

  dynamic _showModal(BuildContext context) async {
    // show the modal dialog and pass some data to it
    final result = await Navigator.of(context).push(
        FullScreenModal(
            title: 'Tarih',
            description: 'Just some dummy description text')


    );

    // print the data returned by the modal if any
    debugPrint(result.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(''),
            backgroundColor: igodoOrange,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                    height: 50
                ),


                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      // Replace this with your actual logo image widget
                      height: 200,
                      width: 300,
                      child: Image.asset('lib/assets/igodoAssets/igodoLogo.png'),
                    ),
                  ),
                ),

                //-------------------------------------------------------------
                // SONUC
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                        height: 90,
                        width: 330,
                        child: const Text('Cevabınız kaydedilmiştir.            Ankete katıldığınız için teşekkür ederiz',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )
                    ),
                  ),
                ),

                Container(
                    height: 30
                ),

                //  SEÇİM SONUÇLARI HA BURAYA GELECEK
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      // Replace this with your actual logo image widget
                      height: 300,
                      width: 400,
                      child: Image.asset('lib/assets/igodoAssets/mvsocun.png'),
                    ),
                  ),
                ),


                Container(
                    height: 40
                ),

                ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/secimAnket');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: igodoOrange,
                  ),
                  child: Text('Ana sayfaya dön',

                  ),


                )

              ],
            ),
          )
      ),
    );
  }
}