import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/config/theme/app_typography.dart';
import 'auth_controller.dart';
import 'login_state.dart';

/// The login screen for Hamrah Physio.
/// Adheres strictly to the responsive RTL, Persian interface, Material 3, and Sprint 1.1 / 1.2 / 1.3 requirements.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  ProviderSubscription<LoginState>? _authSubscription;

  @override
  void initState() {
    super.initState();
    _authSubscription = ref.listenManual<LoginState>(
      authControllerProvider,
      (previous, next) {
        if (next.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'ورود موفق',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontFamily: AppTypography.fontName),
              ),
              backgroundColor: Colors.green,
            ),
          );
          final role = next.role;
          if (role != null) {
            context.go('/$role');
          }
        } else if (next.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                next.errorMessage ?? 'نام کاربری یا رمز عبور نامعتبر است',
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontFamily: AppTypography.fontName),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _authSubscription?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final isDesktop = mediaQuery.size.width > 600;
    final loginState = ref.watch(authControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Centered, responsive login container
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Card(
                    elevation: isDesktop ? 2 : 0,
                    color: isDesktop ? theme.cardTheme.color : Colors.transparent,
                    shape: isDesktop ? theme.cardTheme.shape : const RoundedRectangleBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(isDesktop ? 32.0 : 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 1. Logo Area
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.medical_services_rounded,
                                size: 48,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // 2. Title & Subtitle
                          Center(
                            child: Text(
                              'Hamrah Physio',
                              style: theme.textTheme.displayMedium?.copyWith(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                                height: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Center(
                            child: Text(
                              'سیستم مدیریت کلینیک فیزیوتراپی',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.secondary,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 36),

                          // 3. Username TextField
                          TextField(
                            controller: _usernameController,
                            keyboardType: TextInputType.text,
                            textDirection: TextDirection.ltr,
                            decoration: InputDecoration(
                              hintText: 'نام کاربری خود را وارد کنید',
                              hintStyle: const TextStyle(),
                              hintTextDirection: TextDirection.rtl,
                              prefixIcon: Icon(Icons.person_outline_rounded, color: theme.colorScheme.secondary),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // 4. Password TextField
                          TextField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            textDirection: TextDirection.ltr,
                            decoration: InputDecoration(
                              hintText: 'کلمه عبور خود را وارد کنید',
                              hintStyle: const TextStyle(),
                              hintTextDirection: TextDirection.rtl,
                              prefixIcon: Icon(Icons.lock_outline_rounded, color: theme.colorScheme.secondary),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: theme.colorScheme.secondary,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                           // 5. Full-width Login Button
                          SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: loginState.isLoading
                                  ? null
                                  : () {
                                      ref.read(authControllerProvider.notifier).login(
                                            _usernameController.text,
                                            _passwordController.text,
                                          );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: loginState.isLoading
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          'در حال ورود...',
                                          style: theme.textTheme.labelLarge?.copyWith(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      'ورود',
                                      style: theme.textTheme.labelLarge?.copyWith(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // 6. Version Label
                Text(
                  'Version 0.1.0',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.secondary.withOpacity(0.7),
                    fontFamily: AppTypography.fontName,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
