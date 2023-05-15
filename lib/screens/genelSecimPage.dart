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


class genelSecim extends StatefulWidget {
  @override
  _genelSecimMainState createState() => _genelSecimMainState();
}


class _genelSecimMainState extends State<genelSecim> {
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
            elevation: 10,
            shadowColor: Colors.orange,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                    height: 80
                ),




                // IGODO logosu



                Container(

                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      '2023 Milletvekilliği Genel Seçimlerinde hangi partiye oy vereceksiniz?',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  height: 70,
                ),






                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/akparti.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                  padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                  child:Text(
                                      'ADALET VE KALKINMA PARTİSİ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    )
                                  )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),




                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/chp.png'),
                                      fit: BoxFit.contain
                                      ,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'CUMHURİYET HALK PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/iyiparti.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'İYİ PARTİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),



                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/mhp.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'MİLLİYETÇİ VE HAREKET PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),



                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/zaferparti.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'ZAFER PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/memleketparti.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'MEMLEKET PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/anavatanpartisi.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'ANAVATAN PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),



                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/adaletbirlikpartisi.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'ADALET BİRLİK PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/buyukturkiyepartisi.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'BÜYÜK TÜRKİYE PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/adaletpartisi.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'ADALET PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/bbp.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'BÜYÜK BİRLİK PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/btp.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'BÜYÜK TÜRKİYE PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),



                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/deva.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'DEMOKRASİ VE ATILIM PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/dsp.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'DEMOKRATİK SOL PARTİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/demokratparti.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'DEMOKRAT PARTİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/emekpartisi.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'EMEK PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),



                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/gelecekpartisi.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'GELECEK PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/gencparti.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'GENÇ PARTİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/gucbirligiparti.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'GÜÇ BİRLİĞİ PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),



                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/hakozgurlukparti.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'HAK VE ÖZGÜRLÜKLER PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),



                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/hkp.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'HALKIN KURTULUŞ PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),



                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/hudapar.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'HÜR DAVA PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/milletpartisi.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'MİLLET PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/milliyolparti.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'MİLLİ YOL PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),



                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/saadetpartisi.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'SAADET PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/solparti.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'SOL PARTİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/turkiyedegisim.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'TÜRKİYE DEĞİŞİM PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/turkiyeisciparti.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'TÜRKİYE İŞÇİ PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/tkh.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'TÜRKİYE KOMÜNİST HAREKETİ PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/turkiyekomunist.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'TÜRKİYE KOMÜNİST PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/vatanparti.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'VATAN PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/yenidenrefah.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'YENİDEN REFAH PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),


                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/yenilikparti.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'YENİLİK PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),



                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/yeniturkiyeparti.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'YENİ TÜRKİYE PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),



                Positioned(
                  width: 330,
                  height: 10,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                      Navigator.of(context).pushNamed('/mvsecimsonuc');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/yesilsolparti.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: Padding(
                                    padding: EdgeInsets.only(top:0), //TEXTİN EN ÜSTTEN UZAKLIĞI
                                    child:Text(
                                        'YEŞİLLER VE SOL GELECEK PARTİSİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                ))
                              ],
                            ),
                            // Header text
                            Container(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),



              ],
            ),
          )
      ),
    );
  }
}



/*
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) =>
          [
            SliverAppBar(
              backgroundColor: Color(0xfffff),
              expandedHeight: 35,
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              centerTitle: true,
              title: const Text(
                '2023 Seçim Anketi',
                style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 18,
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
          body: Stack(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.0, -1.0),
                    end: Alignment(0.0, 1.0),
                    colors: [
                      Color(0xffffffff),
                      //igodoOrange,
                      Color(0xffffffff),

                    ],
                    stops: [0.0, 0.402, 1.0],
                  ),
                ),
              ),

              // IGODO logosu
              Positioned(
                top: kToolbarHeight - 85,
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

              // Cumhurbaskanligi
              Positioned(
                  top: kToolbarHeight + 110,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      print('tikladin asko');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: igodoOrange,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(
                                  0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Header text
                            Container(
                                height: 8
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '14 Mays seçimlerinde hangi Cumhurbaşkanı adayına oy vereceksiniz?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xffffffff)
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                                height: 10
                            ),
                            // Image widget
                            Image.asset('lib/assets/igodoAssets/toplu.jpg'),
                            // Replace with your actual image widget
                            Container(
                                height: 15
                            ),
                            Image.asset('lib/assets/igodoAssets/buton.png'),
                            Container(
                                height: 10
                            ),
                            /*
                          GestureDetector(
                            onTap: () {
                              // Do something when the button is tapped
                            },
                            child: Ink.image(
                              image: const AssetImage('lib/assets/igodoAssets/buton.png'),
                              width: 200,
                              height: 50,
                              child: InkWell(
                                onTap: () {
                                  // Do something when the button is tapped
                                },
                                child: Center(
                                  child: Text(
                                    'Button Text',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          */
                          ],
                        ),
                      ),
                    ),
                  )
              ),

              // Genel Secim
              Positioned(
                top: kToolbarHeight + 520,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    print('Ikinciye tikladin askooom');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: igodoOrange,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Image.asset(
                              'lib/assets/igodoAssets/meclisBackground.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            children: [
                              // Header text
                              Container(
                                height: 8,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '2023 Milletvekilliği Genel Seçimlerinde hangi partiye oy vereceksiniz?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xffffffff),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                height: 10,
                              ),
                              // Image widget
                              Image.asset(
                                'lib/assets/igodoAssets/meclisPhoto.png',
                              ), // Replace with your actual image widget
                              Container(
                                height: 15,
                              ),
                              Image.asset('lib/assets/igodoAssets/buton.png'),
                              Container(
                                height: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
*/