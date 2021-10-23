part of 'albums_bloc.dart';

abstract class AlbumsState extends Equatable {
  const AlbumsState();
  @override
  List<Object> get props => [];
}

class AlbumsInitial extends AlbumsState {}

class AlbumsLoading extends AlbumsState {}
class AlbumsLoaded extends AlbumsState {

  final List<AlbumsModel> albums;
  final List<PhotosModel> photos;

  AlbumsLoaded({required this.albums, required this.photos});


  @override
  List<Object> get props => [albums, photos];

}
class LoadingError extends AlbumsState {

  final String errorMessage;
  LoadingError({ required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

}

