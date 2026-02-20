import 'package:flutter/material.dart';
import 'package:login_app/component/button.dart';
import 'package:login_app/component/colors.dart';
import 'package:login_app/json/users.dart';
import 'package:login_app/views/login_screen.dart';

class Profile extends StatelessWidget {
  final User? profile;

  const Profile({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {

    if (profile == null) {
      return const Scaffold(
        body: Center(
          child: Text("No User Data Found"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.primary,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage("assets/no_user.jpg"),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  profile!.fullName ?? "No Name",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  profile!.email ?? "No Email",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 30),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Column(
                    children: [

                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text("Full Name"),
                        subtitle: Text(profile!.fullName ?? ""),
                      ),

                      const Divider(),

                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text("Email"),
                        subtitle: Text(profile!.email ?? ""),
                      ),

                      const Divider(),

                      ListTile(
                        leading: const Icon(Icons.account_circle),
                        title: const Text("Username"),
                        subtitle: Text(profile!.userName),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                AppButton(
                  label: "LOGOUT",
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                          (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
