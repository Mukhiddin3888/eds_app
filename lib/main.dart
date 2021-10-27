import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_app_eds/screens/home/home_screen.dart';

import 'models/users_info/address_model.dart';
import 'models/users_info/company_model.dart';
import 'models/users_info/users_info_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive..registerAdapter(UsersModelAdapter());
  Hive..registerAdapter(AddressModelAdapter());
  Hive..registerAdapter(CompanyModelAdapter());
  await Hive.openBox<List>('users');
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}



