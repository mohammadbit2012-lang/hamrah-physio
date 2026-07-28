import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/config/theme/app_colors.dart';

class WorkspacePlaceholder extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const WorkspacePlaceholder({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Large Icon
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 80,
                color: color,
              ),
            ),
            const SizedBox(height: 24),
            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontFamily: AppTypography.fontName,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 12),
            // Description
            Container(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Text(
                description,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: AppTypography.fontName,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
