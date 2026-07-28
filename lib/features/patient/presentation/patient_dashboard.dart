import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/config/theme/app_typography.dart';
import '../../login/presentation/auth_controller.dart';

/// Patient Dashboard screen containing a large icon, title, welcome message, and logout.
class PatientDashboard extends ConsumerWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'پنل بیمار',
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
                    color: Colors.teal.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 80,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 24),
                // Dashboard Title
                Text(
                  'داشبورد بیمار همراه فیزیو',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontFamily: AppTypography.fontName,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 12),
                // Welcome Message
                Text(
                  'بیمار گرامی، به پنل سلامت همراه فیزیو خوش آمدید. در این بخش می‌توانید برنامه فیزیوتراپی خانگی، نوبت‌های آینده، و پیشرفت تمرینات خود را مشاهده کنید.',
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
