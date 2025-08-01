import '../../app/app.dart';

class CommonLabelValueTile extends StatelessWidget {
  final String? label;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final String? value;
  final Widget? valueWidget;
  final bool isRightAlign;
  final bool isExpanded;
  final bool hasBottomSpacing;
  final int? maxLines;
  final bool showFullText;
  final bool hasLabel;
  final Widget? trailingChild;

  const CommonLabelValueTile({
    super.key,
    this.label,
    this.labelStyle,
    this.valueStyle,
    this.value,
    this.valueWidget,
    this.isRightAlign = false,
    this.isExpanded = false,
    this.hasBottomSpacing = false,
    this.maxLines,
    this.showFullText = false,
    this.hasLabel = true,
    this.trailingChild,
  });

  Widget _buildCommonWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: isRightAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (hasLabel)
                Text(
                  label ?? AppStrings.label,
                  style: labelStyle ?? Theme.of(context).textTheme.tsGrayRegular12,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              if (value == null && valueWidget != null) SizedBox(height: 4),
              if (value != null || valueWidget == null)
                Text(
                  value == '' ? '-' : value ?? '-',
                  style: valueStyle ?? Theme.of(context).textTheme.tsMedium14,
                  textAlign: isRightAlign ? TextAlign.end : TextAlign.start,
                  maxLines: showFullText ? null : maxLines,
                  overflow: showFullText ? null : TextOverflow.ellipsis,
                )
              else
                valueWidget ?? SizedBox(),
              if (hasBottomSpacing) SizedBox(height: 8)
            ],
          ),
        ),
        if (trailingChild != null) trailingChild!,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return isExpanded ? Expanded(child: _buildCommonWidget(context)) : _buildCommonWidget(context);
  }
}
