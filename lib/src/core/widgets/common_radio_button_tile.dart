import '../../app/app.dart';

class CommonRadioButtonTile extends StatefulWidget {
  final String? label;
  final bool isSelected;
  final Function(bool value)? onTapCallback;

  const CommonRadioButtonTile({
    super.key,
    this.label,
    this.isSelected = false,
    this.onTapCallback,
  });

  @override
  _CommonRadioButtonTileState createState() => _CommonRadioButtonTileState();
}

class _CommonRadioButtonTileState extends State<CommonRadioButtonTile> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  void updateCheckState() {
    widget.onTapCallback?.call(!widget.isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      onTap: updateCheckState,
      child: Row(
        children: [
          CommonIcon(
            isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
          ),
          SizedBox(width: 16),
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
