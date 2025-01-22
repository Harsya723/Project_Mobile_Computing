import 'package:diary_app/controllers/user_controller.dart';
import 'package:diary_app/dummies/dummy.dart';
import 'package:diary_app/pages/home/home_screen.dart';
import 'package:diary_app/pages/refs/ref_preview_screen.dart';
import 'package:diary_app/utils/colours.dart';
import 'package:diary_app/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RefScreen extends StatefulWidget {
  const RefScreen({super.key});

  @override
  State<RefScreen> createState() => _RefScreenState();
}

class _RefScreenState extends State<RefScreen> {
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
              // List diary
              ListView.builder(
                padding: const EdgeInsets.only(top: 5),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: refDiaries.length,
                itemBuilder: (context, index) {
                  final diary = refDiaries[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(RefPreviewScreen(refDiary: diary),
                          transition: Transition.rightToLeft);
                    },

                    child: Container(
                      height: 80,
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: colours.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 80,
                            decoration: BoxDecoration(
                              color: colours.primary,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              child: Image.asset(
                                diary['image']!,
                                width: 100,
                                height: 80,
                                fit: BoxFit.cover,
                                // radius left top dan bottom left
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  diary['title']!,
                                  style: TextStyle(
                                    color: colours.dark,
                                    fontSize: 16,
                                    fontFamily: fonts.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  diary['date']!,
                                    style: TextStyle(
                                        color: colours.primary,
                                        fontSize: 14,
                                        fontFamily: fonts.medium,
                                    ),
                                ),
                                ],
                            ),
                          ),
                        ],
                      ),
                      ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
