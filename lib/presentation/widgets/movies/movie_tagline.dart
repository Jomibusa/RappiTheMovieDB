import 'package:flutter/material.dart';

class MovieTagline extends StatelessWidget {
  final String tagline;

  const MovieTagline({super.key, required this.tagline});

  @override
  Widget build(BuildContext context) {
    if (tagline.isEmpty) return const SizedBox.shrink();

    return Text(
      tagline,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
    );
  }
}
