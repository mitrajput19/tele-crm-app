class CallLogEntry {
  final String? number;
  final String? name;
  final int? timestamp;
  final int? duration;
  final String? callType;

  CallLogEntry({
    this.number,
    this.name,
    this.timestamp,
    this.duration,
    this.callType,
  });

  factory CallLogEntry.fromMap(Map<String, dynamic> map) {
    return CallLogEntry(
      number: map['number'],
      name: map['name'],
      timestamp: map['timestamp'],
      duration: map['duration'],
      callType: map['type'],
    );
  }

  DateTime get callDate => DateTime.fromMillisecondsSinceEpoch(timestamp ?? 0);
  
  String get formattedDuration {
    if (duration == null || duration == 0) return '0:00';
    final minutes = (duration! ~/ 60);
    final seconds = (duration! % 60);
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  String get displayName => name?.isNotEmpty == true ? name! : number ?? 'Unknown';
}