import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:adobe_xd/pinned.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnketSayfasi extends StatefulWidget {
  const AnketSayfasi({Key? key}) : super(key: key);

  @override
  State<AnketSayfasi> createState() => _AnketSayfasiState();
}
class _AnketSayfasiState extends State<AnketSayfasi> {

  Future<List<String>> getAnketSorulari(String anketUnicID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String unicId = sharedPreferences.getString("unicID") ?? "";

    String url = 'http://172.16.64.200/ANKET/hs/getdata/anketsorulari/';
    Uri urlU = Uri.parse(url);
    Map data = {
      'UserUnicID': unicId,
      'UnicID': anketUnicID,   //??
    };

    print(data);

    //encode Map to JSON
    var body = json.encode(data);

    final response = await http.post(urlU,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    final returnedData = jsonDecode(response.body);

    List<String>sorular = [];
    //print(returnedData);
    if (response.statusCode == 200) {
      print(returnedData["AnketBilgisi"]["Sorular"]);
      for (var row in returnedData["AnketBilgisi"]["Sorular"]) {
        print(row["Soru"]);
      }
      return sorular;
    }else{
      print("hata");
    }
    return sorular;
  }

  @override
  Widget build(BuildContext context) {

    final data = ModalRoute.of(context)!.settings;
    print(data);
    print(data.arguments.toString());
    getAnketSorulari(data.arguments.toString());

    return Scaffold(
      backgroundColor: const Color(0xffc45d54),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: -82.6, end: -50.2),
            Pin(size: 496.2, end: -200.6),
            child: SvgPicture.string(
              _svg_xyusrl,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 453.6, end: -161.4),
            Pin(size: 417.1, start: -193.6),
            child: SvgPicture.string(
              _svg_dlvr74,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(start: 28.0, end: 28.0),
            Pin(size: 330.0, start: 63.0),
            child: Stack(
              children: <Widget>[
                ClipRect(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 24.0, sigmaY: 24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0x66ffffff),
                        borderRadius: BorderRadius.circular(21.0),
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(size: 129.0, start: 0.0),
                  child: SvgPicture.string(
                    _svg_grf6j,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 196.0, start: 25.0),
                  Pin(size: 16.0, middle: 0.4299),
                  child: Text(
                    'Soru',
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 14,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 19.0, end: 19.0),
                  Pin(size: 30.0, middle: 0.5267),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xc7ffffff),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x14000000),
                          offset: Offset(3, 3),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 19.0, end: 19.0),
                  Pin(size: 30.0, middle: 0.7933),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xc7ffffff),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x14000000),
                          offset: Offset(3, 3),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 19.0, end: 19.0),
                  Pin(size: 30.0, end: 22.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xc7ffffff),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x14000000),
                          offset: Offset(3, 3),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 19.0, end: 19.0),
                  Pin(size: 30.0, middle: 0.66),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xc7ffffff),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x14000000),
                          offset: Offset(3, 3),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 11.0, start: 32.0),
                  Pin(size: 11.0, middle: 0.5266),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 11.0, start: 32.0),
                  Pin(size: 11.0, middle: 0.7774),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 11.0, start: 32.0),
                  Pin(size: 11.0, end: 31.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 11.0, start: 32.0),
                  Pin(size: 11.0, middle: 0.652),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.234, 0.051),
                  child: SizedBox(
                    width: 196.0,
                    height: 14.0,
                    child: Text(
                      'Cevap',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 12,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.234, 0.557),
                  child: SizedBox(
                    width: 196.0,
                    height: 14.0,
                    child: Text(
                      'Cevap',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 12,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 196.0, middle: 0.383),
                  Pin(size: 14.0, end: 30.0),
                  child: Text(
                    'Cevap',
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 12,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.234, 0.304),
                  child: SizedBox(
                    width: 196.0,
                    height: 14.0,
                    child: Text(
                      'Cevap',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 12,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 28.0, end: 28.0),
            Pin(size: 330.0, end: 107.0),
            child: Stack(
              children: <Widget>[
                ClipRect(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 24.0, sigmaY: 24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0x66ffffff),
                        borderRadius: BorderRadius.circular(21.0),
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(size: 129.0, start: 0.0),
                  child: SvgPicture.string(
                    _svg_grf6j,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 196.0, start: 25.0),
                  Pin(size: 16.0, middle: 0.4299),
                  child: Text(
                    'Soru',
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 14,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 19.0, end: 19.0),
                  Pin(size: 30.0, middle: 0.5267),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xc7ffffff),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x14000000),
                          offset: Offset(3, 3),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 19.0, end: 19.0),
                  Pin(size: 30.0, middle: 0.7933),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xc7ffffff),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x14000000),
                          offset: Offset(3, 3),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 19.0, end: 19.0),
                  Pin(size: 30.0, end: 22.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xc7ffffff),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x14000000),
                          offset: Offset(3, 3),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 19.0, end: 19.0),
                  Pin(size: 30.0, middle: 0.66),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xc7ffffff),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x14000000),
                          offset: Offset(3, 3),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 11.0, start: 32.0),
                  Pin(size: 11.0, middle: 0.5266),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 11.0, start: 32.0),
                  Pin(size: 11.0, middle: 0.7774),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 11.0, start: 32.0),
                  Pin(size: 11.0, end: 31.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 11.0, start: 32.0),
                  Pin(size: 11.0, middle: 0.652),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.234, 0.051),
                  child: SizedBox(
                    width: 196.0,
                    height: 14.0,
                    child: Text(
                      'Cevap',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 12,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.234, 0.557),
                  child: SizedBox(
                    width: 196.0,
                    height: 14.0,
                    child: Text(
                      'Cevap',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 12,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 196.0, middle: 0.383),
                  Pin(size: 14.0, end: 30.0),
                  child: Text(
                    'Cevap',
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 12,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.234, 0.304),
                  child: SizedBox(
                    width: 196.0,
                    height: 14.0,
                    child: Text(
                      'Cevap',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 12,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(size: 73.0, end: 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffc45d54),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(23.0),
                  topRight: Radius.circular(23.0),
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 29.3, start: 55.0),
            Pin(size: 27.0, end: 24.0),
            child: SvgPicture.string(
              _svg_l80n1x,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 27.0, middle: 0.3907),
            Pin(size: 27.0, end: 24.0),
            child: SvgPicture.string(
              _svg_sh2xfh,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 24.8, middle: 0.6219),
            Pin(size: 29.3, end: 22.8),
            child: SvgPicture.string(
              _svg_w7tln7,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 29.3, end: 50.7),
            Pin(size: 29.2, end: 22.8),
            child: SvgPicture.string(
              _svg_etf5n7,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 27.0, start: 21.4),
            Pin(size: 18.0, start: 23.5),
            child: SvgPicture.string(
              _svg_s2tbw4,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 196.0, middle: 0.5025),
            Pin(size: 24.0, start: 21.0),
            child: Text(
              'Daily Surveys',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 20,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_xyusrl =
    '<svg viewBox="-82.6 556.3 525.7 496.2" ><path transform="matrix(0.920505, -0.390731, 0.390731, 0.920505, -82.55, 719.49)" d="M 1.024306038743816e-05 117.6346893310547 C 8.505850928486325e-06 182.6019897460938 63.93630218505859 235.2685852050781 142.8061981201172 235.2685852050781 C 174.7604217529297 235.2685699462891 204.2611694335938 226.6248016357422 228.0538940429688 212.0191192626953 C 224.8766632080078 223.2840118408203 223.156494140625 235.3288726806641 223.156494140625 247.8430786132812 C 223.156494140625 310.7944641113281 266.6714477539062 361.8262634277344 320.3490600585938 361.8262634277344 C 374.0272827148438 361.8262634277344 417.5415954589844 310.79443359375 417.5415954589844 247.8430786132812 C 417.5415954589844 184.8916778564453 374.0272827148438 133.85986328125 320.3490600585938 133.85986328125 C 306.8477478027344 133.8598785400391 293.9890747070312 137.0885925292969 282.3043823242188 142.9233551025391 C 284.4700927734375 134.7787017822266 285.6123962402344 126.3146743774414 285.6123962402344 117.6346893310547 C 285.6123962402344 52.66665649414062 221.6760864257812 6.103515261202119e-05 142.8061981201172 6.103515261202119e-05 C 63.93630599975586 6.103515261202119e-05 1.198028985527344e-05 52.66665649414062 1.024306038743816e-05 117.6346893310547 Z" fill="#919b95" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_grf6j =
    '<svg viewBox="28.0 63.0 337.0 129.0" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 365.0, 192.0)" d="M 20.99970054626465 128.9997100830078 C 9.402299880981445 128.9997100830078 0 119.5983047485352 0 108 L 0 0 L 336.9996032714844 0 L 336.9996032714844 108 C 336.9996032714844 119.5983047485352 327.5982055664062 128.9997100830078 315.9999084472656 128.9997100830078 L 20.99970054626465 128.9997100830078 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_dlvr74 =
    '<svg viewBox="100.8 -193.6 453.6 417.1" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 554.44, 124.87)" d="M 1.024306038743816e-05 107.1789855957031 C 8.656608770252205e-06 166.3717956542969 58.38780975341797 214.3572387695312 130.4132537841797 214.3572387695312 C 159.5944366455078 214.3572235107422 186.5350646972656 206.4817352294922 208.2630157470703 193.1742553710938 C 205.3615112304688 203.4378814697266 203.7906188964844 214.4121704101562 203.7906188964844 225.8140716552734 C 203.7906188964844 283.170166015625 243.5292816162109 329.6661071777344 292.5486755371094 329.6661071777344 C 341.568603515625 329.6661071777344 381.3066711425781 283.1701354980469 381.3066711425781 225.8140716552734 C 381.3066711425781 168.4579772949219 341.568603515625 121.9620132446289 292.5486755371094 121.9620132446289 C 280.2190246582031 121.962028503418 268.4762268066406 124.9037704467773 257.8055725097656 130.2199096679688 C 259.7833251953125 122.799186706543 260.8265075683594 115.0874710083008 260.8265075683594 107.1789855957031 C 260.8265075683594 47.98550033569336 202.4386901855469 6.103515625e-05 130.4132537841797 6.103515625e-05 C 58.38781356811523 6.103515625e-05 1.182953019451816e-05 47.98550033569336 1.024306038743816e-05 107.1789855957031 Z" fill="#c45d54" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_l80n1x =
    '<svg viewBox="55.0 801.0 29.3 27.0" ><path transform="translate(51.63, 796.5)" d="M 14.625 31.5 L 14.625 22.5 L 21.375 22.5 L 21.375 31.5 L 28.23749923706055 31.5 L 28.23749923706055 18 L 32.625 18 L 18 4.5 L 3.375 18 L 7.762499809265137 18 L 7.762499809265137 31.5 L 14.625 31.5 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_sh2xfh =
    '<svg viewBox="143.0 801.0 27.0 27.0" ><path transform="translate(138.5, 796.5)" d="M 23.73110198974609 21.47146797180176 L 22.50056266784668 21.47146797180176 L 22.03853988647461 21.08573341369629 C 23.50040626525879 19.31160926818848 24.42368125915527 17.07412338256836 24.42368125915527 14.52860069274902 C 24.42360877990723 8.974124908447266 19.9614372253418 4.5 14.42355442047119 4.5 C 8.961468696594238 4.5 4.5 8.974124908447266 4.5 14.52860164642334 C 4.5 20.08307838439941 8.961468696594238 24.55713272094727 14.50019550323486 24.55713272094727 C 16.96190643310547 24.55713272094727 19.26956176757812 23.63132858276367 21.03862571716309 22.16594505310059 L 21.49994659423828 22.55175018310547 L 21.49994659423828 23.78580474853516 L 29.19234466552734 31.5 L 31.5 29.18573379516602 L 23.73110198974609 21.47146797180176 Z M 14.50019550323486 21.47146797180176 C 10.65396118164062 21.47146797180176 7.57701587677002 18.38566398620605 7.57701587677002 14.52860069274902 C 7.57701587677002 10.6713981628418 10.65396118164062 7.585803985595703 14.50019550323486 7.585803985595703 C 18.34628868103027 7.585803985595703 21.42330551147461 10.6713981628418 21.42330551147461 14.52860069274902 C 21.42330551147461 18.38566398620605 18.34628868103027 21.47146797180176 14.50019550323486 21.47146797180176 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_w7tln7 =
    '<svg viewBox="229.0 800.0 24.8 29.3" ><path transform="translate(223.38, 796.63)" d="M 18 32.625 C 19.60164833068848 32.625 20.91171073913574 31.3088207244873 20.91171073913574 29.70000076293945 L 15.08821868896484 29.70000076293945 C 15.08821868896484 31.3088207244873 16.39835166931152 32.625 18 32.625 Z M 27.46328926086426 23.85000038146973 L 27.46328926086426 15.80624961853027 C 27.46328926086426 11.34562492370605 24.3332576751709 7.543265342712402 20.18383598327637 6.592429161071777 L 20.18383598327637 5.568749904632568 C 20.18383598327637 4.325484275817871 19.23764038085938 3.375 18 3.375 C 16.76235961914062 3.375 15.81616401672363 4.325484275817871 15.81616401672363 5.568749904632568 L 15.81616401672363 6.592429637908936 C 11.66667175292969 7.543265342712402 8.536710739135742 11.34562492370605 8.536710739135742 15.80624961853027 L 8.536710739135742 23.84999847412109 L 5.625 26.77499961853027 L 5.625 28.23749923706055 L 30.375 28.23749923706055 L 30.375 26.77499961853027 L 27.46328926086426 23.85000038146973 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_etf5n7 =
    '<svg viewBox="313.0 800.0 29.3 29.2" ><path transform="translate(309.63, 796.62)" d="M 29.10705375671387 19.46249961853027 C 29.18158531188965 19.02410125732422 29.18158531188965 18.51201438903809 29.18158531188965 18 C 29.18158531188965 17.48798561096191 29.10705375671387 17.04951477050781 29.10705375671387 16.53750038146973 L 32.24770355224609 14.12451553344727 C 32.54723358154297 13.90528106689453 32.62169647216797 13.53972625732422 32.39746856689453 13.17403125762939 L 29.40574264526367 8.128125190734863 C 29.25604820251465 7.835343837738037 28.80759429931641 7.689726829528809 28.5080623626709 7.835343837738037 L 24.7684211730957 9.297914505004883 C 24.02043724060059 8.713054656982422 23.12353134155273 8.200969696044922 22.22592163085938 7.835344314575195 L 21.70223426818848 3.959930181503296 C 21.6277027130127 3.66785192489624 21.3282413482666 3.375070810317993 20.95425033569336 3.375070810317993 L 14.97079658508301 3.375070810317993 C 14.59687423706055 3.375070810317993 14.29741382598877 3.667852163314819 14.22288227081299 3.959930181503296 L 13.62466335296631 7.835344314575195 C 12.72698402404785 8.200969696044922 11.90453815460205 8.712985038757324 11.08139038085938 9.297914505004883 L 7.341749668121338 7.835344314575195 C 6.967757701873779 7.689727306365967 6.593765258789062 7.835344314575195 6.444069862365723 8.128125190734863 L 3.452343225479126 13.17410182952881 C 3.303350925445557 13.46610927581787 3.377741575241089 13.90528106689453 3.602038621902466 14.12458610534668 L 6.818202972412109 16.53750038146973 C 6.818202972412109 17.04951667785645 6.743671894073486 17.48798561096191 6.743671894073486 18 C 6.743671894073486 18.51201438903809 6.818202972412109 18.95048522949219 6.818202972412109 19.46249961853027 L 3.677484273910522 21.87548446655273 C 3.377953052520752 22.09471893310547 3.30356240272522 22.46027374267578 3.527718544006348 22.82596969604492 L 6.519445419311523 27.87187576293945 C 6.669210910797119 28.16465759277344 7.117664337158203 28.31027412414551 7.417125225067139 28.16465759277344 L 11.15683650970459 26.70208740234375 C 11.90475082397461 27.28694725036621 12.80172729492188 27.79903221130371 13.69933700561523 28.16465759277344 L 14.29755592346191 32.04007339477539 C 14.37271976470947 32.40569686889648 14.67147827148438 32.62493133544922 15.04547023773193 32.62493133544922 L 21.02892303466797 32.62493133544922 C 21.40291595458984 32.62493133544922 21.7023754119873 32.33214950561523 21.77690696716309 32.04007339477539 L 22.37582969665527 28.16465950012207 C 23.27280616760254 27.79903411865234 24.09595489501953 27.28701972961426 24.9183292388916 26.70208930969238 L 28.65804100036621 28.16465950012207 C 29.03196334838867 28.31027603149414 29.40595436096191 28.16465950012207 29.55572128295898 27.87187767028809 L 32.54744720458984 22.82590103149414 C 32.6971435546875 22.53389358520508 32.62197875976562 22.0947208404541 32.39768218994141 21.87541580200195 L 29.10705375671387 19.46249961853027 Z M 17.96259307861328 23.11874961853027 C 15.04539775848389 23.11874961853027 12.72712421417236 20.85222625732422 12.72712421417236 18 C 12.72712421417236 15.14777374267578 15.04539775848389 12.88125038146973 17.96259307861328 12.88125038146973 C 20.87978744506836 12.88125038146973 23.1981315612793 15.14777374267578 23.1981315612793 18 C 23.1981315612793 20.85222625732422 20.87978935241699 23.11874961853027 17.96259307861328 23.11874961853027 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_s2tbw4 =
    '<svg viewBox="21.4 23.5 27.0 18.0" ><path transform="translate(16.9, 14.5)" d="M 4.5 27 L 31.5 27 L 31.5 24.00004768371582 L 4.5 24.00004768371582 L 4.5 27 Z M 4.5 19.50004768371582 L 31.5 19.50004768371582 L 31.5 16.50002479553223 L 4.5 16.50002479553223 L 4.5 19.50004768371582 Z M 4.5 9 L 4.5 11.99988269805908 L 31.5 11.99988269805908 L 31.5 9 L 4.5 9 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
