import 'package:diary_app/services/category_service.dart';
import 'package:diary_app/utils/snacbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{
  final CategoryService categoryService = CategoryService();
  TextEditingController nameController = TextEditingController();

  RxList<dynamic> categories = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    try{
      await fetchCategory();
    } catch (e) {
      SnackbarMessage().error('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchCategory() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading(true);
      });

      final response = await categoryService.fetch();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (response['statusCode'] == 200) {
          categories.value = response['data'];
        } else {
          print(response['data']);
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
    nameController.clear();
  }

  Future<bool> validateForm({bool isUpdate = false}) async {
    if (nameController.text.isEmpty) {
      SnackbarMessage().error('Error', 'Category name is required');
      return false;
    } else {
      return true;
    }
  }

  Future<void> createCategory() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading(true);
      });

      if (!await validateForm()) {
        return;
      }

      final body = {
        'name': nameController.text,
      };

      final response = await categoryService.create(body);
      if (response['statusCode'] == 201) {
        clearForm();
        await fetchCategory();
        Get.back();
        SnackbarMessage().success('Success', 'Category has been created');
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

  Future<void> updateCategory(String id) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading(true);
      });

      if (!await validateForm(isUpdate: true)) {
        return;
      }

      final body = {
        'name': nameController.text,
      };

      final response = await categoryService.update(id, body);
      if (response['statusCode'] == 200) {
        clearForm();
        await fetchCategory();
        Get.back();
        SnackbarMessage().success('Success', 'Data bangunan berhasil diperbarui');
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

  Future<void> deleteCategory(String id) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading(true);
      });

      final response = await categoryService.delete(id);
      if (response['statusCode'] == 200) {
        await fetchCategory();
        Get.back();
        SnackbarMessage().success('Success', 'Data bangunan berhasil dihapus');
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
}
