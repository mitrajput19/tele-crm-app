class DashboardData {
  DailyDashboardDetails? today;
  DashboardProductivityDetails? productivity;
  DashboardQuarterlySummaryDetails? quarterlySummary;

  DashboardData({
    this.today,
    this.productivity,
    this.quarterlySummary,
  });

  DashboardData.fromJson(Map<String, dynamic> json) {
    today = json['today'] != null ? new DailyDashboardDetails.fromJson(json['today']) : null;
    productivity =
        json['productivity'] != null ? new DashboardProductivityDetails.fromJson(json['productivity']) : null;
    quarterlySummary = json['quarterly_summary'] != null
        ? new DashboardQuarterlySummaryDetails.fromJson(json['quarterly_summary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.today != null) {
      data['today'] = this.today!.toJson();
    }
    if (this.productivity != null) {
      data['productivity'] = this.productivity!.toJson();
    }
    if (this.quarterlySummary != null) {
      data['quarterly_summary'] = this.quarterlySummary!.toJson();
    }
    return data;
  }
}

class DailyDashboardDetails {
  String? dailyDuties;
  String? tasks;
  String? event;
  String? upcomingBreak;
  String? otherBreaks;
  String? other;

  DailyDashboardDetails({
    this.dailyDuties,
    this.tasks,
    this.event,
    this.upcomingBreak,
    this.otherBreaks,
    this.other,
  });

  DailyDashboardDetails.fromJson(Map<String, dynamic> json) {
    dailyDuties = json['daily_duties'];
    tasks = json['tasks'];
    event = json['event'];
    upcomingBreak = json['upcoming_break'];
    otherBreaks = json['other_breaks'];
    other = json['other'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['daily_duties'] = this.dailyDuties;
    data['tasks'] = this.tasks;
    data['event'] = this.event;
    data['upcoming_break'] = this.upcomingBreak;
    data['other_breaks'] = this.otherBreaks;
    data['other'] = this.other;
    return data;
  }
}

class DashboardProductivityDetails {
  String? completedOnTime;
  String? completedLate;
  String? overdue;
  int? dailyTasks;
  int? dailyTasksMaxLimit;
  int? scheduledTasks;
  int? scheduledTasksMaxLimit;

  DashboardProductivityDetails({
    this.completedOnTime,
    this.completedLate,
    this.overdue,
    this.dailyTasks,
    this.dailyTasksMaxLimit,
    this.scheduledTasks,
    this.scheduledTasksMaxLimit,
  });

  DashboardProductivityDetails.fromJson(Map<String, dynamic> json) {
    completedOnTime = json['completed_on_time'];
    completedLate = json['completed_late'];
    overdue = json['overdue'];
    dailyTasks = json['daily_tasks'];
    dailyTasksMaxLimit = json['daily_tasks_max_limit'];
    scheduledTasks = json['scheduled_tasks'];
    scheduledTasksMaxLimit = json['scheduled_tasks_max_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['completed_on_time'] = this.completedOnTime;
    data['completed_late'] = this.completedLate;
    data['overdue'] = this.overdue;
    data['daily_tasks'] = this.dailyTasks;
    data['daily_tasks_max_limit'] = this.dailyTasksMaxLimit;
    data['scheduled_tasks'] = this.scheduledTasks;
    data['scheduled_tasks_max_limit'] = this.scheduledTasksMaxLimit;
    return data;
  }
}

class DashboardQuarterlySummaryDetails {
  int? taskRating;
  int? punctuality;
  int? newSkills;
  int? holidays;
  int? daysOff;
  int? sickLeave;

  DashboardQuarterlySummaryDetails({
    this.taskRating,
    this.punctuality,
    this.newSkills,
    this.holidays,
    this.daysOff,
    this.sickLeave,
  });

  DashboardQuarterlySummaryDetails.fromJson(Map<String, dynamic> json) {
    taskRating = json['task_rating'];
    punctuality = json['punctuality'];
    newSkills = json['new_skills'];
    holidays = json['holidays'];
    daysOff = json['days_off'];
    sickLeave = json['sick_leave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_rating'] = this.taskRating;
    data['punctuality'] = this.punctuality;
    data['new_skills'] = this.newSkills;
    data['holidays'] = this.holidays;
    data['days_off'] = this.daysOff;
    data['sick_leave'] = this.sickLeave;
    return data;
  }
}
