import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:adobe_xd/pinned.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:readmore/readmore.dart';
import '../model/anket.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  Future<List<Anket>> getAnketler() async {
    String url = 'http://172.16.64.200/ANKET/hs/getdata/anketler/';
    Uri urlU = Uri.parse(url);
    Map data = {
      'Username': "tube",
      'Password': "12345678",
    };

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

      for (var row in returnedData["Anketler"]) {
        Anket anket = Anket(
          row["Tarih"],
          row["AnketAdi"],
          "",
        );

        anketler.add(anket);
      }
      return anketler;
    }
    return anketler;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: const Color(0xffc45d54),
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
                Pin(start: 0.0, end: 0.0),
                Pin(size: 164.0, end: 0.0),
                child: SvgPicture.string(
                  _svg_nh01o2,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
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
                       return ListView.builder(
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
                                   child: ,
                                 ),
                                 onTap: () {
                                   Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (context) =>
                                               AnketSayfası()));
                                 },
                               )
                              ],
                            ),
                        )
                   );
                  }
                },
                ),)
        )]
        ));
  }
}

const String _svg_xyusrl =
    '<svg viewBox="-82.6 556.3 525.7 496.2" ><path transform="matrix(0.920505, -0.390731, 0.390731, 0.920505, -82.55, 719.49)" d="M 1.024306038743816e-05 117.6346893310547 C 8.505850928486325e-06 182.6019897460938 63.93630218505859 235.2685852050781 142.8061981201172 235.2685852050781 C 174.7604217529297 235.2685699462891 204.2611694335938 226.6248016357422 228.0538940429688 212.0191192626953 C 224.8766632080078 223.2840118408203 223.156494140625 235.3288726806641 223.156494140625 247.8430786132812 C 223.156494140625 310.7944641113281 266.6714477539062 361.8262634277344 320.3490600585938 361.8262634277344 C 374.0272827148438 361.8262634277344 417.5415954589844 310.79443359375 417.5415954589844 247.8430786132812 C 417.5415954589844 184.8916778564453 374.0272827148438 133.85986328125 320.3490600585938 133.85986328125 C 306.8477478027344 133.8598785400391 293.9890747070312 137.0885925292969 282.3043823242188 142.9233551025391 C 284.4700927734375 134.7787017822266 285.6123962402344 126.3146743774414 285.6123962402344 117.6346893310547 C 285.6123962402344 52.66665649414062 221.6760864257812 6.103515261202119e-05 142.8061981201172 6.103515261202119e-05 C 63.93630599975586 6.103515261202119e-05 1.198028985527344e-05 52.66665649414062 1.024306038743816e-05 117.6346893310547 Z" fill="#919b95" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';

const String _svg_nh01o2 =
    '<svg viewBox="28.0 166.0 337.0 164.0" ><path transform="translate(-1620.0, -1041.0)" d="M 1668.999633789062 1370.999755859375 C 1657.402221679688 1370.999755859375 1648 1361.598388671875 1648 1350 L 1648 1206.999877929688 L 1985.00048828125 1206.999877929688 L 1985.00048828125 1350 C 1985.00048828125 1361.598388671875 1975.59814453125 1370.999755859375 1963.999877929688 1370.999755859375 L 1668.999633789062 1370.999755859375 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';

