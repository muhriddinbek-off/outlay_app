import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outlay/common/colors/app_colors.dart';
import 'package:outlay/common/extensions/text_extensions.dart';

class CommonDialog extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;

  const CommonDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: REdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            Padding(
              padding: REdgeInsets.symmetric(vertical: 16),
              child: title.s(20).c(AppColors.dodgerBlue),
            ),
            subtitle.s(16).a(TextAlign.center).w(400).copyWith(
                  style: const TextStyle(fontFamily: 'Regular'),
                ),
          
          ],
        ),
      ),
    );
  }
}
