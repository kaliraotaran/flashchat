import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'firebase_options.dart';

// void main() {
//   // try {
//   //   Firebase.initializeApp();
//   // } catch (e) {
//   //   print(e);
//   // }
//   runApp(FlashChat());
// }

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(FlashChat());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.black54),
          ),
        ),
        home: WelcomeScreen(),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) =>
              WelcomeScreen(), // since we used static it doesn't need to use (), bassically, it doesnt create another screen
          LoginScreen.id: ((context) => LoginScreen()),
          RegistrationScreen.id: ((context) => RegistrationScreen()),
          ChatScreen.id: ((context) => ChatScreen()),
        });
  }
}
