import 'package:flutter/material.dart';
import 'package:rappi_themoviedb/domain/entities/entities.dart';

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
                  child: Image.network(
                    actor.profilePath,
                    height: 130,
                    width: 100,
                    fit: BoxFit.cover,
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
