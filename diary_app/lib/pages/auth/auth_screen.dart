import 'package:diary_app/controllers/auth_controller.dart';
import 'package:diary_app/pages/auth/register_screen.dart';
import 'package:diary_app/utils/colours.dart';
import 'package:diary_app/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthController authController = Get.put(AuthController());

  final Colours colours = Colours();
  final Fonts fonts = Fonts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Judul
              Center(
                child: Text(
                  'Diary App',
                  style: TextStyle(
                    color: colours.primary,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Login untuk melanjutkan',
                style: TextStyle(
                  color: colours.grey,
                  fontSize: 16,
                  fontFamily: fonts.medium,
                ),
              ),
              const SizedBox(height: 20),
              // Form login
              TextField(
                controller: authController.usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  prefixIcon: Icon(Icons.account_circle_outlined, color: colours.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                obscureText: true,
                controller: authController.passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: colours.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  await authController.login();
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: colours.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Masuk',
                      style: TextStyle(
                        color: colours.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: TextStyle(
                      color: colours.grey,
                      fontSize: 14,
                      fontFamily: fonts.medium,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const RegisterScreen(), transition: Transition.rightToLeft);
                    },
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                        color: colours.primary,
                        fontSize: 14,
                        fontFamily: fonts.medium,
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
