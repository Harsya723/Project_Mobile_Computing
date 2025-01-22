import 'package:diary_app/pages/auth/auth_screen.dart';
import 'package:diary_app/pages/home/home_screen.dart';
import 'package:diary_app/services/auth_service.dart';
import 'package:diary_app/utils/snacbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final AuthService authService = AuthService();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var isLoggedIn = false.obs;

  Future<void> login() async {
    try{
      if(!await formLoginValidation()) return;
      String username = usernameController.text;
      String password = passwordController.text;
      final response = await authService.login(username, password);
      print(response);
      if(response['statusCode'] == 200) {
        final prefs = await _prefs;
        isLoggedIn.value = true;
        await prefs.setString('token', response['data']['access_token']);
        await prefs.setString('id', response['data']['user']['id'].toString());
        await prefs.setString('name', response['data']['user']['name']);
        await prefs.setString('username', response['data']['user']['username']);
        await prefs.setString('email', response['data']['user']['email']);
        clearForm();
        Get.to(const HomeScreen(), transition: Transition.fade);
      } else {
        SnackbarMessage().error('Error', response['data']);
      }
    } catch (e) {
      Get.back();
      SnackbarMessage().error('Error', e.toString());
    }
  }

  Future<bool> formLoginValidation() async {
    if(usernameController.text.isEmpty) {
      SnackbarMessage().warning('Warning', 'Username cannot be empty');
      return false;
    } else if(passwordController.text.isEmpty) {
      SnackbarMessage().warning('Warning', 'Password cannot be empty');
      return false;
    }
    return true;
  }

  Future<void> register() async {
    try{
      if(!await formRegisterValidation()) return;
      final body = {
        'name': nameController.text,
        'username': usernameController.text,
        'email': '${usernameController.text.toLowerCase()}@mail.com',
        'password': passwordController.text,
        'password_confirmation': confirmPasswordController.text,
      };

      final response = await authService.register(body);
        if(response['statusCode'] == 201) {
          clearForm();
          Get.to(const AuthScreen(), transition: Transition.fade);
          SnackbarMessage().success('Success', 'Register success');
        } else {
          SnackbarMessage().error('Error', response['data']['username'][0]);
        }
    } catch (e) {
      Get.back();
      SnackbarMessage().error('Error', e.toString());
    }
  }

  Future<bool> formRegisterValidation() async {
    if(nameController.text.isEmpty) {
      SnackbarMessage().warning('Warning', 'Name cannot be empty');
      return false;
    } else if(usernameController.text.isEmpty) {
      SnackbarMessage().warning('Warning', 'Username cannot be empty');
      return false;
    } else if(passwordController.text.isEmpty) {
      SnackbarMessage().warning('Warning', 'Password cannot be empty');
      return false;
    } else if(confirmPasswordController.text.isEmpty) {
      SnackbarMessage().warning('Warning', 'Confirm Password cannot be empty');
      return false;
    } else if(passwordController.text != confirmPasswordController.text) {
      SnackbarMessage().warning('Warning', 'Password and Confirm Password must be the same');
      return false;
    }
    return true;
  }

  void clearForm() {
    nameController.clear();
    usernameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  Future<void> logout() async {
    try{
      final response = await authService.logout();
      if(response['statusCode'] == 200) {
        final prefs = await _prefs;
        await prefs.clear();
        Get.to(const AuthScreen(), transition: Transition.fade);
        isLoggedIn.value = false;
      } else {
        SnackbarMessage().error('Error', response['data']);
      }
    } catch (e) {
      Get.back();
      SnackbarMessage().error('Error', e.toString());
    }
  }
}
