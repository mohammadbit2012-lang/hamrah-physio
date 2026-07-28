import '../model/patient.dart';

sealed class PatientsState {
  const PatientsState();
}

class PatientsLoading extends PatientsState {
  const PatientsLoading();
}

class PatientsLoaded extends PatientsState {
  final List<Patient> allPatients;
  final List<Patient> filteredPatients;
  final String searchQuery;
  final String activeFilter; // 'all' | 'active' | 'inactive' | 'today'
  final int currentPage;

  const PatientsLoaded({
    required this.allPatients,
    required this.filteredPatients,
    required this.searchQuery,
    required this.activeFilter,
    this.currentPage = 1,
  });

  PatientsLoaded copyWith({
    List<Patient>? allPatients,
    List<Patient>? filteredPatients,
    String? searchQuery,
    String? activeFilter,
    int? currentPage,
  }) {
    return PatientsLoaded(
      allPatients: allPatients ?? this.allPatients,
      filteredPatients: filteredPatients ?? this.filteredPatients,
      searchQuery: searchQuery ?? this.searchQuery,
      activeFilter: activeFilter ?? this.activeFilter,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class PatientsEmpty extends PatientsState {
  const PatientsEmpty();
}

class PatientsError extends PatientsState {
  final String message;
  const PatientsError(this.message);
}
