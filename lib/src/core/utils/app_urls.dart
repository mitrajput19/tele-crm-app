class AppUrls {
  AppUrls._privateConstructor();

  static const String masterApiKey = '';
  static const String baseUrlAdmin = '';
  static const String baseUrlApp = 'http://192.168.0.135:8000/api';
  static const String baseUrlMaster = '';
  static const String baseUrlMessenger = '';
  static const String baseUrlWebSocket = '';

  static const String baseUrlPhaseTwo = '';

  static const String selfLocalBaseUrl = '';

  static const String messageApi = '$baseUrlMessenger/api-message-server.php';
  static const String sendServerNotification =
      '';
  static const String sendFirebaseNotification =
      '';

  // Admin Data APIs...

  // static const String getFaqsList = '/api/faq-list';
  // static const String getRequestCallbackList = '/api/request-callback-lists';
  // static const String getTutorialsList = '/api/tutorial-list';
  // static const String getBugReportList = '/api/bug-report-list';

  //restaurant-apis
  static const String getRestaurantList = '/restaurant-list';
  static const String getRestaurantStatus = '/restaurant-status';
  static const String getRestaurantData = '/restaurant-data';
  static const String getRestaurantTableData = '/restaurant-menu';
  static const String getRestaurantDishData = '/restaurant-dishes';
  static const String getKotData = '/kot-data';
  static const String placeOrder = '/place-order';
  static const String checkCartData = '/check-cart-data';
  static const String removeKot = '/remove-kot';

  static const String getFaqsList = '/api/faq-list-v1';
  static const String getRequestCallbackList = '/api/request-callback-list-v1';
  static const String getTutorialsList = '/api/tutorial-list-v1';
  static const String getBugReportList = '/api/bug-report-list-v1';

  static const String getTutorialDetails = '/api/tutorial-detail';
  static const String requestCallbackSave = '/api/request-callback-save';
  static const String getBugReportDetails = '/api/bug-report-detail';
  static const String createBugReport = '/api/create-bug-report';
  static const String createBugReportFollowUp = '/api/bug-report-followup-create';
  static const String getAccountManagerList = '/api/account-manager-lists';

  // Master Data APIs...

  static const String getAllTranslation = '/api/get-translation-all.php';
  static const String getTranslationLanguageList = '/api/get-translation-language-list.php';

  static const String getBugLabelList = '/api/get-bug-label-list.php';
  static const String getBugStatusList = '/api/get-bug-status-list.php';
  static const String getBugPriorityList = '/api/get-bug-priority-list.php';
  static const String getBugSeverityList = '/api/get-bug-severity-list.php';
  static const String getBugDeviceList = '/api/get-device-list.php';

  static const String getShiftLeaveReasonList = '/api/get-shift-leave-reason-list.php';
  static const String submitEmailSupportRequest = '/api/api-send-email-support.php';

  static const String getGeneralPriorityList = '/api/get-general-priority-list.php';

  // App Data APIs...
  //auth
  static const String empLogin = '/auth/login';
  static const String empLoginLog = '/api-logged-in-log.php';
  static const String empLogout = '/api-logout.php';
  static const String empForgotPassword = '/api-forgot-reset-password.php';
  static const String empResetPassword = '/api-save-reset-password.php';
  static const String empChangePassword = '/api-change-password.php';
  static const String empTwoFactorAuth = '/api-verify-2fa.php';
  static const String empChangeTwoFactorAuth = '/api-change-2fa-status.php';
  static const String empLoginActivityList = '/api-get-my-account-logs.php';

  static const String getEmployeeTasksList = '/api-get-my-tasks.php';
  static const String getEmployeeTaskDetails = '/api-get-employee-assigned-task-details.php';
  static const String getEmployeeTaskStepDetails = '/api-get-employee-task-step-details-and-response.php';
  static const String updateEmployeeTaskStatus = '/api-perform-employee-task-level-operations.php';
  static const String updateEmployeeTaskStepStatus = '/api-perform-employee-task-step-level-operations.php';

  static const String getEmployeeAccountSettingsDetails = '/api-get-my-account-security-settings.php';
  static const String getEmployeeDetails = '/api-get-employee-details.php';
  static const String getEmployeeHolidaysList = '/api-get-my-holidays.php';
  static const String getEmployeeLeavesList = '/api-get-my-leaves.php';
  static const String getEmployeeShiftsList = '/api-get-my-shifts.php';
  static const String getEmployeeOpenShiftsList = '/api-get-pickup-open-shifts.php';
  static const String getEmployeeShiftDetails = '/api-get-shift-details-by-employee-shift-detail-id.php';
  static const String getEmployeeAttendanceReport = '/api-get-my-attendance-report.php';
  static const String getEmployeeExpensesList = '/api-get-my-expenses.php';
  static const String getEmployeePayslipDetails = '/api-get-my-payslips.php';

  static const String updateShiftTimeKeepingStatus = '/api-perform-timekeeping-action.php';

  static const String sendLocationData = '/api-push-location-logs-from-device.php';
  static const String updateAlertReadStatus = '/api-notification-mark-as-read.php';

  static const String getAppNotificationsList = '/api-get-notifications.php';
  static const String getEmployeeSubordinatesList = '/api-get-my-subordinates.php';
  static const String uploadChatFiles = '/api-upload-employee-chat-assets.php';

  static const String getHolidayApprovalRequestsList = '/api-get-holiday-approval-requests.php';
  static const String getLeaveApprovalRequestsList = '/api-get-leave-approval-requests.php';
  static const String submitEmployeeHolidayRequest = '/api-save-my-optional-holiday-request.php';
  static const String submitEmployeeLeavesRequest = '/api-save-my-leaves-request.php';
  static const String submitLeaveApprovalRequest = '/api-save-leave-approval.php';
  static const String submitHolidayApprovalRequest = '/api-save-holiday-approval.php';

  static const String getRoomAvailabilityList = '/api-get-guest-room-availability-calendar.php';
  static const String getRevenueManagementList = '/api-get-room-availability-rates.php';
  static const String getRoomReservationsList = '/api-get-guest-reservations.php';
  static const String getFrontDeskData = '/api-get-front-desk-calendar.php';
  static const String getPropertyTransactionsList = '/api-get-property-transactions.php';
  static const String getDashboardData = '/api-get-dashboard.php';

  static const String getCountryCurrencyList = '/api/get-country-currency-list.php';
  static const String getCurrencyExchangeList = '/api-get-currency-exchange-rates.php';

  static const String updatePickUpOpenShift = '/api-pickup-open-shift.php';

  static const String getMakeRequestTypeList = '/api-get-make-a-request-types.php';
  static const String submitTaskMakeRequest = '/api-save-make-a-request-via-task.php';
  static const String taskMakeRequestList = '/api-get-make-a-request-list.php';

  static const String submitCreateExpense = '/api-save-employee-expense.php';
  static const String getIncomeExpenseCategoryList = '/api-get-income-expense-categories.php';

  static const String getCachedData = '/cached-list';
  static const String guestCreateRequest = '/guest-create-request';
  static const String getGuestRequestList = '/guest-request-list';
  static const String guestStayEnquiry = '/guest-stay-enquiry';
  static const String getGuestStayEnquiryList = '/guest-stay-enquiries-list';
  static const String getRequestType = '/request-type-list';
  static const String getGuestReservationList = '/guest-reservation-list';

  static const String getMakeRequestGuestCategoriesList = '/api-get-make-a-request-guest-categories.php';
  static const String getMakeRequestGuestCategoriesTypesList = '/api-get-make-a-request-guest-categories-types.php';
  static const String getMakeRequestGuestRequestList = '/api-get-guest-request-list.php';
  static const String submitMakeRequestGuest = '/api-save-make-a-request-guest.php';
}
