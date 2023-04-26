import 'dart:convert';
import 'package:adobe_xd/pinned.dart';
import 'package:ankets/model/test.dart';
import 'package:ankets/screens/test_sayfasi.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestKategorileri extends StatelessWidget {
  final String kategoriTanim;

  TestKategorileri({Key? key, required this.kategoriTanim}) : super(key: key);
  Future<List<Test>> getTestler() async {
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
    final returnedData = jsonDecode(utf8.decode(response.bodyBytes));
    //print(returnedData);
    List<Test> testler = [];
    if (response.statusCode == 200) {
      if(kategoriTanim != "") {
        for (var row in returnedData["KategorilerVeTestler"]) {
          if(kategoriTanim == row["Tanim"]) {
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
          }
        }
      }
      return testler;
    }else{
      print("hata");
      return testler;
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
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
                'Kategoriler',
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
              /* actions: <Widget>[
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
              ],*/
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
                Center(
                    child: FutureBuilder(
                        future: getTestler(),
                        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            return Padding(padding:EdgeInsets.fromLTRB(12, 0, 12, 10),
                                child: AnimationLimiter(
                                    child:ListView.separated(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (ctx, index) =>AnimationConfiguration.staggeredList(
                                        position: index,
                                        duration: const Duration(milliseconds: 375),
                                        child: SlideAnimation(
                                          verticalOffset: 50.0,
                                          child: FadeInAnimation(
                                            child: Container(
                                              width: MediaQuery.of(context).size.width * 85,
                                              decoration: BoxDecoration(
                                                color: const Color(0x66ffffff),
                                                borderRadius:
                                                BorderRadius.circular(5.0),
                                              ),
                                              child: Column(
                                                children: [ListTile(
                                                  title: Text(
                                                    snapshot.data[index].TestAdi,
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
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TestSayfasi(TestID: snapshot.data[index].UnicID)));
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ), separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 10,); },
                                    )));
                          }
                        }
                    )
                )
              ]
          )
      ),));
  }

}


const String _svg_xp7tu =
    '<svg viewBox="-243.2 -327.5 779.2 716.5" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 536.04, 219.47)" d="M 1.024306038743816e-05 184.1095581054688 C 7.517889116570586e-06 285.7896118164062 100.297233581543 368.2178955078125 224.0208892822266 368.2178955078125 C 274.1476745605469 368.2178649902344 320.4256591796875 354.6895446777344 357.7494201660156 331.8302612304688 C 352.7652893066406 349.4608764648438 350.0668640136719 368.312255859375 350.0668640136719 387.898193359375 C 350.0668640136719 486.4231567382812 418.3290100097656 566.2928466796875 502.5333862304688 566.2928466796875 C 586.7387084960938 566.2928466796875 654.9998779296875 486.4231262207031 654.9998779296875 387.898193359375 C 654.9998779296875 289.3731994628906 586.7387084960938 209.5035095214844 502.5333862304688 209.5035095214844 C 481.3537902832031 209.5035400390625 461.1823120117188 214.5567932128906 442.8525085449219 223.688720703125 C 446.2498474121094 210.9415893554688 448.0417785644531 197.694580078125 448.0417785644531 184.1095581054688 C 448.0417785644531 82.4283447265625 347.7445373535156 6.103515625e-05 224.0209045410156 6.103515625e-05 C 100.2972412109375 6.103515625e-05 1.296826212637825e-05 82.4283447265625 1.024306038743816e-05 184.1095581054688 Z" fill="#c45d54" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';


const String _svg_ahsnb9 =
    '<svg viewBox="-243.2 -327.5 779.2 716.5" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 536.04, 219.47)" d="M 1.024306038743816e-05 184.1095581054688 C 7.517889116570586e-06 285.7896118164062 100.297233581543 368.2178955078125 224.0208892822266 368.2178955078125 C 274.1476745605469 368.2178649902344 320.4256591796875 354.6895446777344 357.7494201660156 331.8302612304688 C 352.7652893066406 349.4608764648438 350.0668640136719 368.312255859375 350.0668640136719 387.898193359375 C 350.0668640136719 486.4231567382812 418.3290100097656 566.2928466796875 502.5333862304688 566.2928466796875 C 586.7387084960938 566.2928466796875 654.9998779296875 486.4231262207031 654.9998779296875 387.898193359375 C 654.9998779296875 289.3731994628906 586.7387084960938 209.5035095214844 502.5333862304688 209.5035095214844 C 481.3537902832031 209.5035400390625 461.1823120117188 214.5567932128906 442.8525085449219 223.688720703125 C 446.2498474121094 210.9415893554688 448.0417785644531 197.694580078125 448.0417785644531 184.1095581054688 C 448.0417785644531 82.4283447265625 347.7445373535156 6.103515625e-05 224.0209045410156 6.103515625e-05 C 100.2972412109375 6.103515625e-05 1.296826212637825e-05 82.4283447265625 1.024306038743816e-05 184.1095581054688 Z" fill="#929a94" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';

const String _svg_dlvr74 =
    '<svg viewBox="100.8 -193.6 453.6 417.1" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 554.44, 124.87)" d="M 1.024306038743816e-05 107.1789855957031 C 8.656608770252205e-06 166.3717956542969 58.38780975341797 214.3572387695312 130.4132537841797 214.3572387695312 C 159.5944366455078 214.3572235107422 186.5350646972656 206.4817352294922 208.2630157470703 193.1742553710938 C 205.3615112304688 203.4378814697266 203.7906188964844 214.4121704101562 203.7906188964844 225.8140716552734 C 203.7906188964844 283.170166015625 243.5292816162109 329.6661071777344 292.5486755371094 329.6661071777344 C 341.568603515625 329.6661071777344 381.3066711425781 283.1701354980469 381.3066711425781 225.8140716552734 C 381.3066711425781 168.4579772949219 341.568603515625 121.9620132446289 292.5486755371094 121.9620132446289 C 280.2190246582031 121.962028503418 268.4762268066406 124.9037704467773 257.8055725097656 130.2199096679688 C 259.7833251953125 122.799186706543 260.8265075683594 115.0874710083008 260.8265075683594 107.1789855957031 C 260.8265075683594 47.98550033569336 202.4386901855469 6.103515625e-05 130.4132537841797 6.103515625e-05 C 58.38781356811523 6.103515625e-05 1.182953019451816e-05 47.98550033569336 1.024306038743816e-05 107.1789855957031 Z" fill="#c45d54" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
