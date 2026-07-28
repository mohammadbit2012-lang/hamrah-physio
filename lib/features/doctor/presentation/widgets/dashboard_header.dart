import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/config/theme/app_colors.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile & Actions
          Row(
            children: [
              // Notification Badge/Icon
              Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications_none_rounded,
                      size: 28,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'هیچ اعلان جدیدی وجود ندارد',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontFamily: AppTypography.fontName),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              // Profile Icon / Avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.person_pin_rounded,
                  color: theme.colorScheme.primary,
                  size: 26,
                ),
              ),
            ],
          ),
          // Greeting & Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'دکتر گرامی، خوش آمدید 👋',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontFamily: AppTypography.fontName,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'دوشنبه، ۱۶ تیر ۱۴۰۵',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: AppTypography.fontName,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
