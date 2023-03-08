import 'package:ankets/screens/login_page.dart';
import 'package:ankets/screens/profile_settings.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  String _savedText = '';

  @override
  void initState() {
    super.initState();
    _loadSavedText();
  }

  void _loadSavedText() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedText = prefs.getString('username') ?? '';
    });
  }

  void _Cikiss() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('girisyapildi',false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileSettingsTextField(context),
                    customSizedBox1(),
                    BizeUlasinTextField(context),
                    customSizedBox2(),
                    CikisYapTextField(context),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextButton ProfileSettingsTextField(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProfileSettings()));
      },
      child: const Text(
          'Profile Settings'
        //style: const TextStyle(color: Colors.white),
      ),);
  }

  SizedBox customSizedBox1() {
    return const SizedBox(width: 10);
  }

  TextButton BizeUlasinTextField(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (buildContext) {
              return AlertDialog(
                title: Text('Bize ulaşın'),
                content: Text('info@megasoft.com.tr'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Çık'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      // burada çıkış yapılacak işlemler yer alabilir
                    },
                  ),
                  TextButton(
                    child: const Text('Git'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      // burada çıkış yapılacak işlemler yer alabilir
                    },
                  ),

                ],
              );
            }
        );
      },
      child: const Text(
          'Bize Ulaşın'
        //style: const TextStyle(color: Colors.white),
      ),);
  }

  SizedBox customSizedBox2() {
    return const SizedBox(width: 10);
  }

  TextButton CikisYapTextField(BuildContext context) {
    return TextButton(
      onPressed: () {
        _Cikiss();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LoginPage()));
      },
      child: const Text(
          'Çıkış Yap'
      ),
    );
  }
}
