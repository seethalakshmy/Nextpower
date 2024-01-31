import 'package:get_storage/get_storage.dart';

class AppStorage {
  static const accessToken = "access_token";
  static const isLoggedin = "is_logged_in";
  static const tokenType = "token_type";
  static const userId = "user_id";

  AppStorage() {
    GetStorage.init();
  }

  GetStorage storage = GetStorage();

  void writeAccessToken(String value) async {
    await storage.write(AppStorage.accessToken, value);
  }

  String getAccessToken() {
    return storage.read(AppStorage.accessToken) ?? "";
  }

  void writeIsLoggedIn(bool value) async {
    await storage.write(AppStorage.isLoggedin, value);
  }

  bool isLoggedIn() {
    return storage.read(AppStorage.isLoggedin) ?? false;
  }

  void writeUserId(String value) async {
    await storage.write(AppStorage.userId, value);
  }

  String getUserId() {
    return storage.read(AppStorage.userId) ?? "";
  }

  void clearValues() async {
    await storage.erase();
  }
}
