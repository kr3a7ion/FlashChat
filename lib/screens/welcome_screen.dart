// ignore_for_file: avoid_print

import 'package:flash_chat/components/resuseable_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'welcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;
  Animation? animation2;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = CurvedAnimation(parent: controller!, curve: Curves.bounceInOut);
    animation2 = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller!);

    controller?.forward();
    controller?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation2!.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    child: Image.asset('images/logo.png'),
                    height: animation!.value * 100,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      textStyle: const TextStyle(
                        color: Colors.black54,
                        fontSize: 35.0,
                        fontWeight: FontWeight.w900,
                      ),
                      speed: const Duration(milliseconds: 80),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            ReuseableButton(
              myColor: Colors.lightBlueAccent,
              onTap: () => Navigator.pushNamed(context, LoginScreen.id),
              buttonText: 'Log In',
            ),
            ReuseableButton(
              myColor: Colors.blueAccent,
              onTap: () => Navigator.pushNamed(context, RegistrationScreen.id),
              buttonText: 'Register',
            ),
            
          ],
        ),
      ),
    );
  }
}
