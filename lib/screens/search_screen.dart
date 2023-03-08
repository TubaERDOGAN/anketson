import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as ui;
import 'package:search_page/search_page.dart';

class SearchItem implements Comparable<SearchItem> {
  final String category, type;
  const SearchItem(this.category, this.type);

  @override
  int compareTo(SearchItem other) => category.compareTo(other.category);
}

class SearchScreen extends StatelessWidget {
  static const SearchItems = [
    SearchItem('İlişki', 'Test'),
    SearchItem('Psikoloji', 'Test'),
    SearchItem('Astroloji', 'Test'),
    SearchItem('Yemek', 'Test'),
    SearchItem('Kişilik', 'Test'),
    SearchItem('Genel Kültür', 'Test'),
    SearchItem('Seçim 2023', 'Anket'),
  ];
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffc45d54),
      body: Stack(
        children: [
          Pinned.fromPins(
            //Alttaki gri şekil
            Pin(start: -82.6, end: -50.2),
            Pin(size: 496.2, end: -200.6),
            child: SvgPicture.string(
              _svg_xyusrl,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            //alt barın arkasındaki kırmızı kutu
            Pin(start: 0.0, end: 0.0),
            Pin(size: 73.0, end: 0.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xffc45d54),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(23.0),
                  topRight: Radius.circular(23.0),
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            //sağ üstteki arama simgesi
              Pin(size: 25.5, end: 30.9),
              Pin(size: 20.5, start: 24.0),
              child: const ButtonBar(
                children: [Icon(Icons.search, color: Colors.white, size: 35)],
              )),
          Pinned.fromPins(
            //Aramanı buraya yazın arkasındaki beyaz dikdörtgen
            Pin(start: 57.0, end: 57.0),
            Pin(size: 39.0, start: 30.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xc7ffffff),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    offset: Offset(3, 3),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () => showSearch(
                  context: context,
                  delegate: SearchPage(
                    onQueryUpdate: print,
                    items: SearchItems,
                    searchLabel: 'Aramanı buraya yaz...',
                    suggestion: const Center(
                      child: Text('Ne arıyorsunuz ?'),
                    ),
                    failure: const Center(
                      child: Text(
                          'Aramanızla eşleşen bir içerik bulamadık :(\n     Başka bir şey denemeye ne dersiniz ?'),
                    ),
                    filter: (SearchItem) => [
                      SearchItem.category,
                      SearchItem.type,
                    ],
                    sort: (a, b) => a.compareTo(b),
                    builder: (SearchItem) => ListTile(
                      title: Text(SearchItem.category),
                      subtitle: Text(SearchItem.type),
                    ),
                  ),
                ),
                child: const Text(
                  'Aramanı buraya yaz...',
                  style: TextStyle(
                    fontFamily: 'Work Sans',
                    fontSize: 18,
                    color: Color(0xff929292),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            ),

          ),

          Pinned.fromPins(
            //İlişkinin arasındaki kutu
            Pin(size: 163.0, start: 26.0),
            Pin(size: 114.0, start: 105.0),
            child: ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 24.0, sigmaY: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0x66ffffff),
                    borderRadius: BorderRadius.circular(21.0),
                  ),
                  child: const Center(
                    child: Text(
                      'İlişki',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 18,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            //Psikolojinin arkasındaki kutu
            Pin(size: 163.0, end: 26.0),
            Pin(size: 114.0, start: 105.0),
            child: ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 24.0, sigmaY: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0x66ffffff),
                    borderRadius: BorderRadius.circular(21.0),
                  ),
                  child: const Center(
                    child: Text(
                      'Psikoloji',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 18,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            //Astrolojinin arkasındaki kutu
            Pin(size: 163.0, start: 26.0),
            Pin(size: 114.0, middle: 0.325),
            child: ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 24.0, sigmaY: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0x66ffffff),
                    borderRadius: BorderRadius.circular(21.0),
                  ),
                  child: const Center(
                    child: Text(
                      'Astroloji',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 18,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            //Yemeğin arkasındaki kutu
            Pin(size: 163.0, end: 26.0),
            Pin(size: 114.0, middle: 0.325),
            child: ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 24.0, sigmaY: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0x66ffffff),
                    borderRadius: BorderRadius.circular(21.0),
                  ),
                  child: const Center(
                    child: Text(
                      'Yemek',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 18,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            //Kişiliğin arkasındaki kutu
            Pin(size: 163.0, start: 26.0),
            Pin(size: 114.0, middle: 0.500),
            child: ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 24.0, sigmaY: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0x66ffffff),
                    borderRadius: BorderRadius.circular(21.0),
                  ),
                  child: const Center(
                    child: Text(
                      'Kişilik',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 18,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            //Genel kültürün arkasındaki kutu
            Pin(size: 163.0, end: 26.0),
            Pin(size: 114.0, middle: 0.500),
            child: ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 24.0, sigmaY: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0x66ffffff),
                    borderRadius: BorderRadius.circular(21.0),
                  ),
                  child: const Center(
                    child: Text(
                      'Genel Kültür',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 18,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            //Seçim 2023'ün arkasındaki kutu
            Pin(size: 163.0, start: 26.0),
            Pin(size: 114.0, middle: 0.675),
            child: ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 24.0, sigmaY: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0x66ffffff),
                    borderRadius: BorderRadius.circular(21.0),
                  ),
                  child: const Center(
                    child: Text(
                      'Seçim 2023',
                      style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 18,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            //Text
            Pin(size: 196.0, middle: 0.5025),
            Pin(size: 24.0, start: 75.0),
            child: const Text(
              'En Çok İlgi Görenler',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 20,
                color: Color(0xff000000),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          /*
          Pinned.fromPins(
            //Text
            Pin(size: 163.0, start: 26.0),
            Pin(size: 16.0, start: 129.0),
            child: const Text(
              'Test',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 14,
                color: Color(0xff000000),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Pinned.fromPins(
            //Text
            Pin(size: 163.0, start: 26.0),
            Pin(size: 16.0, middle: 0.4629),
            child: const Text(
              'Test',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 14,
                color: Color(0xff000000),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Pinned.fromPins(
            //Text
            Pin(size: 163.0, end: 26.0),
            Pin(size: 16.0, start: 129.0),
            child: const Text(
              'Test',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 14,
                color: Color(0xff000000),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Pinned.fromPins(
            //Text
            Pin(size: 163.0, end: 26.0),
            Pin(size: 16.0, middle: 0.4629),
            child: const Text(
              'Test',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 14,
                color: Color(0xff000000),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Pinned.fromPins(
            //Text
            Pin(size: 163.0, start: 26.0),
            Pin(size: 16.0, middle: 0.3086),
            child: const Text(
              'Test',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 14,
                color: Color(0xff000000),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Pinned.fromPins(
            //Text
            Pin(size: 163.0, start: 26.0),
            Pin(size: 16.0, middle: 0.6172),
            child: const Text(
              'Anket',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 14,
                color: Color(0xff000000),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Pinned.fromPins(
            //Text
            Pin(size: 163.0, end: 26.0),
            Pin(size: 16.0, middle: 0.3086),
            child: const Text(
              'Test',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 14,
                color: Color(0xff000000),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          */
        ],
      ),
    );
  }
}

const String _svg_xyusrl =
    '<svg viewBox="-82.6 556.3 525.7 496.2" ><path transform="matrix(0.920505, -0.390731, 0.390731, 0.920505, -82.55, 719.49)" d="M 1.024306038743816e-05 117.6346893310547 C 8.505850928486325e-06 182.6019897460938 63.93630218505859 235.2685852050781 142.8061981201172 235.2685852050781 C 174.7604217529297 235.2685699462891 204.2611694335938 226.6248016357422 228.0538940429688 212.0191192626953 C 224.8766632080078 223.2840118408203 223.156494140625 235.3288726806641 223.156494140625 247.8430786132812 C 223.156494140625 310.7944641113281 266.6714477539062 361.8262634277344 320.3490600585938 361.8262634277344 C 374.0272827148438 361.8262634277344 417.5415954589844 310.79443359375 417.5415954589844 247.8430786132812 C 417.5415954589844 184.8916778564453 374.0272827148438 133.85986328125 320.3490600585938 133.85986328125 C 306.8477478027344 133.8598785400391 293.9890747070312 137.0885925292969 282.3043823242188 142.9233551025391 C 284.4700927734375 134.7787017822266 285.6123962402344 126.3146743774414 285.6123962402344 117.6346893310547 C 285.6123962402344 52.66665649414062 221.6760864257812 6.103515261202119e-05 142.8061981201172 6.103515261202119e-05 C 63.93630599975586 6.103515261202119e-05 1.198028985527344e-05 52.66665649414062 1.024306038743816e-05 117.6346893310547 Z" fill="#919b95" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';

/*ListView.builder(
  itemCount: SearchItems.length,
  itemBuilder: (context, index) {
  final SearchItem = SearchItems[index];

  return ListTile(
  title: Text(SearchItem.category),
  subtitle: Text(SearchItem.type),
  );
  },
  ),

 */
