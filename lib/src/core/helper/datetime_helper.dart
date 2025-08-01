import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../app/app.dart';

extension DateTimeExt on DateTime {
  DateTime get monthStart => DateTime(year, month);
  DateTime get dayStart => DateTime(year, month, day);

  DateTime addMonth(int count) {
    return DateTime(year, month + count, day);
  }

  bool isSameDate(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }

  bool get isToday {
    return isSameDate(DateTime.now());
  }
}

class DateTimePickerHelper {
  static Future showDatePickerDialog(
    BuildContext context, {
    DateTime? selectedDate,
    DateTime? selectedStartDate,
    DateTime? selectedEndDate,
    bool isDateRangePicker = false,
    bool blockPreviousDates = false,
    bool blockFutureDates = false,
    Function(
      String formattedDate,
      DateTime pickedDate,
    )? onDateSelected,
    Function(
      String formattedStartDate,
      DateTime pickedStartDate,
      String formattedEndDate,
      DateTime pickedEndDate,
    )? onDateRangeSelected,
  }) async {
    FocusScope.of(context).unfocus();
    return await showDialog(
      context: context,
      builder: (context) {
        Color textColor = context.isDarkMode ? AppColors.light : AppColors.dark;
        TextStyle textStyle = Theme.of(context).textTheme.tsMedium14.copyWith(
              color: textColor,
            );
        return Dialog(
          elevation: 0,
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 320,
            width: context.isTablet ? context.screenWidth / 2 : context.screenWidth,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16).copyWith(
              top: 0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
            ),
            child: SfDateRangePickerTheme(
              data: SfDateRangePickerThemeData(
                todayHighlightColor: AppColors.secondary,
              ),
              child: SfDateRangePicker(
                showTodayButton: true,
                showNavigationArrow: true,
                initialDisplayDate: selectedDate,
                selectionMode:
                    isDateRangePicker ? DateRangePickerSelectionMode.range : DateRangePickerSelectionMode.single,
                initialSelectedDate: selectedDate,
                headerHeight: 56,
                backgroundColor: Theme.of(context).cardColor,
                rangeSelectionColor: AppColors.secondary.withOpacity(.25),
                rangeTextStyle: Theme.of(context).textTheme.tsPrimaryMedium14.copyWith(
                      color: textColor,
                    ),
                headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor: Theme.of(context).cardColor,
                  textAlign: TextAlign.center,
                  textStyle: Theme.of(context).textTheme.tsMedium16.copyWith(
                        color: textColor,
                      ),
                ),
                monthViewSettings: DateRangePickerMonthViewSettings(
                  showTrailingAndLeadingDates: true,
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                    textStyle: Theme.of(context).textTheme.tsMedium16.copyWith(
                          color: textColor,
                        ),
                  ),
                ),
                monthCellStyle: DateRangePickerMonthCellStyle(
                  textStyle: textStyle,
                  weekendTextStyle: textStyle,
                  blackoutDateTextStyle: textStyle,
                  disabledDatesTextStyle: textStyle,
                  todayTextStyle: Theme.of(context).textTheme.tsPrimaryMedium14.copyWith(
                        color: AppColors.secondary,
                      ),
                  leadingDatesTextStyle: Theme.of(context).textTheme.tsGrayRegular14,
                  trailingDatesTextStyle: Theme.of(context).textTheme.tsGrayRegular14,
                ),
                yearCellStyle: DateRangePickerYearCellStyle(
                  textStyle: textStyle,
                  disabledDatesTextStyle: textStyle,
                  todayTextStyle: Theme.of(context).textTheme.tsPrimaryMedium14.copyWith(
                        color: AppColors.secondary,
                      ),
                  leadingDatesTextStyle: Theme.of(context).textTheme.tsGrayRegular14,
                ),
                minDate: blockPreviousDates ? DateTime.now() : null,
                maxDate: blockFutureDates ? DateTime.now() : null,
                selectionShape: DateRangePickerSelectionShape.rectangle,
                selectionRadius: 24,
                selectionColor: AppColors.secondary,
                showActionButtons: isDateRangePicker,
                onSubmit: (value) {
                  if (value is PickerDateRange) {
                    DateTime? startDate = value.startDate;
                    DateTime? endDate = value.endDate;
                    String formattedStartDate = DateFormat('d MMM yyyy').format(startDate!);
                    String formattedEndDate = DateFormat('d MMM yyyy').format(endDate!);
                    onDateRangeSelected?.call(formattedStartDate, startDate, formattedEndDate, endDate);
                    context.pop();
                  }
                },
                onCancel: () => context.pop(),
                initialSelectedRange: PickerDateRange(selectedStartDate, selectedEndDate),
                onSelectionChanged: (DateRangePickerSelectionChangedArgs value) {
                  if (!isDateRangePicker) {
                    String formattedDate = DateFormat('d MMM yyyy').format(value.value);
                    onDateSelected?.call(formattedDate, value.value);
                    context.pop();
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  static Future showTimePickerDialog(
    BuildContext context, {
    TimeOfDay? selectedTime,
    Function(String formattedTime, TimeOfDay pickedTime)? onTimeSelected,
  }) async {
    FocusScope.of(context).unfocus();
    return await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime != null) {
        var now = DateTime.now();
        var dateTime = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
        var formattedTime = DateFormat('hh:mm a').format(dateTime);
        onTimeSelected?.call(formattedTime, pickedTime);
      }
    });
  }

  static Future<Duration?> showDurationPickerDialog(
    BuildContext context, {
    Duration? selectedDuration,
    Function(String formattedDuration, Duration pickedDuration)? onDurationSelected,
  }) async {
    FocusScope.of(context).unfocus();
    return await showDialog(
      context: context,
      builder: (context) {
        return CommonDurationPicker(
          selectedDuration: selectedDuration,
          onDurationSelected: onDurationSelected,
        );
      },
    );
  }
}
