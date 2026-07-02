import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final IconData errorIcon;

  const AppNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.errorIcon = Icons.broken_image_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: width ?? double.infinity,
          height: height ?? double.infinity,
          color: Colors.grey[900],
        );
      },
      errorBuilder: (context, _, __) => Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        color: Colors.grey[900],
        child: Icon(errorIcon, color: Colors.white24, size: 40),
      ),
    );
  }
}
