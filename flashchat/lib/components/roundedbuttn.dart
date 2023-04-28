import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';

class roundedbutton extends StatelessWidget {
  const roundedbutton({
    Key key,
    this.color,
    this.title,
    this.onPressed,
  }) : super(key: key);
  final Color color;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            // onPressed;
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => LoginScreen())));
          },
          minWidth: 100.0,
          height: 50.0,
          child: Text(
            title,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
