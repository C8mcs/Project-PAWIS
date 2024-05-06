import 'package:flutter/material.dart';

//remove once connected
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(
        username: 'example_username',
        imagePath: 'assets/images/Logo_noBG.png',
        points: 0.0,
      ),
    );
  }
}

class Homepage extends StatelessWidget {
  final String username;
  late final String? imagePath;
  final double points;

  Homepage({required this.username, this.imagePath, required this.points});

  @override
  Widget build(BuildContext context) {
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
                // open edit user profile
                Navigator.pop(context);
                Navigator.pushNamed(context, '/edit_profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                //logout user
              },
            ),
          ],
        ),
      ),
      body: Column(
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
                  username,
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
                    height: 90,
                    width: 125,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(68, 122, 43, 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 90,
                    width: 125,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(68, 122, 43, 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
      ),
    );
  }
}
