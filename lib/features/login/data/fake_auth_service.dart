import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for FakeAuthService
final fakeAuthServiceProvider = Provider<FakeAuthService>((ref) {
  return FakeAuthService();
});

/// A mock/fake service implementing simple authentication logic for Sprint 1.2.
class FakeAuthService {
  /// Simulates a login request.
  /// If username and password are not empty and valid, waits 1 second and returns mapped role.
  /// Otherwise, throws an Exception.
  Future<String> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    
    final u = username.trim();
    final p = password.trim();
    
    if (u.isEmpty || p.isEmpty) {
      throw Exception('نام کاربری یا رمز عبور نامعتبر است');
    }
    
    switch (u.toLowerCase()) {
      case 'admin':
        return 'doctor';
      case 'secretary':
        return 'secretary';
      case 'operator':
        return 'operator';
      case 'patient':
        return 'patient';
      default:
        throw Exception('نام کاربری یا رمز عبور نامعتبر است');
    }
  }
}
