import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/config/theme/app_colors.dart';

class QuickActionItem {
  final String title;
  final IconData icon;
  final Color color;

  const QuickActionItem({
    required this.title,
    required this.icon,
    required this.color,
  });
}

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  static const List<QuickActionItem> _actions = [
    QuickActionItem(
      title: 'بیمار جدید',
      icon: Icons.person_add_alt_1_rounded,
      color: AppColors.primaryLight,
    ),
    QuickActionItem(
      title: 'جستجوی بیمار',
      icon: Icons.search_rounded,
      color: AppColors.info,
    ),
    QuickActionItem(
      title: 'پرونده‌های پزشکی',
      icon: Icons.folder_shared_rounded,
      color: Colors.indigo,
    ),
    QuickActionItem(
      title: 'نسخه‌ها',
      icon: Icons.note_alt_rounded,
      color: AppColors.warning,
    ),
    QuickActionItem(
      title: 'برنامه‌های تمرینی',
      icon: Icons.fitness_center_rounded,
      color: AppColors.success,
    ),
    QuickActionItem(
      title: 'گزارش‌ها',
      icon: Icons.analytics_rounded,
      color: AppColors.error,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'دسترسی سریع',
            textDirection: TextDirection.rtl,
            style: theme.textTheme.titleMedium?.copyWith(
              fontFamily: AppTypography.fontName,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),
          itemCount: _actions.length,
          itemBuilder: (context, index) {
            final action = _actions[index];
            return Material(
              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              shadowColor: Colors.black.withOpacity(0.04),
              elevation: isDark ? 0 : 2,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'بخش "' + action.title + '" در فازهای بعدی فعال خواهد شد.',
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(fontFamily: AppTypography.fontName),
                      ),
                      backgroundColor: action.color,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: action.color.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          action.icon,
                          color: action.color,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        action.title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontFamily: AppTypography.fontName,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
