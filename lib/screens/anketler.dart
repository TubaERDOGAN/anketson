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
                    padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
                    child: Column(
                      children: [
                        Container(
                          width:MediaQuery.of(context).size.width * 0.8 ,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
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
                                border: InputBorder.none,
                              hintText: 'Search...',
                              hintStyle: TextStyle(
                                color:Colors.white ,

                              ),
                              suffixIcon: IconButton(
                                color:Colors.white ,
                                onPressed: () => setState(() {
                                searchText = "";
                                _textEditingController?.clear();
                            }),
                                icon: Icon(Icons.clear),
                              ),
                               prefixIcon: IconButton(
                                 color:Colors.white ,
                                 icon: Icon(Icons.search),
                                 onPressed: (){},
                               )
                            ),
                          ),
                        ),


                        Container(
                            height: MediaQuery.of(context).size.height * 0.75,
                            //color: Colors.tealAccent,
                            child:ListView.separated(
                            separatorBuilder: (BuildContext context, int index) => SizedBox(
                              height: MediaQuery.of(context).size.height * 0.013,
                            ),
                            itemCount: _textEditingController!.text.isNotEmpty ?snapshot.data!.length:snapshot.data.length,
                            itemBuilder: (ctx, index) => Center(child:Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                child:Container(child:Column(children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
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
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,

      body:NestedScrollView(
      floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
      SliverAppBar(
        expandedHeight: 35,
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
                  icon: Icon(
                      Icons.arrow_back_outlined
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ));
          },
        ),
        actions: <Widget>[],
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
                          Color(0xff8f9d97),
                          Color(0xff919a94),
                          Color(0xffc45d54)
                        ],
                        stops: [0.0, 0.402, 1.0],
                      ),
                    ),
                  ),
                Pinned.fromPins(
                  Pin(start: -243.2, end: -143.0),
                  Pin(size: 716.5, start: -327.5),
                  child: SvgPicture.string(
                    _svg_xp7tu,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                /*
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
                                                      fit: BoxFit.cover,
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
 */

                Container(
                  color: Color(0x66ffffff),
                  child: Center(
                    child: Text(
                      'Çok yakında...',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ]

          ),
      )
      ),);
  }
}
const String _svg_xp7tu =
    '<svg viewBox="-243.2 -327.5 779.2 716.5" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 536.04, 219.47)" d="M 1.024306038743816e-05 184.1095581054688 C 7.517889116570586e-06 285.7896118164062 100.297233581543 368.2178955078125 224.0208892822266 368.2178955078125 C 274.1476745605469 368.2178649902344 320.4256591796875 354.6895446777344 357.7494201660156 331.8302612304688 C 352.7652893066406 349.4608764648438 350.0668640136719 368.312255859375 350.0668640136719 387.898193359375 C 350.0668640136719 486.4231567382812 418.3290100097656 566.2928466796875 502.5333862304688 566.2928466796875 C 586.7387084960938 566.2928466796875 654.9998779296875 486.4231262207031 654.9998779296875 387.898193359375 C 654.9998779296875 289.3731994628906 586.7387084960938 209.5035095214844 502.5333862304688 209.5035095214844 C 481.3537902832031 209.5035400390625 461.1823120117188 214.5567932128906 442.8525085449219 223.688720703125 C 446.2498474121094 210.9415893554688 448.0417785644531 197.694580078125 448.0417785644531 184.1095581054688 C 448.0417785644531 82.4283447265625 347.7445373535156 6.103515625e-05 224.0209045410156 6.103515625e-05 C 100.2972412109375 6.103515625e-05 1.296826212637825e-05 82.4283447265625 1.024306038743816e-05 184.1095581054688 Z" fill="#c45d54" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';


const String _svg_ahsnb9 =
    '<svg viewBox="-243.2 -327.5 779.2 716.5" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 536.04, 219.47)" d="M 1.024306038743816e-05 184.1095581054688 C 7.517889116570586e-06 285.7896118164062 100.297233581543 368.2178955078125 224.0208892822266 368.2178955078125 C 274.1476745605469 368.2178649902344 320.4256591796875 354.6895446777344 357.7494201660156 331.8302612304688 C 352.7652893066406 349.4608764648438 350.0668640136719 368.312255859375 350.0668640136719 387.898193359375 C 350.0668640136719 486.4231567382812 418.3290100097656 566.2928466796875 502.5333862304688 566.2928466796875 C 586.7387084960938 566.2928466796875 654.9998779296875 486.4231262207031 654.9998779296875 387.898193359375 C 654.9998779296875 289.3731994628906 586.7387084960938 209.5035095214844 502.5333862304688 209.5035095214844 C 481.3537902832031 209.5035400390625 461.1823120117188 214.5567932128906 442.8525085449219 223.688720703125 C 446.2498474121094 210.9415893554688 448.0417785644531 197.694580078125 448.0417785644531 184.1095581054688 C 448.0417785644531 82.4283447265625 347.7445373535156 6.103515625e-05 224.0209045410156 6.103515625e-05 C 100.2972412109375 6.103515625e-05 1.296826212637825e-05 82.4283447265625 1.024306038743816e-05 184.1095581054688 Z" fill="#929a94" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';

const String _svg_dlvr74 =
    '<svg viewBox="100.8 -193.6 453.6 417.1" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 554.44, 124.87)" d="M 1.024306038743816e-05 107.1789855957031 C 8.656608770252205e-06 166.3717956542969 58.38780975341797 214.3572387695312 130.4132537841797 214.3572387695312 C 159.5944366455078 214.3572235107422 186.5350646972656 206.4817352294922 208.2630157470703 193.1742553710938 C 205.3615112304688 203.4378814697266 203.7906188964844 214.4121704101562 203.7906188964844 225.8140716552734 C 203.7906188964844 283.170166015625 243.5292816162109 329.6661071777344 292.5486755371094 329.6661071777344 C 341.568603515625 329.6661071777344 381.3066711425781 283.1701354980469 381.3066711425781 225.8140716552734 C 381.3066711425781 168.4579772949219 341.568603515625 121.9620132446289 292.5486755371094 121.9620132446289 C 280.2190246582031 121.962028503418 268.4762268066406 124.9037704467773 257.8055725097656 130.2199096679688 C 259.7833251953125 122.799186706543 260.8265075683594 115.0874710083008 260.8265075683594 107.1789855957031 C 260.8265075683594 47.98550033569336 202.4386901855469 6.103515625e-05 130.4132537841797 6.103515625e-05 C 58.38781356811523 6.103515625e-05 1.182953019451816e-05 47.98550033569336 1.024306038743816e-05 107.1789855957031 Z" fill="#c45d54" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
