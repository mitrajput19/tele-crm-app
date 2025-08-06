
class DashboardStats {
  final int totalLeads;
  final int pendingCalls;
  final int completedCalls;
  final int todayCalls;
  final int connectedCalls;
  final int missedCalls;
  final double conversionRate;
  final double averageCallDuration;
  final List<CallStatusCount> callStatusBreakdown;
  final List<HourlyCallData> hourlyCallData;

  DashboardStats({
    required this.totalLeads,
    required this.pendingCalls,
    required this.completedCalls,
    required this.todayCalls,
    required this.connectedCalls,
    required this.missedCalls,
    required this.conversionRate,
    required this.averageCallDuration,
    required this.callStatusBreakdown,
    required this.hourlyCallData,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) => DashboardStats(
    totalLeads: json['total_leads'] ?? 0,
    pendingCalls: json['pending_calls'] ?? 0,
    completedCalls: json['completed_calls'] ?? 0,
    todayCalls: json['today_calls'] ?? 0,
    connectedCalls: json['connected_calls'] ?? 0,
    missedCalls: json['missed_calls'] ?? 0,
    conversionRate: (json['conversion_rate'] ?? 0.0).toDouble(),
    averageCallDuration: (json['average_call_duration'] ?? 0.0).toDouble(),
    callStatusBreakdown: (json['call_status_breakdown'] as List?)
        ?.map((e) => CallStatusCount.fromJson(e))
        .toList() ?? [],
    hourlyCallData: (json['hourly_call_data'] as List?)
        ?.map((e) => HourlyCallData.fromJson(e))
        .toList() ?? [],
  );

  Map<String, dynamic> toJson() => {
    'total_leads': totalLeads,
    'pending_calls': pendingCalls,
    'completed_calls': completedCalls,
    'today_calls': todayCalls,
    'connected_calls': connectedCalls,
    'missed_calls': missedCalls,
    'conversion_rate': conversionRate,
    'average_call_duration': averageCallDuration,
  };
}

class CallStatusCount {
  final String status;
  final int count;
  final String color;

  CallStatusCount({
    required this.status,
    required this.count,
    required this.color,
  });

  factory CallStatusCount.fromJson(Map<String, dynamic> json) => CallStatusCount(
    status: json['status'],
    count: json['count'],
    color: json['color'],
  );
}

class HourlyCallData {
  final int hour;
  final int callCount;
  final int connectedCount;

  HourlyCallData({
    required this.hour,
    required this.callCount,
    required this.connectedCount,
  });

  factory HourlyCallData.fromJson(Map<String, dynamic> json) => HourlyCallData(
    hour: json['hour'],
    callCount: json['call_count'],
    connectedCount: json['connected_count'],
  );
}
