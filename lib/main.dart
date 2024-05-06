import 'package:flutter/material.dart';
import 'edit_profile.dart';
import 'homepage.dart';
import 'registration_page.dart';
import 'splash_screen_page.dart';
import 'login_page.dart';

void main() {
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
              fullname: '',
              username: '',
              address: '',
              mobileNumber: null,
              imagePath: null,
            ),
        '/registration_page': (context) => RegistrationPage(),
      },
    );
  }
}
