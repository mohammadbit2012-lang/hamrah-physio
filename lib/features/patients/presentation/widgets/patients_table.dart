import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../model/patient.dart';

class PatientsTable extends StatelessWidget {
  final List<Patient> patients;
  final ValueChanged<Patient> onView;
  final ValueChanged<Patient> onEdit;

  const PatientsTable({
    super.key,
    required this.patients,
    required this.onView,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 24,
          headingRowColor: MaterialStateProperty.all(
            theme.colorScheme.primary.withOpacity(0.04),
          ),
          dataRowHeight: 64,
          headingRowHeight: 52,
          columns: [
            DataColumn(
              label: Text(
                'نام بیمار',
                style: TextStyle(
                  fontFamily: AppTypography.fontName,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'کد ملی',
                style: TextStyle(
                  fontFamily: AppTypography.fontName,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'شماره تماس',
                style: TextStyle(
                  fontFamily: AppTypography.fontName,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'جلسات باقی‌مانده',
                style: TextStyle(
                  fontFamily: AppTypography.fontName,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'آخرین مراجعه',
                style: TextStyle(
                  fontFamily: AppTypography.fontName,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'وضعیت',
                style: TextStyle(
                  fontFamily: AppTypography.fontName,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'عملیات',
                style: TextStyle(
                  fontFamily: AppTypography.fontName,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
              ),
            ),
          ],
          rows: patients.map((patient) {
            final isActive = patient.status == 'active';
            return DataRow(
              cells: [
                // Patient Name
                DataCell(
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                        child: Text(
                          patient.fullName.characters.take(1).toString(),
                          style: TextStyle(
                            fontFamily: AppTypography.fontName,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        patient.fullName,
                        style: TextStyle(
                          fontFamily: AppTypography.fontName,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                // National Code
                DataCell(
                  Text(
                    patient.nationalCode,
                    style: TextStyle(
                      fontFamily: AppTypography.fontName,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                ),
                // Phone
                DataCell(
                  Text(
                    patient.phone,
                    style: TextStyle(
                      fontFamily: AppTypography.fontName,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                ),
                // Remaining Sessions
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: patient.remainingSessions > 0
                          ? theme.colorScheme.primary.withOpacity(0.08)
                          : AppColors.error.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${patient.remainingSessions} جلسه',
                      style: TextStyle(
                        fontFamily: AppTypography.fontName,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: patient.remainingSessions > 0
                            ? theme.colorScheme.primary
                            : AppColors.error,
                      ),
                    ),
                  ),
                ),
                // Last Visit
                DataCell(
                  Text(
                    patient.lastVisit,
                    style: TextStyle(
                      fontFamily: AppTypography.fontName,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                ),
                // Status Chip
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: isActive ? AppColors.success : AppColors.textSecondaryLight,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isActive ? 'فعال' : 'غیرفعال',
                          style: TextStyle(
                            fontFamily: AppTypography.fontName,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isActive ? AppColors.success : AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Actions (View, Edit icons only)
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.visibility_outlined,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        tooltip: 'مشاهده پرونده',
                        onPressed: () => onView(patient),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit_outlined,
                          size: 20,
                          color: Colors.blueGrey,
                        ),
                        tooltip: 'ویرایش پرونده',
                        onPressed: () => onEdit(patient),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
