import 'dart:io';

import 'package:diary_app/pages/diaries/diary_screen.dart';
import 'package:diary_app/pages/diaries/form_diary_screen.dart';
import 'package:diary_app/services/diary_service.dart';
import 'package:diary_app/utils/snacbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DiaryController extends GetxController {
  final DiaryService diaryService = DiaryService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  var image = Rx<File?>(null);

  RxList<dynamic> diaries = [].obs;
  RxList<dynamic> categories = [].obs;
  var selectedCategory = Rx<Map<String, dynamic>?>(null);
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    try {
      dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
      selectCategory();
      fetchDiary();
    } catch (e) {
      SnackbarMessage().error('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> selectCategory() async {
    try {
      final response = await diaryService.selectCategory();
      categories.value = response['data'];
    } catch (e) {
      SnackbarMessage().error('Error', e.toString());
    }
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      dateController.text = formattedDate;
    }
  }

  Future<void> fetchDiary() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading(true);
      });

      final response = await diaryService.fetch();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (response['statusCode'] == 200) {
          diaries.value = response['data'];
        } else {
          SnackbarMessage().error('Error', response['data']);
        }
      });
    } catch (e) {
      SnackbarMessage().error('Error', e.toString());
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading(false);
      });
    }
  }

  void clearForm() {
    titleController.clear();
    subjectController.clear();
    contentController.clear();
    dateController.clear();
    selectedCategory.value = null;
    image.value = null;
  }

  Future<bool> validateForm({bool isUpdate = false}) async {
    if (selectedCategory.value == null) {
      SnackbarMessage().error('Error', 'Category is required');
      return false;
    } else if (titleController.text.isEmpty) {
      SnackbarMessage().error('Error', 'Title is required');
      return false;
    } else if (subjectController.text.isEmpty) {
      SnackbarMessage().error('Error', 'Subject is required');
      return false;
    } else if (contentController.text.isEmpty) {
      SnackbarMessage().error('Error', 'Content is required');
      return false;
    } else if (dateController.text.isEmpty) {
      SnackbarMessage().error('Error', 'Date is required');
      return false;
    } else if (image.value == null && !isUpdate) {
      SnackbarMessage().error('Error', 'Image is required');
      return false;
    } else {
      return true;
    }
  }

  Future<void> createDiary() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading(true);
      });

      if (!await validateForm()) {
        return;
      }

      final body = {
        'category_id': selectedCategory.value?['id'].toString(),
        'title': titleController.text,
        'subject': subjectController.text,
        'content': contentController.text,
        'date': dateController.text,
        'attachment': image.value?.path,
      };

      final response = await diaryService.create(body);
      if (response['statusCode'] == 201) {
        clearForm();
        await fetchDiary();
        Get.to(const FormDiaryScreen(), transition: Transition.fade);
        SnackbarMessage().success('Success', 'Data diary berhasil ditambahkan');
      } else {
        SnackbarMessage().error('Error', response['message']);
      }
    } catch (e) {
      SnackbarMessage().error('Error', e.toString());
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading(false);
      });
    }
  }

  Future<void> showDiary(String id) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading(true);
      });

      final response = await diaryService.show(id);
      selectedCategory.value = response['data']['category'];
      titleController.text = response['data']['title'];
      subjectController.text = response['data']['subject'];
      contentController.text = response['data']['content'];
      dateController.text = response['data']['date'];
      image.value = File(response['data']['photo']);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading(false);
      });
    } catch (e) {
      SnackbarMessage().error('Error', e.toString());
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading(false);
      });
    }
  }

  Future<void> updateDiary(String id) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading(true);
      });

      if (!await validateForm(isUpdate: true)) {
        return;
      }

      final body = {
        'category_id': selectedCategory.value?['id'].toString(),
        'title': titleController.text,
        'subject': subjectController.text,
        'content': contentController.text,
        'date': dateController.text,
        'photo': image.value?.path,
      };

      final response = await diaryService.update(id, body);
      if (response['statusCode'] == 200) {
        clearForm();
        await fetchDiary();
        Get.to(const DiaryScreen(), transition: Transition.fade);
        SnackbarMessage()
            .success('Success', 'Data diary berhasil diperbarui');
      } else {
        SnackbarMessage().error('Error', response['message']);
      }
    } catch (e) {
      SnackbarMessage().error('Error', e.toString());
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading(false);
      });
    }
  }

  Future<void> deleteDiary(String id) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading(true);
      });

      final response = await diaryService.delete(id);
      if (response['statusCode'] == 200) {
        await fetchDiary();
        Get.back();
        SnackbarMessage().success('Success', 'Data dairy berhasil dihapus');
      } else {
        SnackbarMessage().error('Error', response['message']);
      }
    } catch (e) {
      SnackbarMessage().error('Error', e.toString());
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading(false);
      });
    }
  }

  Future<void> takePhoto() async {
    final ImagePicker picker = ImagePicker();

    // Pilih gambar dari galeri (ImageSource.gallery)
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // Mengambil gambar sebagai file
      File imageFile = File(pickedImage.path);

      // Update variabel dengan file yang dipilih
      image.value = imageFile;

      // Menampilkan ukuran file gambar yang dipilih
      print("Ukuran file gambar yang dipilih: ${imageFile.lengthSync()} bytes");
    }
  }
}
