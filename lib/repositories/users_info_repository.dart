

import 'package:dio/dio.dart';
import 'package:test_app_eds/core/errors/failure.dart';
import 'package:test_app_eds/core/network/dio_settings.dart';
import 'package:test_app_eds/models/users_info/users_info_model.dart';

abstract class Repository{

 Future<List<UsersModel>> getUserInfo();

}

class RepositoryImpl extends Repository {

  @override
  Future<List<UsersModel>> getUserInfo() async {

    Dio _dio = Dio(DioSettings.dioBaseOptions);

    final Response response = await _dio.get('/users' );
    print(response);

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      List<UsersModel> users = (response.data['results'] as List)
          .map(
            (e) => UsersModel.fromJson(e as Map<String, dynamic>),
      )
          .toList();
      return users;
    } else {
      throw ServerFailure();
    }

  }



}