import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/fake_auth_service.dart';
import 'login_state.dart';

/// Provider for AuthController, managing LoginState.
final authControllerProvider = StateNotifierProvider<AuthController, LoginState>((ref) {
  final authService = ref.watch(fakeAuthServiceProvider);
  return AuthController(authService);
});

/// Controller handling the UI interactions and state transitions for login.
class AuthController extends StateNotifier<LoginState> {
  final FakeAuthService _authService;

  AuthController(this._authService) : super(LoginState.idle());

  /// Attempts to log the user in using the username and password.
  Future<void> login(String username, String password) async {
    state = LoginState.loading();
    try {
      final role = await _authService.login(username, password);
      state = LoginState.success(role);
    } catch (e) {
      // Strip typical prefix from Exception object if any
      final message = e.toString().replaceAll('Exception: ', '');
      state = LoginState.error(message);
    }
  }

  /// Resets the authentication state back to Idle.
  void reset() {
    state = LoginState.idle();
  }
}
