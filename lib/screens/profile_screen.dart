import 'package:flutter/material.dart';
import 'package:ankets/screens/profile_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static final String title = 'User Profile';


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          home:  ProfilePage(),
        ),
      ),
    );
  }

}
