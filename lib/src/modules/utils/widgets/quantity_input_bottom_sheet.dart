import '../../../app/app.dart';

class QuantityInputBottomSheet extends StatefulWidget {
  final int defaultValue;
  final Function(int) onQuantitySelected;

  const QuantityInputBottomSheet({
    super.key,
    required this.onQuantitySelected,
    required this.defaultValue,
  });

  @override
  State<QuantityInputBottomSheet> createState() =>
      _QuantityInputBottomSheetState();
}

class _QuantityInputBottomSheetState extends State<QuantityInputBottomSheet> {
  final quantityTextController = TextEditingController();
  final quantityFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    quantityFocusNode.requestFocus();
    quantityTextController.text = widget.defaultValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheet(
      label: AppTrKeys.quantity.tr(context),
      padding: EdgeInsets.all(16),
      hasBottomSpacing: false,
      children: [
        CommonTextField(
          focusNode: quantityFocusNode,
          hasLabel: false,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          controller: quantityTextController,
        ),
        Align(
          child: CommonFilledButton(
            isHalfWidth: true,
            label: AppTrKeys.save.tr(context),
            onPressed: () {
              widget.onQuantitySelected(int.parse(quantityTextController.text));
              context.pop();
            },
          ),
        )
      ],
    );
  }
}
