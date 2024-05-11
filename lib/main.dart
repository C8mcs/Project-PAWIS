import 'package:flutter/material.dart';
import 'edit_profile.dart';
import 'homepage.dart';
import 'registration_page.dart';
import 'splash_screen_page.dart';
import 'login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      routes: {
        '/splash_screen_page': (context) => SplashScreen(),
        '/login_page': (context) => LoginPage(),
        '/homepage': (context) => Homepage(
              username: 'Alice', //temp
              imagePath: null, // temp
              points: 102, // update points),
            ),
        '/edit_profile': (context) => EditProfile(
              username: '', //temp
              fullname: ' ', //temp
              address: ' ', //temp
              mobileNumber: 1234567890, //temp
              imagePath: 'assets/images/Logo_withBG.jpg', //temp
            ),
        '/registration_page': (context) => RegistrationPage(),
      },
    );
  }
}
