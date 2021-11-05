


import 'package:dartz/dartz.dart';
import 'package:test_app_eds/core/errors/failure.dart';
import 'package:test_app_eds/features/get_albums/domain/entities/albums_entity.dart';

abstract class AlbumsRepository{

  Future<Either<Failure, AlbumsEntity>> getAlbums(int userId);

}