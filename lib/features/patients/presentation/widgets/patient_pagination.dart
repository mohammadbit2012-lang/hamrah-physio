import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_typography.dart';

/// A highly reusable, production-ready pagination bar component.
class PatientPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const PatientPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Next Button (in RTL context, Next goes right, but labeled بعدی)
          TextButton.icon(
            onPressed: currentPage < totalPages
                ? () => onPageChanged(currentPage + 1)
                : null,
            icon: const Icon(Icons.chevron_left_rounded, size: 20),
            label: const Text(
              'بعدی',
              style: TextStyle(
                fontFamily: AppTypography.fontName,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Numeric Buttons: 1, 2, 3...
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(totalPages, (index) {
              final pageNum = index + 1;
              final isCurrent = pageNum == currentPage;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SizedBox(
                  width: 36,
                  height: 36,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: isCurrent
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                      foregroundColor: isCurrent
                          ? Theme.of(context).colorScheme.onPrimary
                          : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: isCurrent
                              ? Colors.transparent
                              : (isDark ? AppColors.borderDark : AppColors.borderLight),
                        ),
                      ),
                    ),
                    onPressed: () => onPageChanged(pageNum),
                    child: Text(
                      pageNum.toString(),
                      style: const TextStyle(
                        fontFamily: AppTypography.fontName,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),

          // Previous Button
          TextButton.icon(
            onPressed: currentPage > 1
                ? () => onPageChanged(currentPage - 1)
                : null,
            icon: const Icon(Icons.chevron_right_rounded, size: 20),
            label: const Text(
              'قبلی',
              style: TextStyle(
                fontFamily: AppTypography.fontName,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
