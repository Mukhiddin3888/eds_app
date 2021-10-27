import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:test_app_eds/screens/home/bloc/users_bloc.dart';
import 'package:test_app_eds/screens/user_info/user_info_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void dispose() {

    Hive.box('users').close();
    super.dispose();
  }

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
            }
            else if(state is UsersLoaded){
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
              var ldata =  Hive.box<List>('users').get('key')! ;
              return ListView.builder(
                itemCount: ldata.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){

                      Navigator.push(context, CupertinoPageRoute(
                        builder: (context) => UserInfoScreen(
                          id: ldata[index].id,
                          name: ldata[index].name,
                          userName: ldata[index].userName,
                          email: ldata[index].email,
                          phone: ldata[index].phone,
                          website: ldata[index].website,
                          compName: ldata[index].company.name,
                          bs: ldata[index].company.bs,
                          street: ldata[index].address.street,
                          suite: ldata[index].address.suite,
                          city: ldata[index].address.city,

                        ),));
                    },
                    child: ListTile(
                      leading: CircleAvatar(),
                      title:   Text('${ldata[index].name}'),
                      subtitle:  Text('${ldata[index].userName}'),
                    ),
                  );
                },
              );
            }else {
              return Text('userName');
            }
          },
        ),
      )
    );
  }
}
