import '../../../app/app.dart';

class RequestFilterData {
  final List<String> selectedStatus;
  final List<int> selectedCategoryIds;
  final List<int> selectedPriorityIds;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String sortBy;
  final String sortOrder;
  final String? dateFromDisplay;
  final String? dateToDisplay;

  RequestFilterData({
    this.selectedStatus = const [],
    this.selectedCategoryIds = const [],
    this.selectedPriorityIds = const [],
    this.dateFrom,
    this.dateTo,
    this.sortBy = 'created_at',
    this.sortOrder = 'desc',
    this.dateFromDisplay,
    this.dateToDisplay,
  });

  Map<String, dynamic> toFilterParams() {
    final Map<String, dynamic> params = {
      'sort_by': sortBy,
      'sort_order': sortOrder,
    };

    if (dateFrom != null) {
      params['from_date'] = UtilsHelper.convertToParsedDateFormat(dateFrom);
    }

    if (dateTo != null) {
      params['to_date'] = UtilsHelper.convertToParsedDateFormat(dateTo);
    }

    if (selectedStatus.isNotEmpty && selectedStatus.first != 'all') {
      params['statuses'] = selectedStatus.join(',');
    }

    if (selectedCategoryIds.isNotEmpty) {
      params['category_ids'] = selectedCategoryIds.join(',');
    }

    if (selectedPriorityIds.isNotEmpty) {
      params['priority_ids'] = selectedPriorityIds.join(',');
    }

    return params;
  }

  RequestFilterData copyWith({
    List<String>? selectedStatus,
    List<int>? selectedCategoryIds,
    List<int>? selectedPriorityIds,
    DateTime? dateFrom,
    DateTime? dateTo,
    String? sortBy,
    String? sortOrder,
    String? dateFromDisplay,
    String? dateToDisplay,
  }) {
    return RequestFilterData(
      selectedStatus: selectedStatus ?? this.selectedStatus,
      selectedCategoryIds: selectedCategoryIds ?? this.selectedCategoryIds,
      selectedPriorityIds: selectedPriorityIds ?? this.selectedPriorityIds,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      dateFromDisplay: dateFromDisplay ?? this.dateFromDisplay,
      dateToDisplay: dateToDisplay ?? this.dateToDisplay,
    );
  }
}
