class DashboardKpiWidgetData {
  num? widgetId;
  String? title;
  String? tooltip;
  DashboardKpiCardData? valueOne;
  DashboardKpiCardData? valueTwo;
  DashboardKpiCardData? valueThree;
  DashboardKpiComparison? comparison;

  DashboardKpiWidgetData({
    this.widgetId,
    this.title,
    this.tooltip,
    this.valueOne,
    this.valueTwo,
    this.valueThree,
    this.comparison,
  });

  DashboardKpiWidgetData.fromJson(Map<String, dynamic> json) {
    widgetId = json['widget_id'];
    title = json['title'];
    tooltip = json['tooltip'];
    valueOne = json['value_1'] != null ? new DashboardKpiCardData.fromJson(json['value_1']) : null;
    valueTwo = json['value_2'] != null ? new DashboardKpiCardData.fromJson(json['value_2']) : null;
    valueThree = json['value_3'] != null ? new DashboardKpiCardData.fromJson(json['value_3']) : null;
    comparison = json['comparison'] != null ? new DashboardKpiComparison.fromJson(json['comparison']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['widget_id'] = this.widgetId;
    data['title'] = this.title;
    data['tooltip'] = this.tooltip;
    if (this.valueOne != null) {
      data['value_1'] = this.valueOne!.toJson();
    }
    if (this.valueTwo != null) {
      data['value_2'] = this.valueTwo!.toJson();
    }
    if (this.valueThree != null) {
      data['value_3'] = this.valueThree!.toJson();
    }
    if (this.comparison != null) {
      data['comparison'] = this.comparison!.toJson();
    }
    return data;
  }

  static List<DashboardKpiWidgetData> listFromJson(dynamic json) {
    List<DashboardKpiWidgetData> list = [];
    if (json['details']['kpis'] != null) {
      json['details']['kpis'].forEach((v) {
        list.add(new DashboardKpiWidgetData.fromJson(v));
      });
    }
    return list;
  }
}

class DashboardKpiCardData {
  String? label;
  String? display;
  num? count;

  DashboardKpiCardData({
    this.label,
    this.display,
    this.count,
  });

  DashboardKpiCardData.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    display = json['display'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['display'] = this.display;
    data['count'] = this.count;
    return data;
  }
}

class DashboardKpiComparison {
  String? percentageDisplay;
  String? percentageDisplayFull;
  num? percentageChange;
  String? trend;
  String? trendColorCode;

  DashboardKpiComparison({
    this.percentageDisplay,
    this.percentageDisplayFull,
    this.percentageChange,
    this.trend,
    this.trendColorCode,
  });

  DashboardKpiComparison.fromJson(Map<String, dynamic> json) {
    percentageDisplay = json['percentage_display'];
    percentageDisplayFull = json['percentage_display_full'];
    percentageChange = json['percentage_change'];
    trend = json['trend'];
    trendColorCode = json['trend_color_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['percentage_display'] = this.percentageDisplay;
    data['percentage_display_full'] = this.percentageDisplayFull;
    data['percentage_change'] = this.percentageChange;
    data['trend'] = this.trend;
    data['trend_color_code'] = this.trendColorCode;
    return data;
  }
}
