import 'package:cinemapedia/domain/entities/actor.dart';

abstract class ActorsDatasouces {
  Future<List<Actor>> getActorByMovie(String movieId);
}
