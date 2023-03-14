import 'package:flutter/foundation.dart';

class PrintUtils {
  void prints(
      {required String message,
      required String? value,
      String className = "",
      int? lineNumber}) {
    if (kDebugMode) {
      print(
          "$message $value ${className.isNotEmpty ? "ClassName: $className" : ""} ${lineNumber != null ? "LineNumber: $lineNumber" : ""}");
    }
  }
}