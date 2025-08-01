import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../app/app.dart';

class ListViewShimmer extends StatelessWidget {
  final int? itemCount;
  final Widget? shimmerCard;
  final bool isScroll;
  final EdgeInsets? padding;
  final bool showGridLayout;
  final bool useTabletMode;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;

  const ListViewShimmer({
    super.key,
    this.itemCount,
    this.shimmerCard,
    this.padding,
    this.isScroll = false,
    this.showGridLayout = true,
    this.useTabletMode = true,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return useTabletMode && context.isTablet
        ? AlignedGridView.count(
            crossAxisCount: showGridLayout ? 2 : 1,
            mainAxisSpacing: mainAxisSpacing ?? 8,
            crossAxisSpacing: crossAxisSpacing ?? 16,
            shrinkWrap: !isScroll,
            physics: isScroll ? ClampingScrollPhysics() : NeverScrollableScrollPhysics(),
            padding: padding ?? EdgeInsets.all(16),
            itemCount: itemCount ?? 10,
            itemBuilder: (context, index) {
              if (!showGridLayout) {
                return ResponsiveContainer(
                  hasBorder: false,
                  child: shimmerCard ?? MediumCardShimmer(),
                );
              }
              return shimmerCard ?? MediumCardShimmer();
            },
          )
        : ListView.builder(
            shrinkWrap: !isScroll,
            physics: isScroll ? ClampingScrollPhysics() : NeverScrollableScrollPhysics(),
            padding: padding ?? EdgeInsets.all(16),
            itemCount: itemCount ?? 10,
            itemBuilder: (context, index) {
              return shimmerCard ?? MediumCardShimmer();
            },
          );
  }
}

class CommonShimmerCircle extends StatelessWidget {
  final double size;
  final EdgeInsets? margin;

  const CommonShimmerCircle({
    super.key,
    this.size = 50,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray.withOpacity(.25),
      highlightColor: AppColors.gray.withOpacity(.1),
      child: Container(
        width: size,
        height: size,
        margin: margin,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.light,
        ),
      ),
    );
  }
}

class CommonShimmerCard extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsets? margin;
  final double? borderRadius;

  const CommonShimmerCard({
    super.key,
    this.width = double.infinity,
    this.height = 100,
    this.margin,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray.withOpacity(.25),
      highlightColor: AppColors.gray.withOpacity(.1),
      child: Container(
        width: width,
        height: height,
        margin: margin ?? EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? AppTheme.cardBorderRadius),
          color: AppColors.light,
        ),
      ),
    );
  }
}

class SingleCardTileShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonShimmerCard(height: 52);
  }
}

class DoubleCardTileShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonShimmerCard(height: 108);
  }
}

class SmallCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonShimmerCard(height: 60);
  }
}

class MediumCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonShimmerCard(height: 152);
  }
}

class LargeCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonShimmerCard(height: 180);
  }
}
