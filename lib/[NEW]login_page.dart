import 'package:flutter/material.dart';
import 'registration_page.dart';

final _formKey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Login",
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: <Widget>[
              Text("net"),
              LoginForm(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, "/homepage");
                  }
                },
                child: const Text("Signup"),
              ),
            ]),
          ),
        ));
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

  void _handleSubmit() {
    setState(() {
      submitted = true;
    });

    Navigator.pushNamed(context, '/homepage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(68, 122, 43, 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Form(
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
                      height: 400,
                      width: 350,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(106, 173, 36, 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      )),
                  const SizedBox(height: 100),
                  TextFormField(
                    controller: this.controller,
                    decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: "Enter your email address",
                        icon: Icon(Icons.email_outlined)),
                    validator: (value) {
                      if (value?.trim().isEmpty ?? false) {
                        return "Email required";
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: "Password",
                          hintText: "Enter your password",
                          icon: Icon(Icons.password_outlined)),
                      validator: (value) {
                        if (value?.trim().isEmpty ?? false) {
                          return "Password required";
                        }
                      }),
                  const SizedBox(height: 100),
                ],
              ),
            ),
            Text(controller.text),
            const SizedBox(height: 45),
            const Text(
              "Forgot Password?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
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
                  child: const Text(
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
    );
  }
}
