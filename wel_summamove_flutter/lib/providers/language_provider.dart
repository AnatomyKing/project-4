import 'package:flutter/material.dart';
import '../lang/app_texts.dart';
import '../lang/gb_app_texts.dart';
import '../lang/nl_app_texts.dart';

class LanguageProvider extends ChangeNotifier {
  bool _isEnglish = false;
  bool get isEnglish => _isEnglish;

  AppTexts get texts => _isEnglish ? GBAppTexts() : NLAppTexts();
  String   get flag  => _isEnglish ? '🇬🇧' : '🇳🇱';

  void toggle() {
    _isEnglish = !_isEnglish;
    notifyListeners();
  }
}
