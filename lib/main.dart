import 'package:flutter/material.dart';
import 'package:pawis_application/services/auth.dart';
import 'edit_profile.dart';
import 'homepage.dart';
import 'registration_page.dart';
import 'splash_screen_page.dart';
import 'login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'wrapper.dart';
import 'package:provider/provider.dart';
import './models/userModel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
        value: AuthService().user,
        initialData: null,
        child: MaterialApp(
          home: const SplashScreen(),
          routes: {
            '/splash_screen_page': (context) => const SplashScreen(),
            '/login_page': (context) => LoginPage(),
            '/homepage': (context) => Wrapper(),
            '/edit_profile': (context) => EditProfile(
                  username: '', //temp
                  fullname: ' ', //temp
                  address: ' ', //temp
                  mobileNumber: 1234567890, //temp
                  imagePath: 'assets/images/Logo_withBG.jpg', //temp
                ),
            '/registration_page': (context) => const RegistrationPage(),
          },
        ));
  }
}

// void _firebase_auth() {
//   FirebaseAuth.instance.authStateChanges().listen((User? user) {
//     if (user == null) {
//       return Login();
//     } else {
//       return RegistrationPage();
//     }
//   });
// }
