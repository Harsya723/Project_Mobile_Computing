import 'package:diary_app/controllers/auth_controller.dart';
import 'package:diary_app/pages/auth/auth_screen.dart';
import 'package:diary_app/utils/colours.dart';
import 'package:diary_app/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                'Daftar untuk melanjutkan',
                style: TextStyle(
                  color: colours.grey,
                  fontSize: 16,
                  fontFamily: fonts.medium,
                ),
              ),
              const SizedBox(height: 20),
              // Form daftar
              TextField(
                controller: authController.nameController,
                decoration: InputDecoration(
                  hintText: 'Nama Lengkap',
                  prefixIcon: Icon(Icons.account_circle_outlined, color: colours.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
              TextField(
                obscureText: true,
                controller: authController.confirmPasswordController,
                decoration: InputDecoration(
                  hintText: 'Konfirmasi Password',
                  prefixIcon: Icon(Icons.key, color: colours.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  await authController.register();
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: colours.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Daftar',
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
                    'Sudah punya akun? ',
                    style: TextStyle(
                      color: colours.grey,
                      fontSize: 14,
                      fontFamily: fonts.medium,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const AuthScreen(), transition: Transition.leftToRight);
                    },
                    child: Text(
                      'Masuk',
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
