import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/login_page');
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 30,
          ),
          Image.asset('assets/images/Logo_noBG.png'),
          Container(
            height: 300,
            width: 400,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(68, 122, 43, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "PAWIS",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Promoting Accountability with Waste Management Incentive System",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
