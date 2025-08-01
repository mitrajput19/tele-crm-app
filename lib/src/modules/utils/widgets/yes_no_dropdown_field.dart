import '../../../app/app.dart';

class YesNoDropdownField extends StatelessWidget {
  final dynamic dataValue;
  final String? label;
  final bool isRequired;
  final Function(String key, dynamic value)? onChanged;

  const YesNoDropdownField({
    super.key,
    this.dataValue,
    this.label,
    this.isRequired = false,
    this.onChanged,
  });

  String _getDisplayValue(BuildContext context) {
    final value = dataValue.toString();
    if (value == '1' || value == 1) {
      return AppTrKeys.yes.tr(context);
    }
    return AppTrKeys.no.tr(context);
  }

  dynamic _getDataValue(String displayValue, BuildContext context) {
    if (displayValue == AppTrKeys.yes.tr(context)) return dataValue is int ? 1 : '1';
    return dataValue is int ? 0 : '0';
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      AppTrKeys.yes.tr(context),
      AppTrKeys.no.tr(context),
    ];

    return CommonDropdownField<String>(
      label: label,
      items: items,
      isRequired: isRequired,
      getValueText: (value) => value,
      value: _getDisplayValue(context),
      onChanged: (displayValue) {
        final dataValue = _getDataValue(displayValue!, context);
        onChanged?.call(displayValue, dataValue);
      },
    );
  }
}
