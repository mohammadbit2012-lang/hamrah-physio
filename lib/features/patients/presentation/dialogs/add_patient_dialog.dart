import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../model/patient.dart';
import '../../controller/patients_controller.dart';

/// A production-quality Dialog to register/add a new patient file.
class AddPatientDialog extends ConsumerStatefulWidget {
  const AddPatientDialog({super.key});

  @override
  ConsumerState<AddPatientDialog> createState() => _AddPatientDialogState();
}

class _AddPatientDialogState extends ConsumerState<AddPatientDialog> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _nationalCode = '';
  String _phone = '';
  int _sessions = 10;
  final String _status = 'active';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        title: const Text(
          'ثبت پرونده بیمار جدید',
          style: TextStyle(
            fontFamily: AppTypography.fontName,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'نام و نام خانوادگی بیمار',
                    labelStyle: TextStyle(fontFamily: AppTypography.fontName),
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'نام الزامی است' : null,
                  onSaved: (v) => _fullName = v ?? '',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'کد ملی',
                    labelStyle: TextStyle(fontFamily: AppTypography.fontName),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) => v == null || v.length < 10 ? 'کد ملی معتبر نیست' : null,
                  onSaved: (v) => _nationalCode = v ?? '',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'شماره تماس',
                    labelStyle: TextStyle(fontFamily: AppTypography.fontName),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (v) => v == null || v.length < 11 ? 'شماره تماس معتبر نیست' : null,
                  onSaved: (v) => _phone = v ?? '',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'تعداد جلسات اولیه',
                    labelStyle: TextStyle(fontFamily: AppTypography.fontName),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: '10',
                  onSaved: (v) => _sessions = int.tryParse(v ?? '') ?? 10,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'انصراف',
              style: TextStyle(fontFamily: AppTypography.fontName),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
            ),
            onPressed: _submitForm,
            child: const Text(
              'ثبت پرونده',
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

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final newPatient = Patient(
        id: 'P${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
        fullName: _fullName,
        nationalCode: _nationalCode,
        phone: _phone,
        remainingSessions: _sessions,
        lastVisit: '۱۴۰۵/۰۴/۱۶',
        status: _status,
        visitToday: true,
      );

      ref.read(patientsControllerProvider.notifier).addPatient(newPatient);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'پرونده بیمار با موفقیت ثبت شد.',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontFamily: AppTypography.fontName),
          ),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }
}
