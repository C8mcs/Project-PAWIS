import 'package:flutter/material.dart';
import '../services/auth.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromRGBO(68, 122, 43, 1),
        body: Registration_Form());
  }
}

class Registration_Form extends StatefulWidget {
  const Registration_Form({Key? key});

  @override
  _Registration_FormState createState() => _Registration_FormState();
}

class _Registration_FormState extends State<Registration_Form> {
  bool submitted = false;
  final controller = TextEditingController();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String fullname = '';
  String email = '';
  String address = '';
  String phoneNumber = '';
  String password = '';
  String repassword = '';
  String errorMessage = '';

  void _handleSubmit(context) async {
    setState(() {
      submitted = true;
    });
    dynamic result = await _auth.registerWithCredentials(
        email, password, fullname, address, phoneNumber);
    if (result == null) {
      setState(() {
        submitted = false;
        errorMessage = 'Please supply valid credentials';
      });
    } else {
      Navigator.pushNamed(context, '/homepage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            // color: const Color.fromRGBO(106, 173, 36, 1.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "PAWIS",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Promoting Accountability\nwith Waste Incentive System",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                      padding: const EdgeInsets.all(20),
                      // height: auto,
                      // width: 350,
                      decoration: const BoxDecoration(
                        color: const Color.fromRGBO(106, 173, 36, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20),
                          Text(
                            "Register",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(76, 52, 14, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Email",
                                  hintText: "Enter your email address",
                                  icon: Icon(Icons.email_outlined)),
                              validator: (value) {
                                if (value?.trim().isEmpty ?? false) {
                                  return "Email required";
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              }),
                          const SizedBox(height: 30),
                          TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Full Name",
                                  hintText: "Enter your full name",
                                  icon: Icon(Icons.person)),
                              validator: (value) {
                                if (value?.trim().isEmpty ?? false) {
                                  return "Full name required";
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  fullname = value;
                                });
                              }),
                          const SizedBox(height: 30),
                          TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Address",
                                  hintText: "Enter your address",
                                  icon: Icon(Icons.location_city)),
                              validator: (value) {
                                if (value?.trim().isEmpty ?? false) {
                                  return "Address required";
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  address = value;
                                });
                              }),
                          const SizedBox(height: 30),
                          TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Phone Number",
                                  hintText: "Enter your phone number",
                                  icon: Icon(Icons.phone_enabled)),
                              validator: (value) {
                                if (value?.trim().isEmpty ?? false) {
                                  return "Phone number required";
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  phoneNumber = value;
                                });
                              }),
                          const SizedBox(height: 30),
                          TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                  labelText: "Password",
                                  hintText: "Enter your password",
                                  icon: Icon(Icons.lock)),
                              validator: (value) {
                                return value!.length < 8
                                    ? "Enter a password more than 8 characters long"
                                    : null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              }),
                          const SizedBox(height: 30),
                          TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                  labelText: "Repeat Password",
                                  hintText: "Enter your password",
                                  icon: Icon(Icons.lock_clock_outlined)),
                              validator: (value) {
                                if (value?.trim().isEmpty ?? false) {
                                  return "Repeat password required";
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  repassword = value;
                                });
                              }),
                          SizedBox(height: 40),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(76, 52, 14, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _handleSubmit(context);
                                }
                              },
                              child: Text(submitted ? "Success" : "Register")),
                          SizedBox(height: 15),
                          Text(
                            errorMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 30),
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
                      )),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login_page');
                        },
                        child: Text(
                          " Login here",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(76, 52, 14, 1),
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
        ]));
  }
}
