import '../../app/app.dart';

typedef SearchFilter<T> = bool Function(T item, String searchTerm);

class SearchHelper {
  SearchHelper._privateConstructor();

  static List<T> genericSearchFilter<T>({
    required List<T> items,
    required String searchTerm,
    required SearchFilter<T> filterData,
  }) {
    String value = searchTerm.toLowerCase();
    return items.where((item) => filterData(item, value)).toList();
  }

  static bool containsAny(String term, List<String?> values) {
    return values.any((value) => value?.toLowerCase().contains(term) ?? false);
  }

  
  static List<AppNotificationDetails?> filterAppAlertsList({
    required List<AppNotificationDetails?> itemsList,
    required String searchTerm,
  }) {
    return genericSearchFilter<AppNotificationDetails?>(
      items: itemsList,
      searchTerm: searchTerm,
      filterData: (value, term) {
        String? title = value?.notificationTitle;
        String? description = value?.notificationDescription;
        return containsAny(term, [title, description]);
      },
    );
  }

  static List<EmployeeTaskDetails?> filterTasksList({
    required List<EmployeeTaskDetails?> itemsList,
    required String searchTerm,
  }) {
    return genericSearchFilter<EmployeeTaskDetails?>(
      items: itemsList,
      searchTerm: searchTerm,
      filterData: (value, term) {
        String? title = value?.taskTemplateTitle;
        String? location = value?.entityOrLocationType;
        String? period = value?.taskPeriod;
        String? status = value?.taskEmployeeStatus;
        return containsAny(term, [title, location, period, status]);
      },
    );
  }

  static List<BugReported?> filterBugReportList({
    required List<BugReported?> itemsList,
    required String searchTerm,
  }) {
    return genericSearchFilter<BugReported?>(
      items: itemsList,
      searchTerm: searchTerm,
      filterData: (value, term) {
        String? title = value?.bugTitle;
        String? description = value?.bugDescription;
        String? date = value?.createdAtFormat;
        return containsAny(term, [title, description, date]);
      },
    );
  }

  static List<RequestCallback?> filterRequestCallbackList({
    required List<RequestCallback?> itemsList,
    required String searchTerm,
  }) {
    return genericSearchFilter<RequestCallback?>(
      items: itemsList,
      searchTerm: searchTerm,
      filterData: (value, term) {
        String? name = value?.staffDetails?.fourroomsStaffName;
        String? status = value?.callbackStatusName;
        String? date = value?.callbackDateFormat;
        return containsAny(term, [name, status, date]);
      },
    );
  }

  static List<Tutorial?> filterTutorialList({
    required List<Tutorial?> itemsList,
    required String searchTerm,
  }) {
    return genericSearchFilter<Tutorial?>(
      items: itemsList,
      searchTerm: searchTerm,
      filterData: (value, term) {
        String? title = value?.tutorialTitle;
        String? description = value?.tutorialDescription;
        return containsAny(term, [title, description]);
      },
    );
  }

  

  static List<PropertyTransactionDetails?> filterPropertyTransactionDetailsList({
    required List<PropertyTransactionDetails?> itemsList,
    required String searchTerm,
  }) {
    return genericSearchFilter<PropertyTransactionDetails?>(
      items: itemsList,
      searchTerm: searchTerm,
      filterData: (value, term) {
        String? guestName = value?.guestDetails?.guestName;
        String? reservationNumber = value?.transactionEntityDetails?.reservationNumber;
        String? transactionDateDisplay = value?.transactionDateDisplay;
        String? transactionTimeDisplay = value?.transactionTimeDisplay;
        String? paymentModeName = value?.paymentModeName;
        String? transactionAmount = value?.transactionAmount;
        String? transactionType = value?.transactionType;
        String? transactionStatus = value?.transactionStatus;
        return containsAny(term, [
          guestName,
          reservationNumber,
          transactionDateDisplay,
          transactionTimeDisplay,
          paymentModeName,
          transactionAmount,
          transactionType,
          transactionStatus,
        ]);
      },
    );
  }

  static List<RoomReservationDetails?> filterRoomReservationDetailsList({
    required List<RoomReservationDetails?> itemsList,
    required String searchTerm,
  }) {
    return genericSearchFilter<RoomReservationDetails?>(
      items: itemsList,
      searchTerm: searchTerm,
      filterData: (value, term) {
        String? bookingSource = value?.bookingSource;
        String? reservationNumber = value?.reservationNumber;
        String? guestName = value?.guestName;
        String? guestEmail = value?.guestEmail;
        String? guestPhone = value?.guestPhone;
        String? latestReservationStatusText = value?.latestReservationStatusText;
        String? reservationType = value?.reservationType;
        String? masterArrivalDate = value?.masterArrivalDate;
        String? masterDepartureDate = value?.masterDepartureDate;
        String? totalGrossAmount = value?.totalGrossAmount;
        String? totalBalancePaymentDisplay = value?.totalBalancePaymentDisplay;
        String? totalPaymentReceived = value?.totalPaymentReceived;
        return containsAny(term, [
          bookingSource,
          reservationNumber,
          guestName,
          guestEmail,
          guestPhone,
          latestReservationStatusText,
          reservationType,
          masterArrivalDate,
          masterDepartureDate,
          totalGrossAmount,
          totalBalancePaymentDisplay,
          totalPaymentReceived,
        ]);
      },
    );
  }

  

  static List<MakeRequestDetails?> filterMakeRequestList({
    required List<MakeRequestDetails?> itemsList,
    required String searchTerm,
  }) {
    return genericSearchFilter<MakeRequestDetails?>(
      items: itemsList,
      searchTerm: searchTerm,
      filterData: (value, term) {
        String? title = value?.title;
        String? type = value?.makeARequestTypeTitle;
        String? status = value?.makeARequestStatusName;
        String? priority = value?.generalPriorityName;
        String? location = value?.location;
        return containsAny(term, [title, type, status, priority, location]);
      },
    );
  }

  static List<GuestRequestDetails?> filterGuestRequestList({
    required List<GuestRequestDetails?> itemsList,
    required String searchTerm,
  }) {
    return genericSearchFilter<GuestRequestDetails?>(
      items: itemsList,
      searchTerm: searchTerm,
      filterData: (value, term) {
        String? requestName = value?.requestName;
        String? requestCategory = value?.requestCategory;
        String? guestName = value?.guestDetails?.guestName;
        String? guestEmail = value?.guestDetails?.guestEmail;
        String? status = value?.makeARequestStatus?.label;
        String? deadline = value?.deadlineDatetime;
        String? numberOfPeople = value?.numberOfPeople;
        String? duration = value?.finalDuration;
        String? notes = value?.additionalNotes;
        return containsAny(term, [
          requestName,
          requestCategory,
          guestName,
          guestEmail,
          status,
          deadline,
          numberOfPeople,
          duration,
          notes,
        ]);
      },
    );
  }
}
