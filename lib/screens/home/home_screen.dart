import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_eds/screens/home/bloc/users_bloc.dart';
import 'package:test_app_eds/screens/user_info/user_info_screen.dart';
import 'package:test_app_eds/widgets/error_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test Project'),),
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
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, CupertinoPageRoute(
                          builder: (context) => UserInfoScreen(
                            id: state.users[index].id,
                            name: state.users[index].name,
                            userName: state.users[index].userName,
                            email: state.users[index].email,
                            phone: state.users[index].phone,
                            website: state.users[index].website,
                            compName: state.users[index].company.name,
                            bs: state.users[index].company.bs,
                            street: state.users[index].address.street,
                            suite: state.users[index].address.suite,
                            city: state.users[index].address.city,

                          ),));
                      },
                      child: ListTile(
                        leading: CircleAvatar(),
                      title:   Text('${state.users[index].name}'),
                         subtitle:  Text('${state.users[index].userName}'),
                      ),
                    );
                  },
                  );
            } else if (state is UsersError){
              return ErrorButton(onTap: (){
                context.read<UsersBloc>().add(GetUsers());
              });            }else {
              return Text('userName');
            }
          },
        ),
      ),
    );
  }
}
