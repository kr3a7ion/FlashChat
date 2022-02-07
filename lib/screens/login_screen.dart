import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/resuseable_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your Email',
                  )),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  obscuringCharacter: '*',
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your Password',
                  )),
              const SizedBox(
                height: 24.0,
              ),
              ReuseableButton(
                buttonText: 'Log In',
                myColor: Colors.lightBlueAccent,
                onTap: () async {
                  if (email != null || password != null) {
                    setState(() {
                      showSpinner = true;
                    });
                  }
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email!, password: password!);
                    email = null;
                    password = null;

                    // ignore: unnecessary_null_comparison
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  } catch (e) {
                    Exception(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
