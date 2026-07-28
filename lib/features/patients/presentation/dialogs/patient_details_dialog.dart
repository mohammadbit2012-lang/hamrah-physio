import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../model/patient.dart';

/// A production-quality Dialog to view detailed information of a patient.
class PatientDetailsDialog extends StatelessWidget {
  final Patient patient;

  const PatientDetailsDialog({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        title: Row(
          children: [
            const Icon(Icons.person_pin_rounded, color: AppColors.primaryLight),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                patient.fullName,
                style: const TextStyle(
                  fontFamily: AppTypography.fontName,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailItem('شماره پرونده', patient.id),
            _buildDetailItem('کد ملی', patient.nationalCode),
            _buildDetailItem('شماره تماس', patient.phone),
            _buildDetailItem('جلسات باقی‌مانده', '${patient.remainingSessions} جلسه'),
            _buildDetailItem('تاریخ آخرین مراجعه', patient.lastVisit),
            _buildDetailItem('وضعیت پرونده', patient.status == 'active' ? 'فعال' : 'غیرفعال'),
            _buildDetailItem('دارای نوبت در امروز', patient.visitToday ? 'بله' : 'خیر'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'بستن',
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

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontFamily: AppTypography.fontName,
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: AppTypography.fontName,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
