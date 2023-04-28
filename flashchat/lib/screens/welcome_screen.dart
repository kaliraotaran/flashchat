import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../components/roundedbuttn.dart';

class WelcomeScreen extends StatefulWidget {
  static String id =
      'welcome_screen'; // when we use static, we dont need to use () when we use it somehwere else
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    animation = ColorTween(begin: Colors.blueAccent, end: Colors.white)
        .animate(controller);
    // animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();

    controller.addListener(() {
      setState(() {});
      print(controller
          .value); // we can use this to do the color animation on the screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value
      //Color.fromARGB(255, 214, 184, 149)
      //.withOpacity(controller.value)
      , // this animates it
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                //     const AnimatedEmoji(
                //   AnimatedEmojis.smile,
                //   size: 128,
                //   repeat: false,
                // ),
                SizedBox(
                  width: 30,
                ),
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat'],
                  speed: Duration(milliseconds: 100),
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: roundedbutton(
                  color: Colors.lightBlueAccent,
                  title: 'Login',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => LoginScreen())));
                  }),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => RegistrationScreen())));
                      },
                      minWidth: 100.0,
                      height: 50.0,
                      child: Text(
                        'register',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
