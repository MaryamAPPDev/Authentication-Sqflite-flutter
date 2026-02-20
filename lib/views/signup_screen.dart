import 'package:flutter/material.dart';
import 'package:login_app/component/button.dart';
import 'package:login_app/component/colors.dart';
import 'package:login_app/component/textfield.dart';
import 'package:login_app/json/users.dart';
import 'package:login_app/sqflite/database_helper.dart';
import 'package:login_app/views/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final usrNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final DatabaseHelper db = DatabaseHelper();

  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    usrNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await db.createUser(
        User(
          fullName: fullNameController.text.trim(),
          email: emailController.text.trim(),
          userName: usrNameController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );

      if (result > 0) {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      }

    } catch (e) {
      setState(() {
        errorMessage = "Username already exists";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Register New Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  AppInputField(
                    hint: "Full Name",
                    icon: Icons.person,
                    controller: fullNameController,
                  ),

                  AppInputField(
                    hint: "Email",
                    icon: Icons.email,
                    controller: emailController,
                  ),

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

                  AppInputField(
                    hint: "Confirm Password",
                    icon: Icons.lock,
                    controller: confirmPasswordController,
                    isPassword: true,
                  ),

                  const SizedBox(height: 10),

                  if (isLoading)
                    const CircularProgressIndicator()
                  else
                    AppButton(
                      label: "SIGN UP",
                      onPressed: signUp,
                    ),

                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text("LOGIN"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
