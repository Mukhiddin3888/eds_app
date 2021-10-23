part of 'albums_bloc.dart';

abstract class AlbumsEvent extends Equatable {
  const AlbumsEvent();


  @override
  List<Object> get props => [];
}

class GetAlbums extends AlbumsEvent{
  final int userId;
  final int albumId;

  GetAlbums({required this.userId, required this.albumId});
}
