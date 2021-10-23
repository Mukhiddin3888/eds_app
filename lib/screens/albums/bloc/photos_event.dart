part of 'photos_bloc.dart';

abstract class PhotosEvent extends Equatable {
  const PhotosEvent();

  @override
  List<Object> get props => [];
}

class GetPhotos extends PhotosEvent{
  final int albumId;

  GetPhotos({required this.albumId, });


  @override
  List<Object> get props => [albumId];
}

