import 'package:flutter/material.dart';
import 'package:rappi_themoviedb/domain/entities/entities.dart';
import 'package:rappi_themoviedb/presentation/widgets/widgets.dart';

class ActorHorizontalListview extends StatelessWidget {
  final List<Actor> actors;

  const ActorHorizontalListview({super.key, required this.actors});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: actors.length,
      itemBuilder: (context, index) {
        final actor = actors[index];
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: SizedBox(
            width: 100,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AppNetworkImage(
                    url: actor.profilePath,
                    width: 100,
                    height: 130,
                    errorIcon: Icons.person_outline,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  actor.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
