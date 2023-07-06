import '/all.dart';

abstract class PrefsKey {
}

class PrefsController extends GetxController {
  late SharedPreferences prefs;

  @override
  void onInit() {
    super.onInit();
    updatePrefs();
  }

  updatePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  setString(String key, String value) {
    prefs.setString(key, value);
    updatePrefs();
  }

  String getString(String key) {
    if (prefs.containsKey(key)) {
      return prefs.getString(key)!;
    } else {
      return '';
    }
  }

  bool getBool(String key) {
    if (prefs.containsKey(key)) {
      return prefs.getBool(key)!;
    } else {
      return false;
    }
  }

  setBool(String key, bool value) {
    prefs.setBool(key, value);
    updatePrefs();
  }

  void removeKey(String key) {
    prefs.remove(key);
    updatePrefs();
  }
}

PrefsController prefsController =
Get.put<PrefsController>(PrefsController(), permanent: true);
