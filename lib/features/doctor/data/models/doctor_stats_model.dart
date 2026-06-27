class DoctorStatsModel {
  final int appointmentsThisMonth;
  final int appointmentsLastMonth;
  final int pendingCount;
  final int totalPatients;
  final int? acceptanceRate;

  const DoctorStatsModel({
    required this.appointmentsThisMonth,
    required this.appointmentsLastMonth,
    required this.pendingCount,
    required this.totalPatients,
    this.acceptanceRate,
  });

  factory DoctorStatsModel.fromJson(Map<String, dynamic> j) => DoctorStatsModel(
        appointmentsThisMonth: j['appointments_this_month'] as int? ?? 0,
        appointmentsLastMonth: j['appointments_last_month'] as int? ?? 0,
        pendingCount: j['pending_count'] as int? ?? 0,
        totalPatients: j['total_patients'] as int? ?? 0,
        acceptanceRate: j['acceptance_rate'] as int?,
      );
}
