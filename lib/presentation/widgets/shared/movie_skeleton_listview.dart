import 'package:flutter/material.dart';
import 'package:rappi_themoviedb/config/theme/app_colors.dart';

class MovieSkeletonListview extends StatefulWidget {
  const MovieSkeletonListview({super.key});

  @override
  State<MovieSkeletonListview> createState() => _MovieSkeletonListviewState();
}

class _MovieSkeletonListviewState extends State<MovieSkeletonListview>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor =
        isDark ? AppColors.skeletonBaseDark : AppColors.skeletonBaseLight;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          itemBuilder: (context, _) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 130,
                height: 220,
                color: baseColor.withValues(alpha: _animation.value),
              ),
            ),
          ),
        );
      },
    );
  }
}
