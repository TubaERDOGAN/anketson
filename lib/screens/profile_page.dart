import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
   ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String unicID = '';
  String AnketAdedi = '0';
  String TestAdedi = '0';
  String username = '';
  String email = "";
  File? imageFile = null;


  @override
  void initState() {
    _GetInfo();
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    unicID = sharedPreferences.getString("unicID") ?? "";
    username = sharedPreferences.getString("username") ?? "";

    String url = 'http://91.93.203.2:6526/ANKET/hs/getdata/senduserscores/';
    Uri urlU = Uri.parse(url);

    Map data = {
      'UnicID': unicID,
    };
    //encode Map to JSON
    var body = json.encode(data);

    //print(body);

    final response = await http.post(urlU,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    final returnedData = jsonDecode(response.body);

    //print(response.body);

    if (response.statusCode == 200) {
      AnketAdedi = returnedData['AnketAdedi'].toString();
      TestAdedi = returnedData['TestAdedi'].toString();
    }
  }

  Future<void> _GetInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username") ?? "";
      email = prefs.getString("email") ?? "";
      //print(username);
      //print(email);
    });
  }

  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final size = MediaQuery.of(context).size; //getting the size property
    final orientation = MediaQuery.of(context).orientation; //getting the orientation
    final double coverH=MediaQuery.of(context).size.height * 0.2;
    final double profileH=MediaQuery.of(context).size.height * 0.1;
    final top=coverH-profileH;
  _GetInfo();
    getUserData();
    return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return MobilePage();
          } else
          if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
            return MobilePage();
          } else {
            return WebPage();
          }
        });
  }
  SafeArea MobilePage (){
    final double coverH=MediaQuery.of(context).size.height * 0.2;
    final double profileH=MediaQuery.of(context).size.height * 0.075;
    final top=coverH-profileH;
    return SafeArea(child:Scaffold(
      backgroundColor: const Color(0xff919b95),
      appBar:AppBar(
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/settingprofile');
            },
          )
        ],
        title: const Text(
          'Profil Sayfası',
          style:  TextStyle(
            color: const Color(0xffffffff),
            fontFamily: 'Work Sans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),

      ),
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
          Positioned(
              top: MediaQuery.of(context).size.height * 0.0,
              child: Container(
                color: Colors.indigo,
                width:MediaQuery.of(context).size.width * 1,
                child: Image.network('https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
                  height:coverH,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
          ),

          Positioned(
              top: top,
              left: MediaQuery.of(context).size.height * 0.015,
              child: GestureDetector(
                  onTap:() {
                    Navigator.of(context).pushNamed('/settingprofile');
                  },
                  child: CircleAvatar(
                    radius:profileH,
                    backgroundColor:Colors.black,
                    child: CircleAvatar(
                     child: Center(child: Text(username)),
                       backgroundColor: const Color(0xffffffff),
                      radius:MediaQuery.of(context).size.height * 0.070,
                ),
              )),
          ),
          Positioned(
           top:MediaQuery.of(context).size.height * 0.30,
              left: MediaQuery.of(context).size.height * 0.020,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                child: Row(
                  children: [
                    Text(username,
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 24,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w600,
                    ),),
                    SizedBox(width: 10),
                    Icon(
                      Icons.lock,
                    )
                  ],
                )
          )),
          Positioned(
              top:MediaQuery.of(context).size.height * 0.35,
              left: MediaQuery.of(context).size.height * 0.030,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Row(
                    children: [
                      Text(email,
                        style: TextStyle(
                          fontFamily: 'Work Sans',
                          fontSize: 16,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
              )),

          Positioned(
              top:MediaQuery.of(context).size.height * 0.40,
              left: MediaQuery.of(context).size.height * 0.020,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Row(
                    children: [
                      Container(child:Row(children: [
                        Text('Çözülen test:'),

                        Text(TestAdedi),

                      ]),),
                      SizedBox(
                        width: 25,
                      ),
                      Container(child:Row(children: [
                        Text('Cevaplanan anket:'),

                        Text(AnketAdedi),

                      ]),),
                    ],
                  )
              )),
        ],
      ),
    ));
  }


  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        Uint8List? cimage = imageFile?.readAsBytesSync();
        String img64 = base64Encode(cimage!);
        print(img64);
      });
    }
  }
  /// Web kısmı
  SafeArea WebPage (){
    return SafeArea(child:Scaffold(
      backgroundColor: const Color(0xff919b95),
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

        ],
      ),
    ));
  }

}

const String _svg_dlvr74 =
    '<svg viewBox="100.8 -193.6 453.6 417.1" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 554.44, 124.87)" d="M 1.024306038743816e-05 107.1789855957031 C 8.656608770252205e-06 166.3717956542969 58.38780975341797 214.3572387695312 130.4132537841797 214.3572387695312 C 159.5944366455078 214.3572235107422 186.5350646972656 206.4817352294922 208.2630157470703 193.1742553710938 C 205.3615112304688 203.4378814697266 203.7906188964844 214.4121704101562 203.7906188964844 225.8140716552734 C 203.7906188964844 283.170166015625 243.5292816162109 329.6661071777344 292.5486755371094 329.6661071777344 C 341.568603515625 329.6661071777344 381.3066711425781 283.1701354980469 381.3066711425781 225.8140716552734 C 381.3066711425781 168.4579772949219 341.568603515625 121.9620132446289 292.5486755371094 121.9620132446289 C 280.2190246582031 121.962028503418 268.4762268066406 124.9037704467773 257.8055725097656 130.2199096679688 C 259.7833251953125 122.799186706543 260.8265075683594 115.0874710083008 260.8265075683594 107.1789855957031 C 260.8265075683594 47.98550033569336 202.4386901855469 6.103515625e-05 130.4132537841797 6.103515625e-05 C 58.38781356811523 6.103515625e-05 1.182953019451816e-05 47.98550033569336 1.024306038743816e-05 107.1789855957031 Z" fill="#c45d54" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';

const String _svg_ahsnb9 =
    '<svg viewBox="-243.2 -327.5 779.2 716.5" ><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, 536.04, 219.47)" d="M 1.024306038743816e-05 184.1095581054688 C 7.517889116570586e-06 285.7896118164062 100.297233581543 368.2178955078125 224.0208892822266 368.2178955078125 C 274.1476745605469 368.2178649902344 320.4256591796875 354.6895446777344 357.7494201660156 331.8302612304688 C 352.7652893066406 349.4608764648438 350.0668640136719 368.312255859375 350.0668640136719 387.898193359375 C 350.0668640136719 486.4231567382812 418.3290100097656 566.2928466796875 502.5333862304688 566.2928466796875 C 586.7387084960938 566.2928466796875 654.9998779296875 486.4231262207031 654.9998779296875 387.898193359375 C 654.9998779296875 289.3731994628906 586.7387084960938 209.5035095214844 502.5333862304688 209.5035095214844 C 481.3537902832031 209.5035400390625 461.1823120117188 214.5567932128906 442.8525085449219 223.688720703125 C 446.2498474121094 210.9415893554688 448.0417785644531 197.694580078125 448.0417785644531 184.1095581054688 C 448.0417785644531 82.4283447265625 347.7445373535156 6.103515625e-05 224.0209045410156 6.103515625e-05 C 100.2972412109375 6.103515625e-05 1.296826212637825e-05 82.4283447265625 1.024306038743816e-05 184.1095581054688 Z" fill="#929a94" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
