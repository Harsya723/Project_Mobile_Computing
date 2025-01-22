import 'package:diary_app/controllers/auth_controller.dart';
import 'package:diary_app/controllers/user_controller.dart';
import 'package:diary_app/pages/accounts/account_screen.dart';
import 'package:diary_app/pages/categories/category_screen.dart';
import 'package:diary_app/pages/diaries/diary_screen.dart';
import 'package:diary_app/pages/diaries/form_diary_screen.dart';
import 'package:diary_app/pages/refs/ref_screen.dart';
import 'package:diary_app/utils/colours.dart';
import 'package:diary_app/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController authController = Get.put(AuthController());
  final UserController userController = Get.put(UserController());
  final Colours colours = Colours();
  final Fonts fonts = Fonts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Halo dan nama user dan di kanan itu button untuk logout
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder(
                    future: userController.getName(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          'Halo, ${snapshot.data!}!',
                          style: TextStyle(
                            color: colours.dark,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: fonts.bold,
                          ),
                        );
                      } else {
                        return Text(
                          'Halo, User!',
                          style: TextStyle(
                            color: colours.dark,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: fonts.bold,
                          ),
                        );
                      }
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      // show dialog untuk konfirmasi keluar
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Konfirmasi'),
                            content: Text('Apakah anda yakin ingin keluar?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('Batal', style: TextStyle(color: colours.dark)),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await authController.logout();
                                },
                                child: Text('Keluar', style: TextStyle(color: colours.danger)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'Keluar',
                      style: TextStyle(
                        color: colours.danger,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: fonts.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                  height: 200,
                  width: double.infinity,
                  padding: const EdgeInsets.all(0),
                  child: Stack(
                    // dengan gambar dibelakang dan didepannya itu ada overlay warna hitam serta ada bacaan dikit
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/quotes.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      // Ganti Expanded dengan Align atau Positioned
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Kata Penyemangat',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: fonts.bold,
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 15),
              GridView.count(
                padding: const EdgeInsets.all(0),
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(const FormDiaryScreen(), transition: Transition.rightToLeft);
                    },
                    child: Card(
                      color: colours.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.note_add_outlined, size: 50, color: colours.primary,),
                          SizedBox(height: 10),
                          Text('Tambah Diary', style: TextStyle(color: colours.dark, fontSize: 14, fontFamily: fonts.medium)),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const DiaryScreen(), transition: Transition.rightToLeft);
                    },
                    child: Card(
                      color: colours.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.list_alt_rounded, size: 50, color: colours.primary,),
                          SizedBox(height: 10),
                          Text('Daftar Diary', style: TextStyle(color: colours.dark, fontSize: 14, fontFamily: fonts.medium)),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const CategoryScreen(), transition: Transition.rightToLeft);
                    },
                    child: Card(
                      color: colours.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.category_outlined, size: 50, color: colours.primary,),
                          SizedBox(height: 10),
                          Text('Kategori', style: TextStyle(color: colours.dark, fontSize: 14, fontFamily: fonts.medium)),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const RefScreen(), transition: Transition.rightToLeft);
                    },
                    child: Card(
                      color: colours.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.book_outlined, size: 50, color: colours.primary,),
                          SizedBox(height: 10),
                          Text('Referensi', style: TextStyle(color: colours.dark, fontSize: 14, fontFamily: fonts.medium)),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const AccountScreen(), transition: Transition.rightToLeft);
                    },
                    child: Card(
                      color: colours.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.verified_outlined, size: 50, color: colours.primary,),
                          SizedBox(height: 10),
                          Text('Pengaturan Akun', style: TextStyle(color: colours.dark, fontSize: 14, fontFamily: fonts.medium)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
