import 'package:pinput/pinput.dart';

import '../../app/app.dart';

class CommonPinputField extends StatefulWidget {
  final TextEditingController? controller;
  final bool isRequired;
  final bool hasLabel;
  final String? label;
  final String? Function(String?)? validator;
  final bool hasBottomSpacing;

  const CommonPinputField({
    super.key,
    this.controller,
    this.isRequired = false,
    this.hasLabel = true,
    this.label,
    this.validator,
    this.hasBottomSpacing = true,
  });

  @override
  State<CommonPinputField> createState() => _CommonPinputFieldState();
}

class _CommonPinputFieldState extends State<CommonPinputField> {
  @override
  Widget build(BuildContext context) {
    PinTheme defaultPinTheme = PinTheme(
      width: 48,
      height: 58,
      textStyle: Theme.of(context).textTheme.tsSemiBold20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.gray.withOpacity(.25)),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.hasLabel)
          Text.rich(
            TextSpan(
              text: '${widget.label ?? AppTrKeys.verificationCode.tr(context)} ',
              style: Theme.of(context).textTheme.tsMedium14,
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
        if (widget.hasLabel) SizedBox(height: 4),
        Center(
          child: Pinput(
            length: 6,
            controller: widget.controller,
            validator: widget.validator,
            separatorBuilder: (index) => const SizedBox(width: 8),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                border: Border.all(
                  width: 2,
                  color: context.isDarkMode ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            errorPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                border: Border.all(color: AppColors.danger),
              ),
            ),
            errorTextStyle: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: AppColors.danger,
            ),
            cursor: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 2,
                  height: 20,
                  color: context.isDarkMode ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark,
                ),
              ],
            ),
          ),
        ),
        if (widget.hasBottomSpacing) SizedBox(height: 16),
      ],
    );
  }
}
