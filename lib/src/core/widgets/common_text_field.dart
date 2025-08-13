import '../../app/app.dart';

class CommonTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final EdgeInsets? margin;
  final bool hasLabel;
  final bool hasBottomSpacing;
  final bool isDense;
  final bool hasSuffixBackground;
  final FocusNode? focusNode;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const CommonTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.validator,
    this.margin,
    this.hasLabel = true,
    this.hasBottomSpacing = true,
    this.isDense = false,
    this.hasSuffixBackground = true,
    this.focusNode,
    this.maxLines = 1,
    this.inputFormatters
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasLabel && label != null) ...[
            Text(
              label!,
              style: Theme.of(context).textTheme.tsMedium14,
            ),
            SizedBox(height: 8),
          ],
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            onChanged: onChanged,
            validator: validator,
            focusNode: focusNode,
            maxLines: maxLines,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              isDense: isDense,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.textFieldBorderRadius),
                borderSide: BorderSide(color: AppColors.gray.withOpacity(.25)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.textFieldBorderRadius),
                borderSide: BorderSide(color: AppColors.gray.withOpacity(.25)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.textFieldBorderRadius),
                borderSide: BorderSide(color: AppColors.secondary),
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
            ),
          ),
          if (hasBottomSpacing) SizedBox(height: 16),
        ],
      ),
    );
  }
}