import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/config/theme/app_typography.dart';
import '../../login/presentation/auth_controller.dart';

/// Secretary Dashboard screen containing a large icon, title, welcome message, and logout.
class SecretaryDashboard extends ConsumerWidget {
  const SecretaryDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'پنل منشی',
          style: TextStyle(fontFamily: AppTypography.fontName, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'خروج',
            onPressed: () {
              ref.read(authControllerProvider.notifier).reset();
              context.go('/login');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Large Icon
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.calendar_month_rounded,
                    size: 80,
                    color: theme.colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 24),
                // Dashboard Title
                Text(
                  'داشبورد منشی همراه فیزیو',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontFamily: AppTypography.fontName,
                    color: theme.colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 12),
                // Welcome Message
                Text(
                  'منشی گرامی، به پنل کاربری خود خوش آمدید. در این بخش می‌توانید نوبت‌دهی، هماهنگی جلسات درمانی و پذیرش بیماران را مدیریت کنید.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontFamily: AppTypography.fontName,
                    color: theme.colorScheme.onBackground.withOpacity(0.8),
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
