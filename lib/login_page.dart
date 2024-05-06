import 'package:flutter/material.dart';
import 'registration_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({Key? key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  bool submitted = false;

  void _handleSubmit() {
    setState(() {
      submitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(68, 122, 43, 1),
      body: Center(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "PAWIS",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Promoting Accountability\nwith Waste Incentive System",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 400,
                width: 350,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(106, 173, 36, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Login",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Username/ID",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: submitted ? null : _handleSubmit,
                        child: Text(submitted ? "Success" : "Login"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(76, 52, 14, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                        ),
                      ),
                      SizedBox(height: 45),
                      Text(
                        "Forgot Password?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account yet?",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationPage()),
                      );
                    },
                    child: Text(
                      " Register here",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
