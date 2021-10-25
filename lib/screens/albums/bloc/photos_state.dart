part of 'photos_bloc.dart';

abstract class PhotosState extends Equatable {
  const PhotosState();

  @override
  List<Object> get props => [];
}

class PhotosInitial extends PhotosState {

}

class PhotosLoading extends PhotosState {}
class PhotosLoaded extends PhotosState {

  final List<PhotosModel> photos;

  PhotosLoaded({required this.photos,});


  @override
  List<Object> get props => [photos ];

}
class LoadingError extends PhotosState {

  final String errorMessage;
  LoadingError({ required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

}
