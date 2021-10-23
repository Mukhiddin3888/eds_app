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

  AlbumsLoaded({required this.albums,});


  @override
  List<Object> get props => [albums, ];

}
class LoadingError extends AlbumsState {

  final String errorMessage;
  LoadingError({ required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

}

