import 'package:flutter/material.dart';
import 'package:pawis_application/homepage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Homepage(
      username: 'Alice', //temp
      imagePath: null, // temp
      points: 102, // update points),
    );
  }
}
