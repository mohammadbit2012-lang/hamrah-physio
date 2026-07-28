import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// AppLocalizations handles standard key-value map dictionary lookups for
/// multi-lingual support, defaulting to Persian (IR) and supporting English (US).
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // Helper method to retrieve localizations in BuildContext
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  /// Loads the language JSON file from the assets directory
  Future<bool> load() async {
    try {
      // Read the localized JSON asset file
      String jsonString = await rootBundle.loadString(
          'assets/translations/${locale.languageCode}.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      _localizedStrings = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });
      return true;
    } catch (e) {
      // Fallback in case of asset loading errors during local development
      _localizedStrings = {};
      return false;
    }
  }

  /// Translates a given key. Returns the key itself if not found.
  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

/// Localization Delegate standardizing the asynchronous asset file booting flow.
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['fa', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

/// Extension helper to allow clean syntax: context.translate('key_name')
extension LocalizationExtension on BuildContext {
  String translate(String key) {
    return AppLocalizations.of(this)?.translate(key) ?? key;
  }
}