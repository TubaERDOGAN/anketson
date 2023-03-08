import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../page/setting_profile_page.dart';
import '../utils/user_preferences.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  static final String title = 'User Profile';


  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    return Center(
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          home: SettingProfilePage(),
        ),
      ),
    );
  }

}
