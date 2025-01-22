import 'package:diary_app/pages/home/home_screen.dart';
import 'package:diary_app/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  final getPrefs = await prefs;

  final token = getPrefs.getString('token');

  print(token);

  Widget initialRoute;

  if (token == null) {
    // Jika sudah melewati batas waktu, lakukan proses logout
    await getPrefs.clear(); // Hapus token dari SharedPreferences
    initialRoute = const SplashScreen(); // Arahkan ke layar splash
  } else {
    // Pengguna masih dalam batas waktu, arahkan ke layar home
    initialRoute = const HomeScreen();
  }

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: initialRoute,
  ));
}
