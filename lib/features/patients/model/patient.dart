class Patient {
  final String id;
  final String fullName;
  final String nationalCode;
  final String phone;
  final int remainingSessions;
  final String lastVisit;
  final String status; // 'active' | 'inactive'
  final bool visitToday;

  const Patient({
    required this.id,
    required this.fullName,
    required this.nationalCode,
    required this.phone,
    required this.remainingSessions,
    required this.lastVisit,
    required this.status,
    required this.visitToday,
  });

  Patient copyWith({
    String? id,
    String? fullName,
    String? nationalCode,
    String? phone,
    int? remainingSessions,
    String? lastVisit,
    String? status,
    bool? visitToday,
  }) {
    return Patient(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      nationalCode: nationalCode ?? this.nationalCode,
      phone: phone ?? this.phone,
      remainingSessions: remainingSessions ?? this.remainingSessions,
      lastVisit: lastVisit ?? this.lastVisit,
      status: status ?? this.status,
      visitToday: visitToday ?? this.visitToday,
    );
  }
}
