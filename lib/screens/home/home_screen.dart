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

    Hive.close();
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
              return UsersInfoItems(state: state.users,);
            } else if (state is UsersError){
              var ldata =  Hive.box<List>('users').get('key')! ;
              return  UsersInfoItems(state: ldata,);
            }else {
              return Text('userName');
            }
          },
        ),
      )
    );
  }
}

class UsersInfoItems extends StatelessWidget {
  const UsersInfoItems({
    Key? key,
    required this.state,
  }) : super(key: key);

  final state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){

            Navigator.push(context, CupertinoPageRoute(
              builder: (context) => UserInfoScreen(
                id: state[index].id,
                name: state[index].name,
                userName: state[index].userName,
                email: state[index].email,
                phone: state[index].phone,
                website: state[index].website,
                compName: state[index].company.name,
                bs: state[index].company.bs,
                street: state[index].address.street,
                suite: state[index].address.suite,
                city: state[index].address.city,

              ),));
          },
          child: ListTile(
            leading: CircleAvatar(),
            title:   Text('${state[index].name}'),
            subtitle:  Text('${state[index].userName}'),
          ),
        );
      },
    );
  }
}
