import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/config/theme/app_colors.dart';
import 'patient_tile.dart';

class TodayPatientsList extends StatelessWidget {
  const TodayPatientsList({super.key});

  static const List<PatientData> _fakePatients = [
    PatientData(
      name: 'سارا احمدی',
      time: '۰۸:۳۰',
      condition: 'دیسک کمر (L4-L5)',
      status: PatientVisitStatus.completed,
      avatarLetter: 'س',
      avatarBgColor: AppColors.primaryLight,
    ),
    PatientData(
      name: 'رضا محسنی',
      time: '۰۹:۱۵',
      condition: 'پارگی رباط صلیبی (ACL)',
      status: PatientVisitStatus.inProgress,
      avatarLetter: 'ر',
      avatarBgColor: AppColors.info,
    ),
    PatientData(
      name: 'مهدی علوی',
      time: '۱۰:۰۰',
      condition: 'کمردرد مزمن',
      status: PatientVisitStatus.waiting,
      avatarLetter: 'م',
      avatarBgColor: AppColors.warning,
    ),
    PatientData(
      name: 'نرگس محمدی',
      time: '۱۰:۴۵',
      condition: 'فلج بلز (صورت)',
      status: PatientVisitStatus.waiting,
      avatarLetter: 'ن',
      avatarBgColor: Colors.purple,
    ),
    PatientData(
      name: 'حسین حسینی',
      time: '۱۱:۳۰',
      condition: 'آسیب روتاتور کاف شانه',
      status: PatientVisitStatus.waiting,
      avatarLetter: 'ح',
      avatarBgColor: Colors.deepOrange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'نمایش تمام بیماران امروز',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontFamily: AppTypography.fontName),
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.chevron_left_rounded,
                      size: 18,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'مشاهده همه',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: AppTypography.fontName,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'لیست بیماران امروز',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontFamily: AppTypography.fontName,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Patients List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _fakePatients.length,
            itemBuilder: (context, index) {
              return PatientTile(patient: _fakePatients[index]);
            },
          ),
        ],
      ),
    );
  }
}
