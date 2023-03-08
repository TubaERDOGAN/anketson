import 'package:flutter/material.dart';
import 'anket.dart';

class AnketSatiri extends StatelessWidget {
  AnketSatiri({required this.item});

  final Anket item;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 140,
        child: Card(
          elevation: 5,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.network(
                  this.item.imgUrl,
                  width: 200,
                ),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.AnketAdi,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("id:${this.item.id}"),
                          ],
                        )))
              ]),
        ));
  }
}