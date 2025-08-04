
class Campaign {
  final String id;
  final String name;
  final String description;
  final String type; // 'call', 'whatsapp', 'email'
  final String status; // 'draft', 'active', 'paused', 'completed'
  final DateTime startDate;
  final DateTime? endDate;
  final List<String> targetLeadIds;
  final String? templateId;
  final Map<String, dynamic>? settings;
  final CampaignStats? stats;
  final String createdBy;
  final DateTime createdAt;

  Campaign({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.status,
    required this.startDate,
    this.endDate,
    required this.targetLeadIds,
    this.templateId,
    this.settings,
    this.stats,
    required this.createdBy,
    required this.createdAt,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    type: json['type'],
    status: json['status'],
    startDate: DateTime.parse(json['start_date']),
    endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
    targetLeadIds: (json['target_lead_ids'] as List).cast<String>(),
    templateId: json['template_id'],
    settings: json['settings'],
    stats: json['stats'] != null ? CampaignStats.fromJson(json['stats']) : null,
    createdBy: json['created_by'],
    createdAt: DateTime.parse(json['created_at']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'type': type,
    'status': status,
    'start_date': startDate.toIso8601String(),
    'end_date': endDate?.toIso8601String(),
    'target_lead_ids': targetLeadIds,
    'template_id': templateId,
    'settings': settings,
    'stats': stats?.toJson(),
    'created_by': createdBy,
    'created_at': createdAt.toIso8601String(),
  };
}

class CampaignStats {
  final int totalTargets;
  final int contacted;
  final int responded;
  final int converted;
  final double responseRate;
  final double conversionRate;

  CampaignStats({
    required this.totalTargets,
    required this.contacted,
    required this.responded,
    required this.converted,
    required this.responseRate,
    required this.conversionRate,
  });

  factory CampaignStats.fromJson(Map<String, dynamic> json) => CampaignStats(
    totalTargets: json['total_targets'],
    contacted: json['contacted'],
    responded: json['responded'],
    converted: json['converted'],
    responseRate: json['response_rate'].toDouble(),
    conversionRate: json['conversion_rate'].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'total_targets': totalTargets,
    'contacted': contacted,
    'responded': responded,
    'converted': converted,
    'response_rate': responseRate,
    'conversion_rate': conversionRate,
  };
}
