import 'dart:io';

import 'package:diary_app/controllers/diary_controller.dart';
import 'package:diary_app/controllers/user_controller.dart';
import 'package:diary_app/pages/diaries/diary_screen.dart';
import 'package:diary_app/pages/home/home_screen.dart';
import 'package:diary_app/utils/colours.dart';
import 'package:diary_app/utils/date_format.dart';
import 'package:diary_app/utils/endpoints.dart';
import 'package:diary_app/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_searchable_dropdown/flutter_searchable_dropdown.dart';

class FormDiaryScreen extends StatefulWidget {
  final dynamic diary;
  const FormDiaryScreen({super.key, this.diary});

  @override
  State<FormDiaryScreen> createState() => _FormDiaryScreenState();
}

class _FormDiaryScreenState extends State<FormDiaryScreen> {
  final DiaryController diaryController = Get.put(DiaryController());
  final UserController userController = Get.put(UserController());
  final Endpoints endpoints = Endpoints();
  final Colours colours = Colours();
  final Fonts fonts = Fonts();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      diaryController.selectCategory();
      diaryController.selectedCategory.value = diaryController.categories.isNotEmpty
      ? diaryController.categories[0] // Nilai default (kategori pertama)
      : null;
      if (widget.diary != null) {

        diaryController.titleController.text = widget.diary['title'];
        diaryController.subjectController.text = widget.diary['subject'];
        diaryController.dateController.text =
            CustomDateFormat.format(DateTime.parse(widget.diary['date']));
        diaryController.contentController.text = widget.diary['content'];
        diaryController.selectedCategory.value = widget.diary['category'];

        if (widget.diary!['attachment'] != null &&
            widget.diary!['attachment'].startsWith('/')) {
          diaryController.image.value =
            File(widget.diary!['attachment']);
        } else {
          diaryController.image.value = null;
        }
      }
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
                        if (widget.diary != null){
                          Get.to(const DiaryScreen(),
                              transition: Transition.rightToLeft);
                        } else{
                          Get.to(const HomeScreen(),
                              transition: Transition.leftToRight);
                        }
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
                Center(
                  child: Text(
                    widget.diary == null ? 'Tambah Diary' : 'Ubah Diary',
                    style: TextStyle(
                      color: colours.dark,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: fonts.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Form daftar
                // Pilih kategori dengan label dan inputan
                Text(
                  'Kategori Diary',
                  style: TextStyle(
                    color: colours.grey,
                    fontSize: 16,
                    fontFamily: fonts.medium,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  if (diaryController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return SearchableDropdown.single(
                    items: diaryController.categories.map((category) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: category,
                        child: Text(
                          '${category['id']} - ${category['name']}',
                          style: TextStyle(
                            fontFamily: fonts.medium,
                            fontSize: 14,
                            color: colours.dark,
                          ),
                        ),
                      );
                    }).toList(),
                    value: diaryController.selectedCategory
                        .value, // Menggunakan nilai yang sudah ter-set
                    hint: Text(
                      'Pilih Kategori',
                      style: TextStyle(
                        fontFamily: fonts.medium,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    searchHint: 'Cari Kategori',
                    onChanged: (Map<String, dynamic>? selectedCategory) {
                      diaryController.selectedCategory.value = selectedCategory;
                    },
                    isExpanded: true,
                    iconEnabledColor: colours.primary,
                    iconDisabledColor: Colors.grey,
                    style: TextStyle(
                      fontFamily: fonts.medium,
                      fontSize: 14,
                      color: colours.grey,
                    ),
                  );
                }),
                const SizedBox(height: 10),

                // Nama Diary dengan label dan inputan
                Text(
                  'Judul Diary',
                  style: TextStyle(
                    color: colours.grey,
                    fontSize: 16,
                    fontFamily: fonts.medium,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: diaryController.titleController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan judul diary',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Subject dengan label dan inputan
                Text(
                  'Subject Diary',
                  style: TextStyle(
                    color: colours.grey,
                    fontSize: 16,
                    fontFamily: fonts.medium,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: diaryController.subjectController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan subject diary',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Datepicker dengan label dan inputan
                Text(
                  'Tanggal Diary',
                  style: TextStyle(
                    color: colours.grey,
                    fontSize: 16,
                    fontFamily: fonts.medium,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: diaryController.dateController,
                  onTap: () async => await diaryController.selectDate(context),
                  decoration: InputDecoration(
                    hintText: 'Pilih tanggal diary',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Content dengan label dan inputan
                Text(
                  'Content Diary',
                  style: TextStyle(
                    color: colours.grey,
                    fontSize: 16,
                    fontFamily: fonts.medium,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: diaryController.contentController,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: 'Masukkan content diary',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Gambar (dengan container dan ditengah ada icon untuk upload)
                Text(
                  'Gambar Diary',
                  style: TextStyle(
                    color: colours.grey,
                    fontSize: 16,
                    fontFamily: fonts.medium,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() {
                    if (diaryController.image.value != null) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              diaryController.image.value!,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: diaryController.takePhoto,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: colours.lightPrimary,
                                child: Icon(Icons.edit,
                                    size: 18, color: colours.primary),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (widget.diary != null &&
                        widget.diary!['attachment'] != null) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              '${endpoints.storageUrl}/${widget.diary!['attachment']}',
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: diaryController.takePhoto,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: colours.lightPrimary,
                                child: Icon(Icons.edit,
                                    size: 18, color: colours.primary),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: colours.forms,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GestureDetector(
                          onTap: diaryController.takePhoto,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: colours.lightPrimary,
                                  child: Icon(Icons.camera_alt,
                                      size: 30, color: colours.primary),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Upload Foto',
                                  style: TextStyle(
                                    color: colours.dark,
                                    fontSize: 12,
                                    fontFamily: fonts.medium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10),
          color: colours.primary,
          child: GestureDetector(
            onTap: () async {
              if (widget.diary == null) {
                await diaryController.createDiary();
              } else {
                await diaryController.updateDiary(widget.diary['id'].toString());
              }
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: colours.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Simpan Diary',
                  style: TextStyle(
                    color: colours.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: fonts.bold,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
