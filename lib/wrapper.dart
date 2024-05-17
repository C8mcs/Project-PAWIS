import 'package:flutter/material.dart';
import 'package:pawis_application/authenticate/authentication.dart';
import 'package:pawis_application/homepage.dart';
import 'package:provider/provider.dart';
import './models/userModel.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    print("user user");

    print("user: $user");

    // return either home or authenticate widget

    if (user == null) {
      return Authentication();
    }
    return Homepage();
  }
}
