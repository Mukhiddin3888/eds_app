

import 'package:dio/dio.dart';
import 'package:test_app_eds/core/errors/failure.dart';
import 'package:test_app_eds/core/network/dio_settings.dart';
import 'package:test_app_eds/models/albums/albums_model.dart';
import 'package:test_app_eds/models/posts/posts_model.dart';
import 'package:test_app_eds/models/users_info/users_info_model.dart';

abstract class Repository{

 Future<List<UsersModel>> getUserInfo();
 Future<List<UserPostsModel>> getCurrentUserPosts({required int userId});
 Future<List<AlbumsModel>> getCurrentUserAlbums({required int userId});

}

class RepositoryImpl extends Repository {

  @override
  Future<List<UsersModel>> getUserInfo() async {

    Dio _dio = Dio(DioSettings.dioBaseOptions);

    final Response response = await _dio.get('/users' );
   // print(response);

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      List<UsersModel> users = (response.data as List)
          .map(
            (e) => UsersModel.fromJson(e as Map<String, dynamic>),
      )
          .toList();
      return users;
    } else {
      throw ServerFailure();
    }

  }

  @override
  Future<List<UserPostsModel>> getCurrentUserPosts({required int userId}) async {
    Dio _dio = Dio(DioSettings.dioBaseOptions);

    final Response response = await _dio.get('/posts?userId=$userId' );
    // print(response);

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      List<UserPostsModel> posts = (response.data as List)
          .map(
            (e) => UserPostsModel.fromJson(e as Map<String, dynamic>),
      )
          .toList();
      return posts;
    } else {
      throw ServerFailure();
    }
  }

  Future<List<AlbumsModel>> getCurrentUserAlbums({required int userId}) async {
    Dio _dio = Dio(DioSettings.dioBaseOptions);

    final Response response = await _dio.get('/albums?userId=$userId' );
    // print(response);

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      List<AlbumsModel> posts = (response.data as List)
          .map(
            (e) => AlbumsModel.fromJson(e as Map<String, dynamic>),
      )
          .toList();
      return posts;
    } else {
      throw ServerFailure();
    }
  }


}