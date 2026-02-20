import 'package:flutter/material.dart';
import 'package:login_app/component/button.dart';
import 'package:login_app/component/colors.dart';
import 'package:login_app/component/textfield.dart';
import 'package:login_app/sqflite/database_helper.dart';
import 'package:login_app/views/profile_screen.dart';
import 'package:login_app/views/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usrNameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isChecked = false;
  bool isLoginError = false;
  bool isLoading = false;

  final DatabaseHelper db = DatabaseHelper();

  @override
  void dispose() {
    usrNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (usrNameController.text.isEmpty ||
        passwordController.text.isEmpty) {
      setState(() => isLoginError = true);
      return;
    }

    setState(() {
      isLoading = true;
      isLoginError = false;
    });

    final user = await db.authenticate(
      usrNameController.text.trim(),
      passwordController.text.trim(),
    );

    setState(() => isLoading = false);

    if (user != null) {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Profile(profile: user),
        ),
      );
    } else {
      setState(() => isLoginError = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Text(
                  "LOGIN",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Image.asset("assets/background.jpg"),

                AppInputField(
                  hint: "Username",
                  icon: Icons.account_circle,
                  controller: usrNameController,
                ),

                AppInputField(
                  hint: "Password",
                  icon: Icons.lock,
                  controller: passwordController,
                  isPassword: true,
                ),

                ListTile(
                  horizontalTitleGap: 2,
                  title: const Text("Remember me"),
                  leading: Checkbox(
                    activeColor: AppColors.primary,
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                  ),
                ),

                isLoading
                    ? const CircularProgressIndicator()
                    : AppButton(
                  label: "LOGIN",
                  onPressed: login,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text("SIGN UP"),
                    ),
                  ],
                ),

                if (isLoginError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Username or password is incorrect",
                      style: TextStyle(
                        color: Colors.red.shade900,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
