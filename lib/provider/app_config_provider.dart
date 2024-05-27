import 'package:flutter/material.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  // config section
  String appLanguage = "en";

  final bool isEnglish;

  AppConfigProvider(this.isEnglish) {
    if (!isEnglish) {
      appLanguage = "ar";
    }
  }

  changeLanguage(String newLanguage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (newLanguage == appLanguage) {
      if (newLanguage == "en") {
        prefs.setBool("isEnglish", true);
      } else {
        prefs.setBool("isEnglish", false);
      }

      return;
    }

    if (newLanguage == "en") {
      prefs.setBool("isEnglish", true);
    } else {
      prefs.setBool("isEnglish", false);
    }
    appLanguage = newLanguage;

    notifyListeners();
  }

  bool isArLang() {
    return appLanguage == "ar";
  }

// tasks section
}
