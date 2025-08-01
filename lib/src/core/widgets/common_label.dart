import '../../app/app.dart';

class CommonLabel extends StatelessWidget {
  final String? label;
  final TextStyle? labelStyle;
  final bool isRightAlign;
  final bool hasBottomSpacing;
  final double bottomSpacing;
  final int? maxLines;
  final bool isExpanded;

  const CommonLabel(
    this.label, {
    super.key,
    this.labelStyle,
    this.isRightAlign = false,
    this.hasBottomSpacing = true,
    this.bottomSpacing = 4,
    this.maxLines = null,
    this.isExpanded = false,
  });

  Widget _buildColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: isRightAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label ?? AppStrings.label,
          style: labelStyle ?? Theme.of(context).textTheme.tsMedium14,
          maxLines: maxLines,
        ),
        if (hasBottomSpacing) SizedBox(height: bottomSpacing),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return isExpanded ? Expanded(child: _buildColumn(context)) : _buildColumn(context);
  }
}
