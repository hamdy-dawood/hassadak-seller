import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveIfNotFirstTime() async {
    return await prefs.setBool("IfFirstTime", false);
  }

  static bool getIfFirstTime() {
    return prefs.getBool("IfFirstTime") ?? true;
  }

  static Future<bool> saveToken(String token) async {
    return await prefs.setString("token", token);
  }

  static String getToken() {
    return prefs.getString("token") ?? "";
  }

  static Future<bool> removeToken() {
    return prefs.remove("token");
  }

  static Future<bool> saveId(String id) async {
    return await prefs.setString("id", id);
  }

  static String getId() {
    return prefs.getString("id") ?? "";
  }

  static Future<bool> saveFirstName(String firstName) async {
    return await prefs.setString("firstName", firstName);
  }

  static String getFirstName() {
    return prefs.getString("firstName") ?? "";
  }

  static Future<bool> saveLastName(String lastName) async {
    return await prefs.setString("lastName", lastName);
  }

  static String getLastName() {
    return prefs.getString("lastName") ?? "";
  }

  static Future<bool> saveUserPhoto(String userPhoto) async {
    return await prefs.setString("userPhoto", userPhoto);
  }

  static String getUserPhoto() {
    return prefs.getString("userPhoto") ?? "";
  }

  static Future<bool> removeId() {
    return prefs.remove("id");
  }

  static Future<bool> clear() {
    return prefs.clear();
  }
}
