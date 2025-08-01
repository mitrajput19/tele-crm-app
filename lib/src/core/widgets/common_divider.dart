import '../../app/app.dart';

class CommonDivider extends StatelessWidget {
  final double? thickness;
  final EdgeInsets? margin;
  final Color? color;
  final bool isVertical;

  const CommonDivider({
    super.key,
    this.thickness,
    this.margin,
    this.color,
    this.isVertical = false,
  });

  @override
  Widget build(BuildContext context) {
    Color color = this.color ?? AppColors.gray.withOpacity(.15);
    return Container(
      margin: margin,
      child: isVertical
          ? VerticalDivider(
              width: 0,
              thickness: thickness ?? 1,
              color: color,
            )
          : Divider(
              height: 0,
              thickness: thickness ?? 1,
              color: color,
            ),
    );
  }
}
