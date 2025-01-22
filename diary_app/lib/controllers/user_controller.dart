import 'package:diary_app/pages/home/home_screen.dart';
import 'package:diary_app/services/auth_service.dart';
import 'package:diary_app/utils/snacbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  final AuthService authService = AuthService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void fetchProfile() async {
    final prefs = await _prefs;
    nameController.text = prefs.getString('name')!;
    usernameController.text = prefs.getString('username')!;
  }

  Future<String?> getToken() async {
    final prefs = await _prefs;
    return prefs.getString('token');
  }

  Future<String?> getName() async {
    final prefs = await _prefs;
    return prefs.getString('name');
  }

  Future<String?> getUsername() async {
    final prefs = await _prefs;
    return prefs.getString('username');
  }

  Future<String?> getEmail() async {
    final prefs = await _prefs;
    return prefs.getString('email');
  }

  Future<String?> getId() async {
    final prefs = await _prefs;
    return prefs.getString('id');
  }

  void clearForm() {
    nameController.clear();
    usernameController.clear();
  }

  Future<bool> formValidation() async {
    if (nameController.text.isEmpty) {
      SnackbarMessage().error('Error', 'Name is required');
      return false;
    } else if (usernameController.text.isEmpty) {
      SnackbarMessage().error('Error', 'Username is required');
      return false;
    } else {
      return true;
    }
  }

  Future<void> updateProfile() async {
    try {
      if (!await formValidation()) return;
      final body = {
        'name': nameController.text,
        'username': usernameController.text,
      };

      final response = await authService.updateProfile(body);
      if (response['statusCode'] == 200) {
        final prefs = await _prefs;
        await prefs.setString('name', response['data']['name']);
        await prefs.setString('username', response['data']['username']);
        clearForm();
        fetchProfile();
        Get.to(const HomeScreen(), transition: Transition.fade);
        SnackbarMessage().success('Success', 'Profile has been updated');
      } else {
        SnackbarMessage().error('Error', response['data']['username'][0]);
      }
    } catch (e) {
      SnackbarMessage().error('Error', e.toString());
    }
  }
}
