import 'package:flutter/material.dart';
import 'package:login_app/component/button.dart';
import 'package:login_app/component/colors.dart';
import 'package:login_app/views/login_screen.dart';
import 'package:login_app/views/signup_screen.dart';


class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Authentication",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                  const Text(
                    "Authenticate to access your vital information",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Expanded(child: Image.asset("assets/startup.jpg")),
                  Button(label: "LOGIN", press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                  }),
                  Button(label: "SIGN UP", press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignupScreen()));
                  }),
                ],
              ),
            ),
          )),
    );
  }
}
