import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerUtils {
  static Future<File?> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'JPG', 'png', 'PNG', 'jpeg', 'JPEG']);
    if (result != null) {
      File file = File(result.files.single.path ?? "");
      return Future.value(file);
    } else {
      // User canceled the picker
      return null;
    }
  }
}