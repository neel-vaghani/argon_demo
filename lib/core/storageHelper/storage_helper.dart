import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageHelper {
  //? private storage object
  static late final SharedPreferences instance;

  static Future<void> init() async {
    instance = await SharedPreferences.getInstance();
  }

  static Future<void> clearAllData() async {
    await instance.clear();
  }

  static Future<void> setPageNumber({required int pageNumber}) async {
    await instance.setInt("page_number", pageNumber);
  }

  static int? getPageNumber() {
    return instance.getInt("page_number");
  }
}
