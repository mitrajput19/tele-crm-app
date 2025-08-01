import '../../app/app.dart';

class CommonCheckBoxTile extends StatefulWidget {
  final String? label;
  final bool isSelected;
  final Function(bool value)? onTapCallback;

  const CommonCheckBoxTile({
    super.key,
    this.label,
    this.isSelected = false,
    this.onTapCallback,
  });
  @override
  _CommonCheckBoxTileState createState() => _CommonCheckBoxTileState();
}

class _CommonCheckBoxTileState extends State<CommonCheckBoxTile> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  void updateCheckState() {
    isSelected = !isSelected;
    setState(() {});
    widget.onTapCallback?.call(isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      onTap: updateCheckState,
      hasBorder: true,
      hasBackground: false,
      borderRadius: BorderRadius.circular(12),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          CommonIcon(
            isSelected ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
            color: isSelected ? Theme.of(context).iconTheme.color : AppColors.gray,
            size: 20,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.label ?? AppStrings.label,
              style: Theme.of(context).textTheme.tsMedium14,
            ),
          ),
        ],
      ),
    );
  }
}
