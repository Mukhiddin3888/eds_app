import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app_eds/models/users_info/users_info_model.dart';
import 'package:test_app_eds/repositories/users_info_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial());

  @override
  Stream<UsersState> mapEventToState(
    UsersEvent event,
  ) async* {

    if(event is GetUsers){
      yield* _mapGetUsersToState();
    }

  }


  @override
  Stream<UsersState> _mapGetUsersToState() async* {

    yield UsersLoading();

    try{
        final users = await RepositoryImpl().getUserInfo();

        yield UsersLoaded(users: users);

    }catch (e){
      print(e);
      yield UsersError(message: e.toString());
    }

  }

}
