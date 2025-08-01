import '../../app/app.dart';

class CommonTextField extends StatefulWidget {
  final TextEditingController? controller;
  final bool isLoading;
  final bool isRequired;
  final bool hasLabel;
  final String? label;
  final bool isDisabled;
  final String? hintText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool hasPrefixBackground;
  final bool hasSuffixBackground;
  final String? Function(String?)? validator;
  final int? minLines;
  final int? maxLines;
  final bool hasBottomSpacing;
  final Function()? onTap;
  final Function(String value)? onChanged;
  final Function(String value)? onFieldSubmitted;
  final bool isDense;
  final TextStyle? labelStyle;
  final bool isLabeRightAlign;
  final FocusNode? focusNode;
  final bool? autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? margin;
  final bool closeKeyboardOnTapOutside;
  final bool showClearIcon;
  final Function()? onClearTap;
  final TextCapitalization? textCapitalization;

  const CommonTextField({
    super.key,
    this.controller,
    this.isLoading = false,
    this.isRequired = false,
    this.hasLabel = true,
    this.label,
    this.isDisabled = false,
    this.hintText,
    this.obscureText,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.hasPrefixBackground = true,
    this.hasSuffixBackground = true,
    this.validator,
    this.minLines,
    this.maxLines = 1,
    this.hasBottomSpacing = true,
    this.onTap,
    this.isDense = false,
    this.isLabeRightAlign = false,
    this.labelStyle,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
    this.autofocus,
    this.inputFormatters,
    this.margin,
    this.closeKeyboardOnTapOutside = true,
    this.showClearIcon = false,
    this.onClearTap,
    this.textCapitalization,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  TextEditingController? _localController;

  @override
  void initState() {
    super.initState();
    _localController = widget.controller;
    _localController?.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(CommonTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _localController?.removeListener(_onTextChanged);
      _localController = widget.controller;
      _localController?.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    _localController?.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(
      widget.maxLines != null && widget.maxLines! >= 2 ? 16 : AppTheme.textFieldBorderRadius,
    );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Column(
        crossAxisAlignment: widget.isLabeRightAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (widget.hasLabel)
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: '${widget.label ?? AppStrings.label} ',
                      style: widget.labelStyle ?? Theme.of(context).textTheme.tsMedium14,
                      children: [
                        if (widget.isRequired)
                          TextSpan(
                            text: '*',
                            style: Theme.of(context).textTheme.tsMedium14.copyWith(
                                  color: AppColors.danger,
                                ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (widget.showClearIcon)
                  if (_localController?.text != null && _localController?.text != '')
                    CommonIcon(
                      Icons.clear_rounded,
                      size: 20,
                      color: AppColors.gray,
                      padding: EdgeInsets.zero,
                      onTap: () {
                        _localController?.clear();
                        widget.onClearTap?.call();
                      },
                    )
              ],
            ),
          if (widget.hasLabel) SizedBox(height: 4),
          GestureDetector(
            onTap: widget.onTap,
            child: Container(
              margin: widget.margin ?? EdgeInsets.zero,
              child: AbsorbPointer(
                absorbing: widget.isDisabled,
                child: TextFormField(
                  onTapOutside: (PointerDownEvent event) {
                    if (widget.closeKeyboardOnTapOutside) {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    }
                  },
                  autofocus: widget.autofocus ?? false,
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  obscureText: widget.obscureText ?? false,
                  keyboardType: widget.keyboardType ?? TextInputType.text,
                  textInputAction: widget.textInputAction ?? TextInputAction.done,
                  style: Theme.of(context).textTheme.tsRegular14,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: widget.validator,
                  maxLines: widget.maxLines,
                  minLines: widget.minLines,
                  onChanged: widget.onChanged,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  inputFormatters: widget.inputFormatters,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).cardColor,
                    hintText: widget.hintText ?? AppTrKeys.typeHere.tr(context),
                    hintStyle: Theme.of(context).textTheme.tsGrayRegular14.copyWith(
                          fontSize: widget.isDense ? 12 : 14,
                        ),
                    errorStyle: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: AppColors.danger,
                    ),
                    prefixIcon: widget.prefixIcon != null
                        ? Container(
                            margin: EdgeInsets.all(6),
                            padding: EdgeInsets.all(widget.isDense ? 0 : 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.hasPrefixBackground
                                  ? context.isDarkMode
                                      ? AppColors.gray.shade900
                                      : AppColors.gray.withOpacity(.1)
                                  : Colors.transparent,
                            ),
                            child: widget.prefixIcon,
                          )
                        : widget.prefixIcon,
                    prefixIconConstraints: BoxConstraints(
                      minWidth: widget.isDense ? 42 : 50,
                      minHeight: widget.isDense ? 40 : 48,
                      maxWidth: widget.isDense ? 42 : 50,
                      maxHeight: widget.isDense ? 40 : 48,
                    ),
                    suffixIcon: widget.suffixIcon != null
                        ? Container(
                            margin: EdgeInsets.all(widget.isLoading ? 8 : 4),
                            padding: EdgeInsets.all(widget.isDense ? 0 : 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.hasSuffixBackground
                                  ? context.isDarkMode
                                      ? AppColors.gray.shade900
                                      : AppColors.gray.withOpacity(.1)
                                  : Colors.transparent,
                            ),
                            child: widget.isLoading
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      strokeCap: StrokeCap.round,
                                      color: AppColors.secondary,
                                    ),
                                  )
                                : widget.suffixIcon,
                          )
                        : widget.suffixIcon,
                    suffixIconConstraints: BoxConstraints(
                      minWidth: widget.isDense ? 42 : 50,
                      minHeight: widget.isDense ? 40 : 48,
                      maxWidth: widget.isDense ? 42 : 50,
                      maxHeight: widget.isDense ? 40 : 48,
                    ),
                    contentPadding: widget.isDense
                        ? EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          )
                        : EdgeInsets.all(14),
                    isDense: widget.isDense,
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
                        width: 2,
                        color: context.isDarkMode
                            ? Theme.of(context).primaryColorLight
                            : Theme.of(context).primaryColorDark,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(
                        color: AppColors.danger,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (widget.hasBottomSpacing) SizedBox(height: 16),
        ],
      ),
    );
  }
}
