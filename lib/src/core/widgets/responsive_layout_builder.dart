import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../app/app.dart';

class ResponsiveLayoutBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final bool shrinkWrap;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;

  const ResponsiveLayoutBuilder({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 16,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry layoutPadding = padding ?? EdgeInsets.all(16).copyWith(bottom: 100);
    return context.isTablet
        ? AlignedGridView.count(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            shrinkWrap: shrinkWrap,
            physics: physics,
            padding: layoutPadding,
            itemCount: itemCount,
            itemBuilder: itemBuilder,
          )
        : ListView.builder(
            physics: physics,
            shrinkWrap: shrinkWrap,
            padding: layoutPadding,
            itemCount: itemCount,
            itemBuilder: itemBuilder,
          );
  }
}
