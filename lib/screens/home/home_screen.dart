import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_eds/screens/home/bloc/users_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => UsersBloc(),
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if(state is UsersInitial){
              context.watch<UsersBloc>().add(GetUsers());
              return Container();
            }else if(state is UsersLoading){
              return Center(child: CircularProgressIndicator());
            }else if(state is UsersLoaded){
              return ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(),
                    title:   Text('${state.users[index].name}'),
                       subtitle:  Text('${state.users[index].userName}'),
                    );
                  },
                  );
            } else if (state is UsersError){
              return Center(child: Text('Error Please Check'));
            }else {
              return Text('userName');
            }
          },
        ),
      ),
    );
  }
}
