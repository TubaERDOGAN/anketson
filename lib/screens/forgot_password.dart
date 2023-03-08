import 'package:flutter/material.dart';
import 'package:ankets/screens/verify_number_page.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class   _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Password Reset")),
        ),
        body:forgotPassword()
    );
  }
}

class forgotPassword extends StatefulWidget {
  const forgotPassword({Key? key}) : super(key: key);

  @override
  State<forgotPassword> createState() => _forgotPasswordState();

}

class _forgotPasswordState extends State<forgotPassword> {

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
          child: TextField(
            obscureText: true,
            controller: emailController,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                size: 15,

              ),

              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: Colors.grey
                ),
              ),
              labelText: 'E-Mail',
            ),
          ),
        ),
        Container(


            height: 50,
            margin: const EdgeInsets.only(top: 80.0),
            padding: const EdgeInsets.fromLTRB(21.5, 0, 21.5, 0),
            child: ElevatedButton(

              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),

                  ),

                ),
              ),

              child: const Text('Send Verify Number'),
              onPressed: () {

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const VerifyNumberPage()));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Control Your E-Mail address"),
                ));
                },
            )

        ),

        Expanded(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: MaterialButton(
              onPressed: () => {},
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(child: const Text('Create Your Account'),
                      onPressed: () {

                      },
                    )
                  ]
              ),
            ),
          ),
        ),
      ],
    );
  }
}

