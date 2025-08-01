import 'package:flutter/material.dart';
import 'package:action_slider/action_slider.dart';
import '../../app/app.dart';

class CommonSlideButton extends StatelessWidget {
  final String? label;
  final Future<void> Function(ActionSliderController)? onConfirmation;
  final EdgeInsets? margin;
  final double? height;
  final Widget? icon;
  final bool isHalfWidth;

  const CommonSlideButton({
    Key? key,
    this.label,
    this.onConfirmation,
    this.margin,
    this.height,
    this.icon,
    this.isHalfWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height ?? 60,
      width: isHalfWidth ? context.screenWidth / 2 : null,
      child: ActionSlider.standard(
        rolling: true,
        sliderBehavior: SliderBehavior.move,
        action: onConfirmation ,
        loadingIcon: CircularProgressIndicator(color: AppColors.light,),
        icon: icon ??
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        toggleColor: Theme.of(context).colorScheme.primary,
       successIcon: Icon(Icons.check, color: AppColors.light),
        height: height ?? 60,
        child: Text(
          label ?? AppStrings.slideToConfirm,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}