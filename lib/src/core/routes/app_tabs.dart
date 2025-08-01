import '../../app/app.dart';

enum AppTabScreen {
  home,
  tasks,
  shifts,
  chats,
  alerts,
  dashboard,
  leaves,
  payslips,
  expenses,
  roomCalendar,
  revenueManagement,
  reservationsManagement,
  frontDeskCalender,
  propertyTransactions,
  currencyConvertor,
  // restaurantOld,
  restaurant,
}

extension AppTabScreenExtension on AppTabScreen {
  static final Map<AppTabScreen, (String, String)> _tabIconMap = {
    AppTabScreen.home: (AppIcons.homeTabOutlined, AppIcons.homeTabFilled),
    AppTabScreen.tasks: (AppIcons.tasksTabOutlined, AppIcons.tasksTabFilled),
    AppTabScreen.shifts: (AppIcons.shiftsTabOutlined, AppIcons.shiftsTabFilled),
    // AppTabScreen.calls: (AppIcons.callsTabOutlined, AppIcons.callsTabFilled),
    AppTabScreen.chats: (AppIcons.chatsTabOutlined, AppIcons.chatsTabFilled),
    AppTabScreen.alerts: (AppIcons.alertsTabOutlined, AppIcons.alertsTabFilled),
  };

  static final Map<AppTabScreen, (Widget, String)> _tabInfoMap = {
   
    
  };

  String getTabBarIcon({required bool isSelected}) {
    final icons = _tabIconMap[this];
    if (icons == null) return '';
    return isSelected ? icons.$2 : icons.$1;
  }

  Widget get screen => _tabInfoMap[this]?.$1 ?? SizedBox();

  String get label => _tabInfoMap[this]?.$2 ?? '';

  bool get isMainTab => index <= AppTabScreen.alerts.index;
}
