import '/all.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'vi_VN': {
      ...viVn,
    },
    'en_US': {
      ...enUs,
    },
  };
}

void setLanguages(String? languageCode, String? countryCode) async {
  if (languageCode == null && countryCode == null) {
    String? _langCode = prefsController.getString('languageCode');
    String? _countryCode = prefsController.getString('countryCode');
    if (!_langCode.isBlank! && !_countryCode.isBlank!) {
      Get.updateLocale(Locale(_langCode, _countryCode));
    }
  } else {
    Get.updateLocale(Locale(languageCode!, countryCode));
    prefsController.setString('languageCode', languageCode);
    prefsController.setString('countryCode', countryCode!);
  }
}
