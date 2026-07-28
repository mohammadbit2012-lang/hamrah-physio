import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../model/patient.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  final ValueChanged<Patient> onView;
  final ValueChanged<Patient> onEdit;

  const PatientCard({
    super.key,
    required this.patient,
    required this.onView,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isActive = patient.status == 'active';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row: Avatar, Name & Status
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.12),
                  child: Text(
                    patient.fullName.characters.take(1).toString(),
                    style: TextStyle(
                      fontFamily: AppTypography.fontName,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient.fullName,
                        style: TextStyle(
                          fontFamily: AppTypography.fontName,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'کد ملی: ${patient.nationalCode}',
                        style: TextStyle(
                          fontFamily: AppTypography.fontName,
                          fontSize: 11,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.textSecondaryLight.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: isActive ? AppColors.success : AppColors.textSecondaryLight,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isActive ? 'فعال' : 'غیرفعال',
                        style: TextStyle(
                          fontFamily: AppTypography.fontName,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isActive ? AppColors.success : AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),

          // Detail Section: Phone, Sessions, Last Visit
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildInfoRow(
                  Icons.phone_outlined,
                  'شماره تماس:',
                  patient.phone,
                  isDark,
                ),
                const SizedBox(height: 10),
                _buildInfoRow(
                  Icons.fitness_center_outlined,
                  'جلسات باقی‌مانده:',
                  '${patient.remainingSessions} جلسه',
                  isDark,
                  valueColor: patient.remainingSessions > 0
                      ? theme.colorScheme.primary
                      : AppColors.error,
                  valueFontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10),
                _buildInfoRow(
                  Icons.calendar_today_outlined,
                  'آخرین مراجعه:',
                  patient.lastVisit,
                  isDark,
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Actions Row: View, Edit Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () => onEdit(patient),
                  icon: const Icon(Icons.edit_outlined, size: 16, color: Colors.blueGrey),
                  label: const Text(
                    'ویرایش',
                    style: TextStyle(
                      fontFamily: AppTypography.fontName,
                      color: Colors.blueGrey,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => onView(patient),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.08),
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: Icon(Icons.visibility_outlined, size: 16, color: theme.colorScheme.primary),
                  label: Text(
                    'مشاهده پرونده',
                    style: TextStyle(
                      fontFamily: AppTypography.fontName,
                      color: theme.colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value,
    bool isDark, {
    Color? valueColor,
    FontWeight? valueFontWeight,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: isDark ? AppColors.textSecondaryDark.withOpacity(0.7) : AppColors.textSecondaryLight.withOpacity(0.7),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontFamily: AppTypography.fontName,
            fontSize: 12,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontFamily: AppTypography.fontName,
            fontSize: 12,
            fontWeight: valueFontWeight ?? FontWeight.w500,
            color: valueColor ?? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
          ),
        ),
      ],
    );
  }
}
