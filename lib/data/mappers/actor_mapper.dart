import 'package:rappi_themoviedb/domain/entities/entities.dart';
import 'package:rappi_themoviedb/data/models/models.dart';
import 'package:rappi_themoviedb/data/utils/image_url_resolver.dart';

class ActorMapper {
  final ImageUrlResolver _urls;

  const ActorMapper({ImageUrlResolver urls = const ImageUrlResolver()})
      : _urls = urls;

  Actor castToEntity(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath: _urls.profile(cast.profilePath),
        character: cast.character,
      );
}
