import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../model/patient.dart';
import '../../controller/patients_state.dart';
import '../../controller/patients_controller.dart';
import 'empty_patients.dart';
import 'loading_patients.dart';
import 'patient_card.dart';
import 'patient_pagination.dart';
import 'patients_table.dart';

/// A production-quality state router/renderer for the Patients module,
/// implementing the Clean Architecture approach by decoupling layout state.
class PatientStateRenderer extends ConsumerWidget {
  final PatientsState state;
  final bool isDesktop;
  final ValueChanged<Patient> onViewPatient;
  final ValueChanged<Patient> onEditPatient;
  final VoidCallback onAddFirstPatient;

  const PatientStateRenderer({
    super.key,
    required this.state,
    required this.isDesktop,
    required this.onViewPatient,
    required this.onEditPatient,
    required this.onAddFirstPatient,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (state is PatientsLoading) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: LoadingPatients(),
      );
    }

    if (state is PatientsEmpty) {
      return EmptyPatients(
        onAddFirstPatient: onAddFirstPatient,
      );
    }

    if (state is PatientsError) {
      final errorMessage = (state as PatientsError).message;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              'خطایی رخ داده است: $errorMessage',
              style: const TextStyle(
                fontFamily: AppTypography.fontName,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(patientsControllerProvider.notifier).loadPatients(),
              child: const Text(
                'تلاش مجدد',
                style: TextStyle(fontFamily: AppTypography.fontName),
              ),
            ),
          ],
        ),
      );
    }

    if (state is PatientsLoaded) {
      final loadedState = state as PatientsLoaded;
      final filteredList = loadedState.filteredPatients;

      if (filteredList.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.search_off_rounded,
                size: 48,
                color: Colors.blueGrey,
              ),
              const SizedBox(height: 16),
              const Text(
                'بیماری با این مشخصات یافت نشد.',
                style: TextStyle(
                  fontFamily: AppTypography.fontName,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  ref.read(patientsControllerProvider.notifier).searchPatients('');
                  ref.read(patientsControllerProvider.notifier).filterPatients('all');
                },
                child: const Text(
                  'پاک کردن فیلترها',
                  style: TextStyle(fontFamily: AppTypography.fontName),
                ),
              ),
            ],
          ),
        );
      }

      // Real interactive Pagination Math
      const itemsPerPage = 5;
      final totalItems = filteredList.length;
      final totalPages = (totalItems / itemsPerPage).ceil();
      final currentPage = loadedState.currentPage > totalPages ? 1 : loadedState.currentPage;

      final startIndex = (currentPage - 1) * itemsPerPage;
      final endIndex = startIndex + itemsPerPage > totalItems
          ? totalItems
          : startIndex + itemsPerPage;

      final pagedList = filteredList.sublist(startIndex, endIndex);

      return Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              child: isDesktop
                  ? PatientsTable(
                      patients: pagedList,
                      onView: onViewPatient,
                      onEdit: onEditPatient,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: pagedList.length,
                      itemBuilder: (context, index) {
                        return PatientCard(
                          patient: pagedList[index],
                          onView: onViewPatient,
                          onEdit: onEditPatient,
                        );
                      },
                    ),
            ),
          ),
          
          // Reusable Interactive Pagination Widget
          PatientPagination(
            currentPage: currentPage,
            totalPages: totalPages,
            onPageChanged: (pageNum) {
              ref.read(patientsControllerProvider.notifier).setPage(pageNum);
            },
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
