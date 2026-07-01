import 'package:flutter_test/flutter_test.dart';
import 'package:rappi_themoviedb/data/mappers/actor_mapper.dart';
import 'package:rappi_themoviedb/data/models/moviedb/credits_response.dart';

void main() {
  group('ActorMapper.castToEntity', () {
    test(
        'Given un Cast con profilePath, '
        'When se mapea a la entidad de dominio, '
        'Then arma la URL completa de la foto de perfil', () {
      // Given
      const cast = Cast(
        adult: false,
        gender: 2,
        id: 1,
        knownForDepartment: 'Acting',
        name: 'José Bueno',
        originalName: 'José Miguel Bueno Sánchez',
        popularity: 20.0,
        profilePath: '/profile.jpg',
        creditId: 'credit1',
        character: 'Spiderman',
      );

      // When
      final actor = ActorMapper.castToEntity(cast);

      // Then
      expect(actor.id, 1);
      expect(actor.name, 'José Bueno');
      expect(actor.character, 'Spiderman');
      expect(
        actor.profilePath,
        'https://image.tmdb.org/t/p/w500/profile.jpg',
      );
    });

    test(
        'Given un Cast sin profilePath, '
        'When se mapea a la entidad de dominio, '
        'Then usa la imagen de reemplazo por defecto', () {
      // Given
      const cast = Cast(
        adult: false,
        gender: 1,
        id: 2,
        knownForDepartment: 'Acting',
        name: 'José Bueno',
        originalName: 'José Miguel Bueno Sánchez',
        popularity: 5.0,
        profilePath: null,
        creditId: 'credit2',
        character: 'Extra',
      );

      // When
      final actor = ActorMapper.castToEntity(cast);

      // Then
      expect(actor.profilePath, isNot(contains('image.tmdb.org')));
    });
  });
}
