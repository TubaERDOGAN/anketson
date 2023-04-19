import 'dart:convert';
import 'package:ankets/screens/anket_kategori.dart';
import 'package:ankets/screens/anket_sayfasi.dart';
import 'package:ankets/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/anket.dart';
import '../model/anketModel.dart';
// this class defines the full-screen semi-transparent modal dialog
// by extending the ModalRoute class
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
        if(searchText != ""){
          if(row["Tanim"].toString().contains(searchText.trim().toString())){
            kategorilerveanketler.add(anketModel);
          }
        }else{
          kategorilerveanketler.add(anketModel);
        }
      }
      return kategorilerveanketler;
    }else{
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
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    return Material(
        type: MaterialType.transparency,child: Center(
        child:Padding(
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder(
            future: getKategorilerVeAnketler(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center( child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                    child: Column(
                      children: [
                        Container(
                          width:MediaQuery.of(context).size.width * 0.7 ,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white70),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: TextField(
                            onChanged: (value){
                                if(value != ""){
                                  setState(() {
                                    searchText = value;
                                  });
                                }
                            },
                            controller:_textEditingController,
                            decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                              hintText: 'Search...',
                              hintStyle: TextStyle(
                                color:Colors.white70 ,
                              ),
                              suffixIcon: IconButton(
                                color:Colors.white70 ,
                                onPressed: () => setState(() {
                                searchText = "";
                                _textEditingController?.clear();
                            }),
                                icon: Icon(Icons.clear),
                              ),
                               prefixIcon: IconButton(
                                 color:Colors.white70 ,
                                 icon: Icon(Icons.search),
                                 onPressed: (){},
                               )
                            ),
                          ),
                        ),


                        Container(
                            height: MediaQuery.of(context).size.height * 0.85,
                            //color: Colors.tealAccent,
                            child:ListView.separated(
                            separatorBuilder: (BuildContext context, int index) => SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            itemCount: _textEditingController!.text.isNotEmpty ?snapshot.data!.length:snapshot.data.length,
                            itemBuilder: (ctx, index) => Center(child:Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                child:Container(child:Column(children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AnketKategori(kategoriTanim: snapshot.data[index].Tanim)));
                                    },
                                    child:Text(
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


class Anketler extends StatefulWidget {
  @override
  _AnketlerState createState() => _AnketlerState();
}
class _AnketlerState extends State<Anketler> {
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
    }else{
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

    //getKategorilerVeAnketler();

    return SafeArea(child:Scaffold(
      extendBodyBehindAppBar: false,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body:NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              //backgroundColor: Colors.lime,
              expandedHeight:0,
              floating: true,
              snap:true,
              forceElevated: innerBoxIsScrolled,
              centerTitle: true,
              title: const Text(
                'Anket Kategorileri',
                style:  TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 18,
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: Builder(
                builder: (BuildContext context) {
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(4.0,0.0,0.0,0.0),
                      child:IconButton(
                        icon: const Icon(
                            Icons.arrow_back_outlined
                        ),
                        onPressed: () {
                              /*Navigator.of(context)
                              .popUntil(ModalRoute.withName("/home"));*/
                         Navigator.of(context).pop();/// burası
                        },
                      ));
                },
              ),
              actions: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        _showModal(context);
                      },
                      child: const Icon(
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
                        future: getKategorilerVeAnketler(),
                        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Center( child: Padding(
                                padding: const EdgeInsets.fromLTRB(8.0,0.0,0.0,5.0),
                                child: ListView.separated(
                                    separatorBuilder: (BuildContext context, int index) => SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.003,
                                    ),
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (ctx, index) => Container(
                                      width: MediaQuery.of(context).size.width *1,
                                        height: MediaQuery.of(context).size.height *0.233,
                                        decoration: BoxDecoration(
                                         //color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(0.0),
                                        ),
                                        child: Column( children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.only(top: 0.0),
                                            height: MediaQuery.of(context).size.height * 0.03,
                                            alignment: const Alignment(-1, 1),
                                            //color: Colors.deepPurpleAccent,
                                            child: Text(
                                              snapshot.data[index].Tanim,
                                              style: const TextStyle(
                                                fontFamily: 'Work Sans',
                                                fontSize: 18,
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Container(
                                              height: MediaQuery.of(context).size.height * 0.2000,
                                            // color: Colors.orangeAccent,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                padding: const EdgeInsets.all(4),
                                                scrollDirection: Axis.horizontal,
                                                itemCount: snapshot.data[index].Anketler.length,
                                                itemBuilder: (ctx, indexAnket) => Padding(padding: const EdgeInsets.fromLTRB(0.0,0.0,3.35,0.0),child: Container(
                                                  width: MediaQuery.of(context).size.height * 0.128,
                                                  height: MediaQuery.of(context).size.height * 0.2000,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white60,
                                                    borderRadius:
                                                    BorderRadius.circular(5.0),
                                                    image: DecorationImage(
                                                      image: NetworkImage(snapshot.data[index].Anketler[indexAnket].ImageUrl),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  //color: Colors.lightBlue,
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    AnketSayfasi(anketID: snapshot.data[index].Anketler[indexAnket].UnicID)));
                                                      },
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
      ),));
  }
}
