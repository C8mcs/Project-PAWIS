import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pawis_application/edit_profile.dart';
import 'package:pawis_application/models/userModel.dart';
import 'package:pawis_application/models/userPointsModel.dart';
import 'package:pawis_application/services/auth.dart';
import 'package:pawis_application/services/database.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  Homepage({super.key});

  String? fullname = '';
  final String? imagePath = '';
  int points = 0;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(68, 122, 43, 1),
        elevation: 0,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Image.asset('assets/images/Logo_noBG.png')),
            ListTile(
              leading: Icon(Icons.person_rounded),
              title: Text('Edit Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/edit_profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Color.fromRGBO(0x6A, 0xAD, 0x24, 1.0),
                      title: GestureDetector(
                          onTap: () async {
                            await _auth.signOut();
                          },
                          child: const Text(
                            "Confirm Logout",
                            style: TextStyle(color: Colors.white),
                          )),
                      content: Text(
                        "Are you sure you want to logout?",
                        style: TextStyle(color: Colors.white),
                      ),
                      actions: [
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromRGBO(68, 122, 43, 1),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/login_page');
                          },
                          child: Text("Logout"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<UserDetailsModel>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            UserDetailsModel? userData = snapshot.data;
            if (snapshot.hasData == false) {
              return User();
            }

            return StreamBuilder<UserPointsModel>(
                stream: DatabaseService(uid: user.uid).userPoints,
                builder: (context, snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 250,
                        width: 400,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(68, 122, 43, 1),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: imagePath != null
                                  ? AssetImage(imagePath!)
                                  : AssetImage('assets/images/Logo_noBG.png'),
                            ),
                            SizedBox(height: 5),
                            Text(
                              userData!.fullname ?? '',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'PAWIS Points',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              '$points',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              'Check out your redeemables from our partner stores!',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Inter',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 99,
                                width: 125,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(0x6A, 0xAD, 0x24, 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 90,
                                width: 125,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(204, 233, 206, 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 90,
                                width: 125,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(204, 233, 206, 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 90,
                                width: 125,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(0x6A, 0xAD, 0x24, 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 180,
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
                                height: 20,
                              ),
                              Text(
                                "PAWIS",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Promoting Accountability with Waste Management Incentive System",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }),
    );
  }
}
