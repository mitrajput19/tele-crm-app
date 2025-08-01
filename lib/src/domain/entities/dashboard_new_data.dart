class DashboardNewData {
  DashboardReservations? reservations;
  DashboardTasks? tasks;
  DashboardProductivity? productivity;

  DashboardNewData({
    this.reservations,
    this.tasks,
    this.productivity,
  });

  DashboardNewData.fromJson(Map<String, dynamic> json) {
    reservations = json['reservations'] != null ? new DashboardReservations.fromJson(json['reservations']) : null;
    tasks = json['tasks'] != null ? new DashboardTasks.fromJson(json['tasks']) : null;
    productivity = json['productivity'] != null ? new DashboardProductivity.fromJson(json['productivity']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reservations != null) {
      data['reservations'] = this.reservations!.toJson();
    }
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.toJson();
    }
    if (this.productivity != null) {
      data['productivity'] = this.productivity!.toJson();
    }
    return data;
  }

  static DashboardNewData get dummyData => DashboardNewData.fromJson({
        'reservations': {
          'arrivals': '26',
          'departures': '22',
          'in_house': '24',
        },
        'tasks': {
          'in_progress': '14',
          'upcoming': '18',
          'completed': '16',
        },
        'productivity': {
          'completed_on_time': '98%',
          'completed_late': '16%',
          'overdue_tasks': '24%',
        },
      });
}

class DashboardReservations {
  String? arrivals;
  String? departures;
  String? inHouse;

  DashboardReservations({
    this.arrivals,
    this.departures,
    this.inHouse,
  });

  DashboardReservations.fromJson(Map<String, dynamic> json) {
    arrivals = json['arrivals'];
    departures = json['departures'];
    inHouse = json['in_house'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arrivals'] = this.arrivals;
    data['departures'] = this.departures;
    data['in_house'] = this.inHouse;
    return data;
  }
}

class DashboardTasks {
  String? inProgress;
  String? upcoming;
  String? completed;

  DashboardTasks({
    this.inProgress,
    this.upcoming,
    this.completed,
  });

  DashboardTasks.fromJson(Map<String, dynamic> json) {
    inProgress = json['in_progress'];
    upcoming = json['upcoming'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['in_progress'] = this.inProgress;
    data['upcoming'] = this.upcoming;
    data['completed'] = this.completed;
    return data;
  }
}

class DashboardProductivity {
  String? completedOnTime;
  String? completedLate;
  String? overdueTasks;

  DashboardProductivity({
    this.completedOnTime,
    this.completedLate,
    this.overdueTasks,
  });

  DashboardProductivity.fromJson(Map<String, dynamic> json) {
    completedOnTime = json['completed_on_time'];
    completedLate = json['completed_late'];
    overdueTasks = json['overdue_tasks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['completed_on_time'] = this.completedOnTime;
    data['completed_late'] = this.completedLate;
    data['overdue_tasks'] = this.overdueTasks;
    return data;
  }
}
