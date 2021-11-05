



import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app_eds/core/errors/failure.dart';
import 'package:test_app_eds/core/usecase/usecases.dart';
import 'package:test_app_eds/features/get_albums/domain/entities/albums_entity.dart';
import 'package:test_app_eds/features/get_albums/domain/repositories/albums_repository.dart';

class GetAlbumsUseCase implements UseCase<AlbumsEntity, Params>{

final AlbumsRepository albumsRepository;

  GetAlbumsUseCase({ required this.albumsRepository});

  @override
  Future<Either<Failure, AlbumsEntity>> call(Params params) async {

    return await albumsRepository.getAlbums(params.number);

  }
}





class Params extends Equatable{

  final int number;

  const Params({ required this.number});

  @override
  List<Object> get props => [number];

}