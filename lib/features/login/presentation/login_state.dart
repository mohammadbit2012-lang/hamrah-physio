/// Statuses representing the phase of login authentication.
enum LoginStatus { idle, loading, success, error }

/// Immutable state container representing the Login UI and logic state.
class LoginState {
  final LoginStatus status;
  final String? errorMessage;
  final String? role;

  const LoginState({
    required this.status,
    this.errorMessage,
    this.role,
  });

  /// Initial state before any action is taken.
  factory LoginState.idle() => const LoginState(status: LoginStatus.idle);

  /// State when the login process is ongoing.
  factory LoginState.loading() => const LoginState(status: LoginStatus.loading);

  /// State on successful login authentication.
  factory LoginState.success(String role) => LoginState(
        status: LoginStatus.success,
        role: role,
      );

  /// State on a failed login authentication.
  factory LoginState.error(String message) => LoginState(
        status: LoginStatus.error,
        errorMessage: message,
      );

  bool get isIdle => status == LoginStatus.idle;
  bool get isLoading => status == LoginStatus.loading;
  bool get isSuccess => status == LoginStatus.success;
  bool get isError => status == LoginStatus.error;
}
