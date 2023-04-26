import 'dart:convert';
import 'package:ankets/screens/anket_sayfasi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:adobe_xd/pinned.dart';
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

    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/anketler/';
    Uri urlU = Uri.parse(url);
    Map data = {
      'Username': username,
      'UnicID': unicId,
    };

    //print(data);

    //encode Map to JSON
    var body = json.encode(data);

    final response = await http.post(urlU,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    final returnedData = jsonDecode(utf8.decode(response.bodyBytes));
    List<Anket>anketler = [];
    if (response.statusCode == 200) {
      //print(returnedData["Anketler"]);
      for (var row in returnedData["Anketler"]) {
        Anket anket = Anket(
          row["Tarih"],
          row["AnketAdi"],
          row["ImageUrl"],
          row["UnicID"],
          row["OnizlemeAciklamasi"],
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
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffffffff),
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

              Pinned.fromPins(
                Pin(start: -243.2, end: -143.0),
                Pin(size: 716.5, start: -327.5),
                child: SvgPicture.string(
                  _svg_xp7tu,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
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
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                color: const Color(0x66ffffff),
                                borderRadius:
                                BorderRadius.circular(5.0),
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
                                  subtitle: ReadMoreText(snapshot.data[index].OnizlemeAciklamasi,
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
                                        height:MediaQuery.of(context).size.height * 0.2,
                                        width: MediaQuery.of(context).size.width * 85,
                                        child:Image.network(snapshot.data[index].ImageUrl,fit: BoxFit.fill)
                                    ),
                                    onTap: () {
                                      print(snapshot.data[index].UnicID);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AnketSayfasi(anketID: snapshot.data[index].UnicID)));
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


const String _svg_ahsnb9 =
    '<svg viewBox="-243.2 -327.5 779.2 716.5" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 536.04, 219.47)" d="M 1.024306038743816e-05 184.1095581054688 C 7.517889116570586e-06 285.7896118164062 100.297233581543 368.2178955078125 224.0208892822266 368.2178955078125 C 274.1476745605469 368.2178649902344 320.4256591796875 354.6895446777344 357.7494201660156 331.8302612304688 C 352.7652893066406 349.4608764648438 350.0668640136719 368.312255859375 350.0668640136719 387.898193359375 C 350.0668640136719 486.4231567382812 418.3290100097656 566.2928466796875 502.5333862304688 566.2928466796875 C 586.7387084960938 566.2928466796875 654.9998779296875 486.4231262207031 654.9998779296875 387.898193359375 C 654.9998779296875 289.3731994628906 586.7387084960938 209.5035095214844 502.5333862304688 209.5035095214844 C 481.3537902832031 209.5035400390625 461.1823120117188 214.5567932128906 442.8525085449219 223.688720703125 C 446.2498474121094 210.9415893554688 448.0417785644531 197.694580078125 448.0417785644531 184.1095581054688 C 448.0417785644531 82.4283447265625 347.7445373535156 6.103515625e-05 224.0209045410156 6.103515625e-05 C 100.2972412109375 6.103515625e-05 1.296826212637825e-05 82.4283447265625 1.024306038743816e-05 184.1095581054688 Z" fill="#929a94" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';


const String _svg_xp7tu =
    '<svg viewBox="-243.2 -327.5 779.2 716.5" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 536.04, 219.47)" d="M 1.024306038743816e-05 184.1095581054688 C 7.517889116570586e-06 285.7896118164062 100.297233581543 368.2178955078125 224.0208892822266 368.2178955078125 C 274.1476745605469 368.2178649902344 320.4256591796875 354.6895446777344 357.7494201660156 331.8302612304688 C 352.7652893066406 349.4608764648438 350.0668640136719 368.312255859375 350.0668640136719 387.898193359375 C 350.0668640136719 486.4231567382812 418.3290100097656 566.2928466796875 502.5333862304688 566.2928466796875 C 586.7387084960938 566.2928466796875 654.9998779296875 486.4231262207031 654.9998779296875 387.898193359375 C 654.9998779296875 289.3731994628906 586.7387084960938 209.5035095214844 502.5333862304688 209.5035095214844 C 481.3537902832031 209.5035400390625 461.1823120117188 214.5567932128906 442.8525085449219 223.688720703125 C 446.2498474121094 210.9415893554688 448.0417785644531 197.694580078125 448.0417785644531 184.1095581054688 C 448.0417785644531 82.4283447265625 347.7445373535156 6.103515625e-05 224.0209045410156 6.103515625e-05 C 100.2972412109375 6.103515625e-05 1.296826212637825e-05 82.4283447265625 1.024306038743816e-05 184.1095581054688 Z" fill="#c45d54" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
