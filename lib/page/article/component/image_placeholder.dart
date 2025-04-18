import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ImagePlaceholder extends StatelessWidget {
  final double height;
  final double? width;
  const ImagePlaceholder({super.key, this.height = 300, this.width});

  @override
  Widget build(BuildContext context) {
    var icon = Icon(
      HugeIcons.strokeRoundedImage02,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
      size: height / 3,
    );
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      height: height,
      width: width,
      child: icon,
    );
  }
}
