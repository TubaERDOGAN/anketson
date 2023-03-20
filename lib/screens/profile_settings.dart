import 'package:flutter/material.dart';
import '../page/setting_profile_page.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {



  @override
  Widget build(BuildContext context) {

    return Center(
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SettingProfilePage(),
        ),
      ),
    );
  }

}
