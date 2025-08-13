import '../../../app/app.dart';

class ItemCounterTile extends StatefulWidget {
  final String label;
  final int? defaultValue;
  final bool showQtyLabel;
  final bool showEditLabel;
  final bool isViewOnly;
  final Function(int value)? onTap;
  const ItemCounterTile({
    super.key,
    this.label = 'Quantity',
    this.defaultValue = 0,
    this.showQtyLabel = true,
    this.isViewOnly = false,
    this.onTap,
    this.showEditLabel = true,
  });

  @override
  State<ItemCounterTile> createState() => _ItemCounterTileState();
}

class _ItemCounterTileState extends State<ItemCounterTile> {
  int counter = 0;
  TextEditingController numberInputController = TextEditingController();
  FocusNode quantityFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    counter = widget.defaultValue!;
  }

  @override
  void didUpdateWidget(covariant ItemCounterTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.defaultValue != widget.defaultValue) {
      setState(() {
        counter = widget.defaultValue ?? 0;
      });
    }
  }

  void incrementCounter() {
    counter++;
    widget.onTap?.call(counter);
    setState(() {});
  }

  void decrementCounter() {
    if (counter > 1) {
      counter--;
      widget.onTap?.call(counter);
    }
    setState(() {});
  }

  void _handleIntegerSelected(int value) {
    setState(() {
      counter = value;
      widget.onTap?.call(counter);
    });
  }

  void showEditBottomSheet() {
    BottomSheetHelper.showCommonBottomSheet(
      context,
      child: QuantityInputBottomSheet(
        onQuantitySelected: _handleIntegerSelected,
        defaultValue: counter,
      ),
    );
  }

  Widget _buildViewCounter() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.gray.withOpacity(.5)),
      child: Text(
        '$counter',
        style: Theme.of(context).textTheme.tsLightSemiBold14,
      ),
    );
  }

  Widget _buildCounter() {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: AppColors.gray.withOpacity(.25),
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          if (!widget.isViewOnly)
            CommonIcon(
              Icons.remove,
              size: 20,
              color: context.isDarkMode ? AppColors.gray.shade200 : AppColors.gray.shade900,
              backgroundColor: context.isDarkMode ? AppColors.gray.shade900 : AppColors.gray.withOpacity(.1),
              onTap: decrementCounter,
            ),
          Container(
            width: 56,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '$counter',
              style: Theme.of(context).textTheme.tsSemiBold14,
            ),
          ),
          if (!widget.isViewOnly)
            CommonIcon(
              Icons.add,
              size: 20,
              color: context.isDarkMode ? AppColors.gray.shade200 : AppColors.gray.shade900,
              backgroundColor: context.isDarkMode ? AppColors.gray.shade900 : AppColors.gray.withOpacity(.1),
              onTap: incrementCounter,
            ),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return CommonIcon(
  
      Icons.edit_rounded,
      size: 16,
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.symmetric(horizontal: 8),
      color: context.isDarkMode ? AppColors.gray.shade200 : AppColors.gray.withOpacity(0.4),
      onTap: showEditBottomSheet,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.showEditLabel
        ? Row(
            children: [
              if (widget.showQtyLabel)
                Expanded(
                  child: Text(
                    widget.label,
                    style: Theme.of(context).textTheme.tsMedium14,
                  ),
                ),
              if (!widget.isViewOnly) ...[
                _buildEditButton(),
                _buildCounter(),
              ] else ...[
                _buildViewCounter()
              ]
            ],
          )
        : _buildCounter();
  }
}
