import 'package:flutter/material.dart';
import 'package:knightassist/src/global/widgets/shimmer_loader.dart';
import 'package:knightassist/src/helpers/constants/app_colors.dart';

class EventCarouselSkeletonLoader extends StatelessWidget {
  const EventCarouselSkeletonLoader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkSkeletonColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [],
      ),
    );
  }
}
