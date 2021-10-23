import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app_eds/models/albums/albums_model.dart';
import 'package:test_app_eds/repositories/users_info_repository.dart';

part 'albums_event.dart';
part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  AlbumsBloc() : super(AlbumsInitial());

  @override
  Stream<AlbumsState> mapEventToState(
    AlbumsEvent event,
  ) async* {
      if(event is GetAlbums){
        yield* _mapGetAlbumsToState(userId: event.userId,  );
      }
  }


  Stream<AlbumsState> _mapGetAlbumsToState({required int userId, }) async* {

    yield AlbumsLoading();

    try{
      final albums = await RepositoryImpl().getCurrentUserAlbums(userId: userId);

      yield AlbumsLoaded( albums: albums,);
    }
    catch (e){
      print(e);
      yield LoadingError(errorMessage: e.toString());

    }

  }

}
