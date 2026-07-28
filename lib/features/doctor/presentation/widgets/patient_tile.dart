import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/config/theme/app_colors.dart';

enum PatientVisitStatus {
  waiting,
  inProgress,
  completed,
}

class PatientData {
  final String name;
  final String time;
  final String condition;
  final PatientVisitStatus status;
  final String avatarLetter;
  final Color avatarBgColor;

  const PatientData({
    required this.name,
    required this.time,
    required this.condition,
    required this.status,
    required this.avatarLetter,
    required this.avatarBgColor,
  });
}

class PatientTile extends StatelessWidget {
  final PatientData patient;
  final VoidCallback? onTap;

  const PatientTile({
    super.key,
    required this.patient,
    this.onTap,
  });

  String _getStatusText(PatientVisitStatus status) {
    switch (status) {
      case PatientVisitStatus.waiting:
        return 'در انتظار';
      case PatientVisitStatus.inProgress:
        return 'در حال درمان';
      case PatientVisitStatus.completed:
        return 'ویزیت شده';
    }
  }

  Color _getStatusColor(PatientVisitStatus status) {
    switch (status) {
      case PatientVisitStatus.waiting:
        return AppColors.warning;
      case PatientVisitStatus.inProgress:
        return AppColors.info;
      case PatientVisitStatus.completed:
        return AppColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final statusColor = _getStatusColor(patient.status);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isDark ? 0 : 1,
      shadowColor: Colors.black.withOpacity(0.02),
      color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap ?? () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'مشاهده جزئیات پرونده ' + patient.name,
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontFamily: AppTypography.fontName),
              ),
              backgroundColor: theme.colorScheme.primary,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Left Section - Time & Status Badge
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        patient.time,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontFamily: AppTypography.fontName,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Status Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getStatusText(patient.status),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: AppTypography.fontName,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Right Section - Info, Name, Condition, Avatar
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            patient.name,
                            textAlign: TextAlign.end,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontFamily: AppTypography.fontName,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: (isDark ? AppColors.borderDark : AppColors.borderLight).withOpacity(0.4),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              patient.condition,
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontFamily: AppTypography.fontName,
                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Beautiful Avatar
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: patient.avatarBgColor.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: patient.avatarBgColor.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          patient.avatarLetter,
                          style: TextStyle(
                            fontFamily: AppTypography.fontName,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: patient.avatarBgColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
