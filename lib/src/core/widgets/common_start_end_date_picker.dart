import '../../app/app.dart';

class CommonStartEndDatePicker extends StatefulWidget {
  final DateTime? selectedStartDate, selectedEndDate;
  final bool blockPreviousDates;
  final bool blockFutureDates;
  final Function(String startDate, String endDate) onPressed;

  const CommonStartEndDatePicker({
    super.key,
    this.selectedStartDate,
    this.selectedEndDate,
    this.blockPreviousDates = false,
    this.blockFutureDates = false,
    required this.onPressed,
  });

  @override
  _CommonStartEndDatePickerState createState() => _CommonStartEndDatePickerState();
}

class _CommonStartEndDatePickerState extends State<CommonStartEndDatePicker> {
  late DateTime selectedStartDate;
  late DateTime selectedEndDate;

  @override
  void initState() {
    super.initState();

    if (widget.blockFutureDates) {
      // If future dates are blocked, select today to the previous 30 days
      selectedStartDate = widget.selectedStartDate ?? DateTime.now().subtract(Duration(days: 30));
      selectedEndDate = widget.selectedEndDate ?? DateTime.now();
    } else {
      // Default behavior: today to the next 30 days
      selectedStartDate = widget.selectedStartDate ?? DateTime.now();
      selectedEndDate = widget.selectedEndDate ?? DateTime.now().add(Duration(days: 30));
    }
  }

  Future<void> openDatePickerDialog(
    BuildContext context, {
    bool isStartDate = true,
  }) async {
    await DateTimePickerHelper.showDatePickerDialog(
      context,
      isDateRangePicker: true,
      blockPreviousDates: widget.blockPreviousDates,
      blockFutureDates: widget.blockFutureDates,
      selectedStartDate: selectedStartDate,
      selectedEndDate: selectedEndDate,
      onDateRangeSelected: (formattedStartDate, pickedStartDate, formattedEndDate, pickedEndDate) {
        setState(() {
          selectedStartDate = pickedStartDate;
          selectedEndDate = pickedEndDate;
          String formattedStartDate = UtilsHelper.convertToParsedDateFormat(selectedStartDate);
          String formattedEndDate = UtilsHelper.convertToParsedDateFormat(selectedEndDate);
          widget.onPressed(formattedStartDate, formattedEndDate);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Theme.of(context).cardColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => openDatePickerDialog(context),
              child: CommonLabelValueTile(
                isRightAlign: true,
                label: AppTrKeys.startDate.tr(context),
                value: UtilsHelper.convertDateFormat(selectedStartDate.toString()),
                labelStyle: Theme.of(context).textTheme.tsGrayRegular10,
                valueStyle: Theme.of(context).textTheme.tsMedium12,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => openDatePickerDialog(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CommonIcon(
                AppIcons.calendar,
                padding: EdgeInsets.all(6),
                color: AppColors.light,
                backgroundColor: AppColors.secondary,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => openDatePickerDialog(context, isStartDate: false),
              child: CommonLabelValueTile(
                label: AppTrKeys.endDate.tr(context),
                value: UtilsHelper.convertDateFormat(selectedEndDate.toString()),
                labelStyle: Theme.of(context).textTheme.tsGrayRegular10,
                valueStyle: Theme.of(context).textTheme.tsMedium12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
