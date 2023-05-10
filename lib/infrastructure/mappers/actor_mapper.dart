import 'package:cinemapedia/infrastructure/models/moviedb/credits_responde.dart';

import '../../domain/entities/actor.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTH_QTevurQot4Yp26XD6-YyvtG_yLH-J876A&usqp=CAU',
      character: cast.character);
}
