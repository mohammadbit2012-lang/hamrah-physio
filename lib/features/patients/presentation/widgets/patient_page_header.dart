import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_typography.dart';

/// A production-quality page header widget for the Patients module.
class PatientPageHeader extends StatelessWidget {
  final bool isDesktop;
  final VoidCallback onClearList;
  final VoidCallback onAddPatient;

  const PatientPageHeader({
    super.key,
    required this.isDesktop,
    required this.onClearList,
    required this.onAddPatient,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'مدیریت بیماران',
            style: TextStyle(
              fontFamily: AppTypography.fontName,
              fontSize: isDesktop ? 22 : 18,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
          ),
          Row(
            children: [
              // Dev tool button to clear/empty list to show empty state
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.error,
                ),
                onPressed: onClearList,
                icon: const Icon(Icons.delete_sweep_rounded, size: 18),
                label: Text(
                  isDesktop ? 'شبیه‌سازی لیست خالی' : 'لیست خالی',
                  style: const TextStyle(
                    fontFamily: AppTypography.fontName,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 20 : 12,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: onAddPatient,
                icon: const Icon(Icons.person_add_rounded, size: 18),
                label: Text(
                  'ثبت بیمار جدید',
                  style: TextStyle(
                    fontFamily: AppTypography.fontName,
                    fontSize: isDesktop ? 14 : 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
