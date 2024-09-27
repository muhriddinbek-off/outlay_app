import 'package:outlay/common/colors/app_colors.dart';
import 'package:outlay/common/extensions/text_extensions.dart';
import 'package:outlay/common/widgets/scale_animation.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    this.color = AppColors.gainsboro,
    required this.text,
    this.radius = 100,
    this.margin = const EdgeInsets.symmetric(horizontal: 24),
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.shadowColor,
    this.textColor,
    this.loading = false,
  });

  final Color? textColor;
  final Color? shadowColor;
  final VoidCallback onTap;
  final Color color;
  final String text;
  final double radius;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: () => !loading ? onTap() : {},
      child: Container(
        margin: margin,
        padding: padding,
        width: double.maxFinite,
        height: 58,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              color: shadowColor ?? Colors.blue.shade200,
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: loading
              ? const CircularProgressIndicator()
              : text.s(16).c(textColor ?? AppColors.borderwhite).w(700),
        ),
      ),
    );
  }
}
