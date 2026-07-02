const _tmdbBase = 'https://image.tmdb.org/t/p/w500';
const _fallbackPoster = 'https://placehold.co/500x750/1a1a2e/ffffff?text=No+Poster';
const _fallbackBackdrop = 'https://placehold.co/1280x720/1a1a2e/ffffff?text=No+Image';
const _fallbackProfile = 'https://placehold.co/500x750/1a1a2e/ffffff?text=No+Photo';

class ImageUrlResolver {
  const ImageUrlResolver();

  String poster(String? path) =>
      (path != null && path.isNotEmpty) ? '$_tmdbBase$path' : _fallbackPoster;

  String backdrop(String? path) =>
      (path != null && path.isNotEmpty) ? '$_tmdbBase$path' : _fallbackBackdrop;

  String profile(String? path) =>
      (path != null && path.isNotEmpty) ? '$_tmdbBase$path' : _fallbackProfile;
}
