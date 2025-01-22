import 'package:diary_app/controllers/user_controller.dart';
import 'package:diary_app/pages/home/home_screen.dart';
import 'package:diary_app/utils/colours.dart';
import 'package:diary_app/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final UserController userController = Get.put(UserController());
  final Colours colours = Colours();
  final Fonts fonts = Fonts();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userController.fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.white,
      body: RefreshIndicator(
        onRefresh: () async {
          print('Refresh');
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pengatuan Akun',
                          style: TextStyle(
                            color: colours.dark,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: fonts.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(const HomeScreen(),
                                transition: Transition.leftToRight);
                          },
                          child: Text(
                            'Kembali',
                            style: TextStyle(
                              color: colours.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: fonts.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Row(
                      // circle avatar, kanannya text nama, email
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: colours.grey,
                          child: Icon(
                            Icons.person,
                            color: colours.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder(
                              future: userController.getName(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    '${snapshot.data!}!',
                                    style: TextStyle(
                                      color: colours.dark,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: fonts.bold,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    'User!',
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
                            FutureBuilder(
                              future: userController.getUsername(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    'usr - ${snapshot.data!}',
                                    style: TextStyle(
                                      color: colours.dark,
                                      fontSize: 14,
                                      fontFamily: fonts.medium,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    'nousername',
                                    style: TextStyle(
                                      color: colours.dark,
                                      fontSize: 14,
                                      fontFamily: fonts.medium,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Nama Lengkap',
                      style: TextStyle(
                        color: colours.grey,
                        fontSize: 16,
                        fontFamily: fonts.medium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: userController.nameController,
                      decoration: InputDecoration(
                        hintText: 'Nama Lengkap Anda',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Subject dengan label dan inputan
                    Text(
                      'Username',
                      style: TextStyle(
                        color: colours.grey,
                        fontSize: 16,
                        fontFamily: fonts.medium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: userController.usernameController,
                      decoration: InputDecoration(
                        hintText: 'Username Anda',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () async {
                        await userController.updateProfile();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: colours.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Ubah Profil',
                            style: TextStyle(
                              color: colours.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
