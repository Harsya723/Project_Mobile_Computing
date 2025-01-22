import 'package:diary_app/controllers/diary_controller.dart';
import 'package:diary_app/controllers/user_controller.dart';
import 'package:diary_app/pages/diaries/diary_preview_screen.dart';
import 'package:diary_app/pages/diaries/form_diary_screen.dart';
import 'package:diary_app/pages/home/home_screen.dart';
import 'package:diary_app/utils/colours.dart';
import 'package:diary_app/utils/date_format.dart';
import 'package:diary_app/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final DiaryController diaryController = Get.put(DiaryController());
  final UserController userController = Get.put(UserController());
  final Colours colours = Colours();
  final Fonts fonts = Fonts();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      diaryController.fetchDiary();
    });
  }

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
              Obx(() {
                if (diaryController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 5),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: diaryController.diaries.length,
                    itemBuilder: (context, index) {
                      final item = diaryController.diaries[index];
                      return Card(
                        child: ListTile(
                          title: Text(item['title'],
                              style: TextStyle(
                                  color: colours.dark,
                                  fontFamily: fonts.semibold,
                                  fontSize: 15)),
                          subtitle: Text(CustomDateFormat.formatWithDay(DateTime.parse(item['date'])),
                              style: TextStyle(
                                  color: colours.grey,
                                  fontFamily: fonts.medium)),
                          trailing: GestureDetector(
                            child: Icon(Icons.delete_forever_outlined,
                                color: colours.danger),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Konfirmasi'),
                                    content: Text(
                                        'Apakah anda yakin ingin menghapus diary ini?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text('Batal',
                                            style:
                                                TextStyle(color: colours.dark)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text('Hapus',
                                            style: TextStyle(
                                                color: colours.danger)),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          onTap: () {
                            // showDialog pilihan edit dan preview dengan GestureDetector dan container
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Pilihan'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          Get.to(FormDiaryScreen(
                                            diary: item,
                                          ),
                                              transition:
                                                  Transition.rightToLeft);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: colours.primary,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text('Edit Diary',
                                                style: TextStyle(
                                                    color: colours.white,
                                                    fontFamily: fonts.bold)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          Get.to(DiaryPreviewScreen(diary: item,),
                                              transition:
                                                  Transition.rightToLeft);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: colours.sky,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text('Preview Diary',
                                                style: TextStyle(
                                                    color: colours.white,
                                                    fontFamily: fonts.bold)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('Batal',
                                          style:
                                              TextStyle(color: colours.dark)),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
