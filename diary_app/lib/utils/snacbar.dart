import 'package:diary_app/utils/colours.dart';
import 'package:get/get.dart';

class SnackbarMessage {
  final Colours colours = Colours();

  void error(String title, String message) {
    Get.snackbar(title, message, backgroundColor: colours.rose.withOpacity(0.8), colorText: colours.white);
  }

  void success(String title, String message) {
    Get.snackbar(title, message, backgroundColor: colours.primary.withOpacity(0.8), colorText: colours.white);
  }

  void warning(String title, String message) {
    Get.snackbar(title, message, backgroundColor: colours.orange.withOpacity(0.8), colorText: colours.white);
  }

  void info(String title, String message) {
    Get.snackbar(title, message, backgroundColor: colours.sky.withOpacity(0.8), colorText: colours.white);
  }
}
