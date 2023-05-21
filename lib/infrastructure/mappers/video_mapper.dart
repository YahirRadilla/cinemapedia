import 'package:cinemapedia/infrastructure/models/moviedb/video_response.dart';

import '../../domain/entities/entities.dart';

class VideoMapper {
  static movieDbVideoToEntity(Result videoDb) => Video(
      id: videoDb.id,
      name: videoDb.name,
      youtubeKey: videoDb.key,
      publishedAt: videoDb.publishedAt);
}
