import '../../app/app.dart';

class LiveActivityServices {
  static String taskTimerMethodChannelKey = 'TaskTimerMethodChannel';
  static String taskTimerEventChannelKey = 'TaskTimerEventChannel';

  final _methodChannel = MethodChannel(taskTimerMethodChannelKey);
  final _eventChannel = EventChannel(taskTimerEventChannelKey);

  Future startLiveActivity({required Map<String, dynamic> data}) async {
    this.log(data, tag: 'startLiveActivity');
    try {
      await _methodChannel.invokeListMethod('startLiveActivity', data);
    } catch (e) {
      this.log(e, tag: 'Error : startLiveActivity');
    }
  } 

  Future stopLiveActivity({required Map<String, dynamic> data}) async {
    this.log(data, tag: 'stopLiveActivity');
    try {
      await _methodChannel.invokeListMethod('stopLiveActivity', data);
    } catch (e) {
      this.log(e, tag: 'Error : stopLiveActivity');
    }
  }

  Future getLiveActivityUri() async {
    try {
      var data = await _methodChannel.invokeMethod('getLiveActivityUri');
      return data;
    } catch (e) {
      this.log(e, tag: 'Error : getLiveActivityUri');
    }
  }

  Stream<String?> urlLiveActivityStream() {
    return _eventChannel.receiveBroadcastStream().map((data) => data.toString());
  }
}

class LiveActivityTaskTimerData {
  String? id;
  String? title;
  String? description;
  String? taskStepCode;

  LiveActivityTaskTimerData({
    this.id,
    this.title,
    this.description,
    this.taskStepCode,
  });

  LiveActivityTaskTimerData copyWith({
    String? id,
    String? title,
    String? description,
    String? taskStepCode,
  }) {
    return LiveActivityTaskTimerData(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      taskStepCode: taskStepCode ?? this.taskStepCode,
    );
  }

  LiveActivityTaskTimerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    taskStepCode = json['task_step_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['task_step_code'] = this.taskStepCode;
    return data;
  }
}
