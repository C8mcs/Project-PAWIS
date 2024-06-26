import 'package:flutter/material.dart';
import '../services/auth.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromRGBO(68, 122, 43, 1), body: LoginForm());
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool submitted = false;
  final controller = TextEditingController();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String errorMessage = '';

  void _handleSubmit(context) async {
    setState(() {
      submitted = true;
    });
    dynamic result = await _auth.signInWithCredentials(email, password);
    print(result);
    if (result == null) {
      setState(() {
        print("error error");
        submitted = false;
        errorMessage = 'Email and password do not match';
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
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20),
                          Text(
                            "Login",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 22,
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
                              obscureText: true,
                              decoration: const InputDecoration(
                                  labelText: "Password",
                                  hintText: "Enter your password",
                                  icon: Icon(Icons.lock)),
                              validator: (value) {
                                if (value?.trim().isEmpty ?? false) {
                                  return "Password required";
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  password = value;
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
                              child: Text(
                                submitted ? "Success" : "Login",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              )),
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
                        "Don't have an account yet?",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/registration_page');
                        },
                        child: Text(
                          " Register here",
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
          Text(controller.text),
        ]));
  }
}
