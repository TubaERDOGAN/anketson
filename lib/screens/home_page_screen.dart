import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/anket.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  Future<List<Anket>> getAnketler() async {
    String url = 'http://172.16.64.200/ANKET/hs/getdata/checkuser/';
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

    List<Anket> anketler = [];

    if (response.statusCode == 200) {
      for (var anketverisi in returnedData.Anketler) {
        Anket anket = Anket(
            anketverisi["UnicID"], anketverisi["AnketAdi"], "https://yt3.ggpht.com/ukCrRkXonAVl29DJoIiDfasQ9Kvic5jV-ZLR5Osmnnqs5KyQEjvOyO-3MOb2aFR2hHgInrV_LA=s48-c-k-c0x00ffffff-no-rj");

        //Adding user to the list.
        anketler.add(anket);
      }
    }
    return anketler;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: const Color(0xffc45d54),
        extendBody: true,
        body:Center(
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
                  itemBuilder: (ctx, index) => ListTile(
                    title: Text(snapshot.data[index].title),
                    subtitle: Text(snapshot.data[index].body),
                    contentPadding: EdgeInsets.only(bottom: 20.0),
                  ),
                );
              }
            },
          ),
        ));
  }
}




