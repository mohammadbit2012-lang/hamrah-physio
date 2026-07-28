/// AppConstants provides central static keys and configurations
/// utilized throughout Hamrah Physio. It ensures consistency across modules.
class AppConstants {
  AppConstants._();

  // App Metadata
  static const String appName = 'Hamrah Physio';
  static const String appVersion = '1.0.0';

  // API Endpoints & Backends (For future Supabase integration)
  static const String supabaseUrl = 'https://placeholder-project.supabase.co';
  static const String supabaseAnonKey = 'placeholder-anon-key-to-be-configured-later';

  // Animation Durations
  static const Duration durationFast = Duration(milliseconds: 200);
  static const Duration durationMedium = Duration(milliseconds: 400);
  static const Duration durationSlow = Duration(milliseconds: 800);

  // Layout Spacings (Bento-grid & Layout grids guidelines)
  static const double spaceXS = 4.0;
  static const double spaceSM = 8.0;
  static const double spaceMD = 16.0;
  static const double spaceLG = 24.0;
  static const double spaceXL = 32.0;
  static const double spaceXXL = 48.0;

  // Design Guidelines
  static const double cardRadius = 12.0;
  static const double buttonRadius = 8.0;
  static const double maxContentWidth = 1200.0;

  // Cache & Storage Keys
  static const String keyAuthToken = 'auth_token_key';
  static const String keyUserRole = 'user_role_key';
  static const String keyLanguage = 'app_language_key';
  static const String keyThemeMode = 'app_theme_mode_key';
}