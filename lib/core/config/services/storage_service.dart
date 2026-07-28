import 'package:shared_preferences/shared_preferences.dart';
import '../utils/logger.dart';

/// StorageService encapsulates the local cache layer of Hamrah Physio.
/// It wraps SharedPreferences to persist auth states, theme preferences,
/// and role selections offline.
class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  /// Standard String storage helper
  Future<bool> setString(String key, String value) async {
    AppLogger.d('Storage: Saving $key = $value');
    return await _prefs.setString(key, value);
  }

  /// Standard String retrieval helper
  String? getString(String key) {
    final value = _prefs.getString(key);
    AppLogger.d('Storage: Reading $key = $value');
    return value;
  }

  /// Standard Boolean storage helper
  Future<bool> setBool(String key, bool value) async {
    AppLogger.d('Storage: Saving $key = $value');
    return await _prefs.setBool(key, value);
  }

  /// Standard Boolean retrieval helper
  bool? getBool(String key) {
    final value = _prefs.getBool(key);
    AppLogger.d('Storage: Reading $key = $value');
    return value;
  }

  /// Clears cache during user sign out operations
  Future<bool> remove(String key) async {
    AppLogger.d('Storage: Removing $key');
    return await _prefs.remove(key);
  }

  /// Completely resets storage
  Future<bool> clearAll() async {
    AppLogger.w('Storage: Wiping all local data!');
    return await _prefs.clear();
  }
}