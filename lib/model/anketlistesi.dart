import 'package:flutter/material.dart';
import 'anket.dart';
import 'anketlistesisatiri.dart';

class AnketListesi extends StatelessWidget {

  final List<Anket> anketler;

  AnketListesi({Key? key, required this.anketler});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: anketler.length,
      itemBuilder: (context, index) {
        return AnketSatiri(item: anketler[index]);
      },
    );
  }

}