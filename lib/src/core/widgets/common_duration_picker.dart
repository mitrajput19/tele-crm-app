import '../../app/app.dart';

class CommonDurationPicker extends StatefulWidget {
  final Duration? selectedDuration;
  final Function(String formattedDuration, Duration pickedDuration)? onDurationSelected;

  const CommonDurationPicker({
    super.key,
    this.selectedDuration = const Duration(),
    this.onDurationSelected,
  });

  @override
  _CommonDurationPickerState createState() => _CommonDurationPickerState();
}

class _CommonDurationPickerState extends State<CommonDurationPicker> {
  late TextEditingController _hoursController;
  late TextEditingController _minutesController;
  late FocusNode _hoursFocusNode;
  late FocusNode _minutesFocusNode;

  Duration? selectedDuration;

  @override
  void initState() {
    super.initState();
    selectedDuration = widget.selectedDuration;

    if (selectedDuration == null) selectedDuration = Duration();

    _hoursController = TextEditingController(
      text: selectedDuration!.inHours.toString().padLeft(2, '0'),
    );
    _minutesController = TextEditingController(
      text: (selectedDuration!.inMinutes % 60).toString().padLeft(2, '0'),
    );

    _hoursFocusNode = FocusNode();
    _minutesFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    _hoursFocusNode.dispose();
    _minutesFocusNode.dispose();
    super.dispose();
  }

  int get hours => int.tryParse(_hoursController.text) ?? 0;
  int get minutes => int.tryParse(_minutesController.text) ?? 0;

  void _updateDuration() {
    setState(() {
      selectedDuration = Duration(hours: hours, minutes: minutes);
    });
  }

  void _incrementHours() {
    _hoursController.text = (hours + 1).clamp(0, 99).toString().padLeft(2, '0');
    _updateDuration();
  }

  void _decrementHours() {
    _hoursController.text = (hours - 1).clamp(0, 99).toString().padLeft(2, '0');
    _updateDuration();
  }

  void _incrementMinutes() {
    _minutesController.text = (minutes + 1) % 60 == 0 && hours < 99 ? '00' : (minutes + 1).toString().padLeft(2, '0');
    _updateDuration();
  }

  void _decrementMinutes() {
    int newMinutes = (minutes - 1 + 60) % 60;

    String newMinutesStr = newMinutes.toString().padLeft(2, '0');

    if (newMinutes == 59 && hours > 0) {
      newMinutesStr = '59';
    } else if (newMinutes == 0 && hours == 0) {
      newMinutesStr = '00';
    }

    _minutesController.text = newMinutesStr;
    _updateDuration();
  }

  String _formatDuration(Duration duration) {
    final int hrs = duration.inHours;
    final int mins = duration.inMinutes % 60;
    String formatted = '';

    if (hrs > 0) formatted += '${hrs} hr${hrs > 1 ? 's' : ''} ';
    if (mins > 0) formatted += '$mins min${mins > 1 ? 's' : ''}';

    return formatted.trim().isEmpty ? '0 min' : formatted.trim();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      child: Dialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16).copyWith(bottom: 8, top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTimeField(
                    label: AppTrKeys.hours.tr(context),
                    controller: _hoursController,
                    focusNode: _hoursFocusNode,
                    increment: _incrementHours,
                    decrement: _decrementHours,
                  ),
                  const SizedBox(width: 16),
                  _buildTimeField(
                    label: AppTrKeys.minutes.tr(context),
                    controller: _minutesController,
                    focusNode: _minutesFocusNode,
                    increment: _incrementMinutes,
                    decrement: _decrementMinutes,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(
                      AppTrKeys.cancel.tr(context).toUpperCase(),
                      style: TextStyle(
                        color: AppColors.secondary,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: Text(
                      AppTrKeys.ok.tr(context).toUpperCase(),
                      style: TextStyle(
                        color: AppColors.secondary,
                      ),
                    ),
                    onPressed: () {
                      final int finalHours = hours.clamp(0, 99);
                      final int finalMinutes = minutes.clamp(0, 59);
                      final pickedDuration = Duration(hours: finalHours, minutes: finalMinutes);
                      final formattedDuration = _formatDuration(pickedDuration);
                      widget.onDurationSelected?.call(formattedDuration, pickedDuration);
                      Navigator.of(context).pop(pickedDuration);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    required VoidCallback increment,
    required VoidCallback decrement,
  }) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.gray.withOpacity(.25)),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: decrement,
                  borderRadius: BorderRadius.circular(50),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: CommonIcon(Icons.remove),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 32,
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 4),
                        isDense: true,
                        counterText: '',
                      ),
                      maxLength: 2,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onTap: () {
                        controller.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: controller.text.length,
                        );
                      },
                      onChanged: (value) {
                        if (value.isEmpty) {
                          controller.text = '00';
                          controller.selection = TextSelection.fromPosition(
                            TextPosition(offset: 2),
                          );
                        } else {
                          int? numValue = int.tryParse(value);
                          if (numValue != null) {
                            if (label == AppTrKeys.hours.tr(context)) {
                              numValue = numValue.clamp(0, 99);
                            } else if (label == AppTrKeys.minutes.tr(context)) {
                              numValue = numValue.clamp(0, 59);
                            }

                            if (numValue.toString() != value) {
                              controller.text = numValue.toString().padLeft(2, '0');
                            }

                            _updateDuration();
                          }
                        }
                      },
                      onEditingComplete: () {
                        final numValue = int.tryParse(controller.text) ?? 0;
                        controller.text = numValue.toString().padLeft(2, '0');
                        _updateDuration();
                      },
                      onSubmitted: (value) {
                        final numValue = int.tryParse(value) ?? 0;
                        final maxValue = label == AppTrKeys.hours.tr(context) ? 99 : 59;
                        final clampedValue = numValue.clamp(0, maxValue);
                        controller.text = clampedValue.toString().padLeft(2, '0');
                        _updateDuration();
                      },
                    ),
                  ),
                ),
                InkWell(
                  onTap: increment,
                  borderRadius: BorderRadius.circular(50),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: CommonIcon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
