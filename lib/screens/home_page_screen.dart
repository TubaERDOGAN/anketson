import 'dart:convert';

import 'package:ankets/screens/anket_sayfasi.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

class TransactionDetails {
  String? AnketAdi;



  TransactionDetails({
    this.AnketAdi,

  });

  TransactionDetails.fromJson(Map<String, dynamic> json) {
    AnketAdi = json['AnketAdi'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AnketAdi'] = AnketAdi;
    return data;
  }
}

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});



  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {


  @override
  Widget build(BuildContext context) {

    fetchAlbum();

    return Scaffold(
      backgroundColor: const Color(0xffc45d54),
      extendBody: true,
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              card(context),
              card(context),
              card(context),
              card(context),
              card(context),
              card(context),
              card(context),
              card(context),
              card(context),
              card(context),
              card(context),
              card(context),
              card(context),
              card(context),

              Center(
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder()
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget card(BuildContext context){
  return Container(
    width:337.0,
      decoration: const BoxDecoration(
        color: Color(0x66ffffff),
        borderRadius: BorderRadius.all(Radius.circular(21)),
      ),
      child: Column(
        children: [
         ListTile(
            dense: false,
           title: Text(
          "Deprem hakkkında ne kadar bilgilisin ?",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
             textAlign: TextAlign.center,
            ),

            subtitle:ReadMoreText(
          style: TextStyle(
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
          "Türkiye bir deprem ülkesi. En son yaşanılan 7.7 ve 7.5  büyüklüklerindeki Kahramanmaraş depremi aslında alınan önlemlerin yetersiz olduğunu bize gösterdi. Her an yaşanacak bir depremde yapmamız gereken tek bir hareket hayatımızı kurtarabilir. Bu konuda ciddi bir eğitim alınmalı ve bilgi sahibi olunmalıdır. Peki sen bu konuda ne kadar bilgilisin ?",
          textAlign: TextAlign.center,
        ),
      ),
       GestureDetector(child: Container(
         width: 337.0,
         height: 170,
         child: FadeInImage.assetNetwork(
           image:"https://fastly.picsum.photos/id/9/250/250.jpg?hmac=tqDH5wEWHDN76mBIWEPzg1in6egMl49qZeguSaH9_VI",
           placeholder:"lib/assets/icons/menu_icons/anket.png", // your assets image path
           fit: BoxFit.cover,
         ),
         ),
         onTap: () {
           Navigator.push(
               context,
               MaterialPageRoute(
                   builder: (context) =>
                       ExamplePolls()));
         },
       )

  ]));}

  Future<List<TransactionDetails>> fetchAlbum() async {
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

    if (response.statusCode == 200) {
      print(data);
      final List result = json.decode(response.body);
      return result.map((e) => TransactionDetails.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

}



//const String _svg_xyusrl =
    //'<svg viewBox="-82.6 556.3 525.7 496.2" ><path transform="matrix(0.920505, -0.390731, 0.390731, 0.920505, -82.55, 719.49)" d="M 1.024306038743816e-05 117.6346893310547 C 8.505850928486325e-06 182.6019897460938 63.93630218505859 235.2685852050781 142.8061981201172 235.2685852050781 C 174.7604217529297 235.2685699462891 204.2611694335938 226.6248016357422 228.0538940429688 212.0191192626953 C 224.8766632080078 223.2840118408203 223.156494140625 235.3288726806641 223.156494140625 247.8430786132812 C 223.156494140625 310.7944641113281 266.6714477539062 361.8262634277344 320.3490600585938 361.8262634277344 C 374.0272827148438 361.8262634277344 417.5415954589844 310.79443359375 417.5415954589844 247.8430786132812 C 417.5415954589844 184.8916778564453 374.0272827148438 133.85986328125 320.3490600585938 133.85986328125 C 306.8477478027344 133.8598785400391 293.9890747070312 137.0885925292969 282.3043823242188 142.9233551025391 C 284.4700927734375 134.7787017822266 285.6123962402344 126.3146743774414 285.6123962402344 117.6346893310547 C 285.6123962402344 52.66665649414062 221.6760864257812 6.103515261202119e-05 142.8061981201172 6.103515261202119e-05 C 63.93630599975586 6.103515261202119e-05 1.198028985527344e-05 52.66665649414062 1.024306038743816e-05 117.6346893310547 Z" fill="#919b95" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
//const String _svg_db6uhl =
    //'<svg viewBox="28.0 84.0 337.0 42.0" ><path transform="translate(-1617.0, -1039.0)" d="M 1645.000244140625 1164.999633789062 L 1645.000244140625 1143.999877929688 C 1645.000244140625 1132.401611328125 1654.401611328125 1123.000244140625 1666 1123.000244140625 L 1961.000122070312 1123.000244140625 C 1972.598388671875 1123.000244140625 1981.999877929688 1132.401611328125 1981.999877929688 1143.999877929688 L 1981.999877929688 1164.999633789062 L 1645.000244140625 1164.999633789062 Z" fill="#ffffff" fill-opacity="0.7" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
//const String _svg_dlvr74 =
   // '<svg viewBox="100.8 -193.6 453.6 417.1" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 554.44, 124.87)" d="M 1.024306038743816e-05 107.1789855957031 C 8.656608770252205e-06 166.3717956542969 58.38780975341797 214.3572387695312 130.4132537841797 214.3572387695312 C 159.5944366455078 214.3572235107422 186.5350646972656 206.4817352294922 208.2630157470703 193.1742553710938 C 205.3615112304688 203.4378814697266 203.7906188964844 214.4121704101562 203.7906188964844 225.8140716552734 C 203.7906188964844 283.170166015625 243.5292816162109 329.6661071777344 292.5486755371094 329.6661071777344 C 341.568603515625 329.6661071777344 381.3066711425781 283.1701354980469 381.3066711425781 225.8140716552734 C 381.3066711425781 168.4579772949219 341.568603515625 121.9620132446289 292.5486755371094 121.9620132446289 C 280.2190246582031 121.962028503418 268.4762268066406 124.9037704467773 257.8055725097656 130.2199096679688 C 259.7833251953125 122.799186706543 260.8265075683594 115.0874710083008 260.8265075683594 107.1789855957031 C 260.8265075683594 47.98550033569336 202.4386901855469 6.103515625e-05 130.4132537841797 6.103515625e-05 C 58.38781356811523 6.103515625e-05 1.182953019451816e-05 47.98550033569336 1.024306038743816e-05 107.1789855957031 Z" fill="#c45d54" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
