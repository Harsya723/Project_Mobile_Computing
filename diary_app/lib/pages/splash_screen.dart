import 'dart:async';

import 'package:diary_app/pages/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:diary_app/utils/colours.dart';
import 'package:diary_app/utils/fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final Colours colours = Colours();
  final Fonts fonts = Fonts();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(0),
      color: colours.white,
      child: Stack(
        children: [
          Positioned(
            right: -100,
            top: 25,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: colours.primaryShape),
            ),
          ),
          Positioned(
            right: -100,
            top: 180,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: colours.primaryShape),
            ),
          ),

          Positioned(
            left: -100,
            bottom: 50,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: colours.primaryShape),
            ),
          ),
          Positioned(
            left: -100,
            bottom: 200,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: colours.primaryShape),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Diary App', style: TextStyle(
                  color: colours.primary,
                  fontFamily: fonts.bold,
                  fontSize: 30,
                  letterSpacing: 1,
                  decoration: TextDecoration.none
                ),),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 50),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text('2025 Copyright', style: TextStyle(
                color: colours.dark,
                fontFamily: fonts.regular,
                fontSize: 12,
                letterSpacing: 1,
                decoration: TextDecoration.none
              ),),
            ),
          )
        ],
      ),
    );
  }
}
