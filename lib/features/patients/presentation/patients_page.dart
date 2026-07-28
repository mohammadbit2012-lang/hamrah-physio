import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../model/patient.dart';
import '../controller/patients_state.dart';
import '../controller/patients_controller.dart';
import 'widgets/patient_search_bar.dart';
import 'widgets/patient_filter_bar.dart';
import 'widgets/patient_page_header.dart';
import 'widgets/patient_state_renderer.dart';
import 'dialogs/add_patient_dialog.dart';
import 'dialogs/edit_patient_dialog.dart';
import 'dialogs/patient_details_dialog.dart';

/// A production-quality Patients page, refactored to conform to Clean Architecture.
/// Contains only high-level layout routing and delegates all rendering/logic.
class PatientsPage extends ConsumerWidget {
  const PatientsPage({super.key});

  void _showNewPatientDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddPatientDialog(),
    );
  }

  void _showPatientDetails(BuildContext context, Patient patient) {
    showDialog(
      context: context,
      builder: (context) => PatientDetailsDialog(patient: patient),
    );
  }

  void _showEditPatientDialog(BuildContext context, Patient patient) {
    showDialog(
      context: context,
      builder: (context) => EditPatientDialog(patient: patient),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1000;

    final state = ref.watch(patientsControllerProvider);

    return Container(
      color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Page Header (Title & Action CTAs)
          PatientPageHeader(
            isDesktop: isDesktop,
            onClearList: () {
              ref.read(patientsControllerProvider.notifier).setEmpty();
            },
            onAddPatient: () => _showNewPatientDialog(context),
          ),

          // 2. Search & Filter Bar Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: isDesktop
                ? Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: PatientSearchBar(
                          initialValue: state is PatientsLoaded ? state.searchQuery : '',
                          onChanged: (q) => ref
                              .read(patientsControllerProvider.notifier)
                              .searchPatients(q),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: PatientFilterBar(
                          selectedFilter: state is PatientsLoaded ? state.activeFilter : 'all',
                          onFilterChanged: (f) => ref
                              .read(patientsControllerProvider.notifier)
                              .filterPatients(f),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      PatientSearchBar(
                        initialValue: state is PatientsLoaded ? state.searchQuery : '',
                        onChanged: (q) => ref
                            .read(patientsControllerProvider.notifier)
                            .searchPatients(q),
                      ),
                      const SizedBox(height: 12),
                      PatientFilterBar(
                        selectedFilter: state is PatientsLoaded ? state.activeFilter : 'all',
                        onFilterChanged: (f) => ref
                            .read(patientsControllerProvider.notifier)
                            .filterPatients(f),
                      ),
                    ],
                  ),
          ),

          const SizedBox(height: 16),

          // 3. Clean Layout State Router
          Expanded(
            child: PatientStateRenderer(
              state: state,
              isDesktop: isDesktop,
              onViewPatient: (patient) => _showPatientDetails(context, patient),
              onEditPatient: (patient) => _showEditPatientDialog(context, patient),
              onAddFirstPatient: () => _showNewPatientDialog(context),
            ),
          ),
        ],
      ),
    );
  }
}
