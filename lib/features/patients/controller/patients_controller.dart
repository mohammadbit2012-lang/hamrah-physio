import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/fake_patients_repository.dart';
import '../model/patient.dart';
import 'patients_state.dart';

class PatientsController extends StateNotifier<PatientsState> {
  final FakePatientsRepository _repository;

  PatientsController(this._repository) : super(const PatientsLoading()) {
    loadPatients();
  }

  Future<void> loadPatients() async {
    state = const PatientsLoading();
    try {
      final list = await _repository.getPatients();
      if (list.isEmpty) {
        state = const PatientsEmpty();
      } else {
        state = PatientsLoaded(
          allPatients: list,
          filteredPatients: list,
          searchQuery: '',
          activeFilter: 'all',
          currentPage: 1,
        );
      }
    } catch (e) {
      state = PatientsError(e.toString());
    }
  }

  void searchPatients(String query) {
    final currentState = state;
    if (currentState is PatientsLoaded) {
      _applyFilterAndSearch(
        all: currentState.allPatients,
        search: query,
        filter: currentState.activeFilter,
      );
    }
  }

  void filterPatients(String filter) {
    final currentState = state;
    if (currentState is PatientsLoaded) {
      _applyFilterAndSearch(
        all: currentState.allPatients,
        search: currentState.searchQuery,
        filter: filter,
      );
    }
  }

  void setPage(int page) {
    final currentState = state;
    if (currentState is PatientsLoaded) {
      state = currentState.copyWith(currentPage: page);
    }
  }

  void addPatient(Patient patient) {
    final currentState = state;
    if (currentState is PatientsLoaded) {
      final updatedAll = [patient, ...currentState.allPatients];
      _applyFilterAndSearch(
        all: updatedAll,
        search: currentState.searchQuery,
        filter: currentState.activeFilter,
      );
    } else if (state is PatientsEmpty) {
      final updatedAll = [patient];
      state = PatientsLoaded(
        allPatients: updatedAll,
        filteredPatients: updatedAll,
        searchQuery: '',
        activeFilter: 'all',
        currentPage: 1,
      );
    }
  }

  void updatePatient(Patient updatedPatient) {
    final currentState = state;
    if (currentState is PatientsLoaded) {
      final updatedAll = currentState.allPatients.map((p) {
        return p.id == updatedPatient.id ? updatedPatient : p;
      }).toList();
      _applyFilterAndSearch(
        all: updatedAll,
        search: currentState.searchQuery,
        filter: currentState.activeFilter,
      );
    }
  }

  void setEmpty() {
    state = const PatientsEmpty();
  }

  void _applyFilterAndSearch({
    required List<Patient> all,
    required String search,
    required String filter,
  }) {
    List<Patient> result = all;

    // 1. Filter
    if (filter == 'active') {
      result = result.where((p) => p.status == 'active').toList();
    } else if (filter == 'inactive') {
      result = result.where((p) => p.status == 'inactive').toList();
    } else if (filter == 'today') {
      result = result.where((p) => p.visitToday).toList();
    }

    // 2. Search
    if (search.isNotEmpty) {
      final query = search.trim();
      result = result.where((p) {
        return p.fullName.contains(query) ||
            p.nationalCode.contains(query) ||
            p.phone.contains(query) ||
            p.id.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    state = PatientsLoaded(
      allPatients: all,
      filteredPatients: result,
      searchQuery: search,
      activeFilter: filter,
      currentPage: 1, // Reset to page 1 on search/filter
    );
  }
}

final fakePatientsRepositoryProvider = Provider<FakePatientsRepository>((ref) {
  return FakePatientsRepository();
});

final patientsControllerProvider = StateNotifierProvider<PatientsController, PatientsState>((ref) {
  final repo = ref.watch(fakePatientsRepositoryProvider);
  return PatientsController(repo);
});
