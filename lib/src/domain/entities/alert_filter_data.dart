import 'dart:convert';

class AlertFilterData {
  bool? isRead;
  bool? isUnRead;
  bool? isGeneral;
  bool? isTask;
  bool? isShift;

  AlertFilterData({
    this.isRead = false,
    this.isUnRead = false,
    this.isGeneral = false,
    this.isTask = false,
    this.isShift = false,
  });

  AlertFilterData copyWith({
    bool? isRead,
    bool? isUnRead,
    bool? isGeneral,
    bool? isTask,
    bool? isShift,
  }) {
    return AlertFilterData(
      isRead: isRead ?? this.isRead,
      isUnRead: isUnRead ?? this.isUnRead,
      isGeneral: isGeneral ?? this.isGeneral,
      isTask: isTask ?? this.isTask,
      isShift: isShift ?? this.isShift,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isRead': isRead,
      'isUnRead': isUnRead,
      'isGeneral': isGeneral,
      'isTask': isTask,
      'isShift': isShift,
    };
  }

  factory AlertFilterData.fromMap(Map<String, dynamic> map) {
    return AlertFilterData(
      isRead: map['isRead'] != null ? map['isRead'] as bool : null,
      isUnRead: map['isUnRead'] != null ? map['isUnRead'] as bool : null,
      isGeneral: map['isGeneral'] != null ? map['isGeneral'] as bool : null,
      isTask: map['isTask'] != null ? map['isTask'] as bool : null,
      isShift: map['isShift'] != null ? map['isShift'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlertFilterData.fromJson(String source) =>
      AlertFilterData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AlertfilterModel(isRead: $isRead, isUnRead: $isUnRead, isGeneral: $isGeneral, isTask: $isTask, isShift: $isShift)';
  }
}
