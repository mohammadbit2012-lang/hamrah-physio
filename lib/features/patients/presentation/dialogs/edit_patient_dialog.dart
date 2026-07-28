import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../model/patient.dart';
import '../../controller/patients_controller.dart';

/// A production-quality Dialog to edit an existing patient file.
class EditPatientDialog extends ConsumerStatefulWidget {
  final Patient patient;

  const EditPatientDialog({
    super.key,
    required this.patient,
  });

  @override
  ConsumerState<EditPatientDialog> createState() => _EditPatientDialogState();
}

class _EditPatientDialogState extends ConsumerState<EditPatientDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _fullName;
  late String _nationalCode;
  late String _phone;
  late int _sessions;
  late String _status;

  @override
  void initState() {
    super.initState();
    _fullName = widget.patient.fullName;
    _nationalCode = widget.patient.nationalCode;
    _phone = widget.patient.phone;
    _sessions = widget.patient.remainingSessions;
    _status = widget.patient.status;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        title: Text(
          'ویرایش پرونده ${widget.patient.fullName}',
          style: const TextStyle(
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
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.patient.fullName,
                  validator: (v) => v == null || v.isEmpty ? 'نام الزامی است' : null,
                  onSaved: (v) => _fullName = v ?? '',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'کد ملی',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.patient.nationalCode,
                  keyboardType: TextInputType.number,
                  validator: (v) => v == null || v.length < 10 ? 'کد ملی معتبر نیست' : null,
                  onSaved: (v) => _nationalCode = v ?? '',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'شماره تماس',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.patient.phone,
                  keyboardType: TextInputType.phone,
                  validator: (v) => v == null || v.length < 11 ? 'شماره تماس معتبر نیست' : null,
                  onSaved: (v) => _phone = v ?? '',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'جلسات باقی‌مانده',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.patient.remainingSessions.toString(),
                  keyboardType: TextInputType.number,
                  onSaved: (v) => _sessions = int.tryParse(v ?? '') ?? widget.patient.remainingSessions,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _status,
                  decoration: const InputDecoration(
                    labelText: 'وضعیت پرونده',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'active', child: Text('فعال')),
                    DropdownMenuItem(value: 'inactive', child: Text('غیرفعال')),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _status = val;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('انصراف'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
            ),
            onPressed: _saveChanges,
            child: const Text('ذخیره تغییرات'),
          ),
        ],
      ),
    );
  }

  void _saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final updatedPatient = widget.patient.copyWith(
        fullName: _fullName,
        nationalCode: _nationalCode,
        phone: _phone,
        remainingSessions: _sessions,
        status: _status,
      );

      ref.read(patientsControllerProvider.notifier).updatePatient(updatedPatient);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'پرونده ${widget.patient.fullName} با موفقیت ویرایش شد.',
            textDirection: TextDirection.rtl,
            style: const TextStyle(fontFamily: AppTypography.fontName),
          ),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }
}
