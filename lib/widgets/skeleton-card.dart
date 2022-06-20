import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class SkeletonBlock extends StatelessWidget {

  double height;
  double width;
  Widget? child;

  SkeletonBlock({required this.height, required this.width, this.child });

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SkeletonLoader(
      builder: Container(
        decoration: BoxDecoration(
            color: isDark ? color.withOpacity(0.1): color.withOpacity(0.6),
            borderRadius: BorderRadius.circular(2)
        ),
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}