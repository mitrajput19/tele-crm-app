import 'package:dropdown_button2/dropdown_button2.dart';

import '../../app/app.dart';

class CommonDropdownField<T> extends StatelessWidget {
  final bool hasLabel;
  final String? label;
  final List<T> items;
  final String? Function(T? value) getValueText;
  final T value;
  final Function(T? value)? onChanged;
  final bool hasBottomSpacing;
  final TextStyle? labelStyle;
  final String? hintText;
  final bool hasIcon;
  final bool isDense;
  final bool isRequired;
  final bool isLoading;
  final FormFieldValidator<T>? validator;

  CommonDropdownField({
    this.hasLabel = true,
    this.label,
    required this.items,
    required this.getValueText,
    required this.value,
    required this.onChanged,
    this.hasBottomSpacing = true,
    this.labelStyle,
    this.hintText,
    this.hasIcon = true,
    this.isDense = false,
    this.isRequired = false,
    this.isLoading = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(AppTheme.textFieldBorderRadius);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasLabel)
          Text.rich(
            TextSpan(
              text: '${label ?? AppStrings.label} ',
              style: labelStyle ?? Theme.of(context).textTheme.tsMedium14,
              children: [
                if (isRequired)
                  TextSpan(
                    text: '*',
                    style: Theme.of(context).textTheme.tsMedium14.copyWith(
                          color: AppColors.danger,
                        ),
                  ),
              ],
            ),
          ),
        if (hasLabel) SizedBox(height: 4),
        DropdownButtonFormField2<T>(
          value: value,
          onChanged: onChanged,
          isExpanded: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: isRequired && validator != null
              ? (value) {
                  if (value == null) {
                    return AppTrKeys.thisFieldIsRequired.tr(context);
                  }
                  return null;
                }
              : validator,
          dropdownStyleData: DropdownStyleData(
            elevation: 2,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
            ),
          ),
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.only(right: 16),
          ),
          iconStyleData: IconStyleData(
            icon: isLoading
                ? Container(
                    height: 20,
                    width: 20,
                    margin: EdgeInsets.only(right: 4),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      strokeCap: StrokeCap.round,
                      color: AppColors.secondary,
                    ),
                  )
                : Icon(
                    Icons.arrow_drop_down_rounded,
                    color: hasIcon ? Theme.of(context).iconTheme.color : Colors.transparent,
                  ),
          ),
          menuItemStyleData: MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
          hint: Text(
            hintText ?? AppTrKeys.select.tr(context),
            style: Theme.of(context).textTheme.tsGrayRegular14,
          ),
          decoration: InputDecoration(
            fillColor: Theme.of(context).cardColor,
            hintText: AppTrKeys.select.tr(context),
            hintStyle: Theme.of(context).textTheme.tsGrayRegular14,
            contentPadding: EdgeInsets.symmetric(vertical: isDense ? 8 : 12),
            isDense: isDense,
            errorStyle: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: AppColors.danger,
            ),
            border: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(
                color: AppColors.gray.withOpacity(.25),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(
                color: AppColors.gray.withOpacity(.25),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(
                color: AppColors.danger,
              ),
            ),
          ),
          items: items.map<DropdownMenuItem<T>>((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                getValueText(item) ?? '-',
                style: Theme.of(context).textTheme.tsRegular14,
              ),
            );
          }).toList(),
        ),
        if (hasBottomSpacing) SizedBox(height: 16),
      ],
    );
  }
}
