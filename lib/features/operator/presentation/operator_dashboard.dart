import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/config/theme/app_typography.dart';
import '../../login/presentation/auth_controller.dart';

/// Operator Dashboard screen containing a large icon, title, welcome message, and logout.
class OperatorDashboard extends ConsumerWidget {
  const OperatorDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'پنل اپراتور',
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
                    color: Colors.orange.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.support_agent_rounded,
                    size: 80,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 24),
                // Dashboard Title
                Text(
                  'داشبورد اپراتور همراه فیزیو',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontFamily: AppTypography.fontName,
                    color: Colors.orange.shade800,
                  ),
                ),
                const SizedBox(height: 12),
                // Welcome Message
                Text(
                  'اپراتور گرامی، به پنل مدیریت سیستم خوش آمدید. در این بخش می‌توانید به پشتیبانی فنی بیماران، نظارت بر سرور و تنظیمات کلی سیستم بپردازید.',
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
