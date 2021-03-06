

import 'package:dio/dio.dart';
import 'package:test_app_eds/core/errors/failure.dart';
import 'package:test_app_eds/core/network/dio_settings.dart';
import 'package:test_app_eds/core/storage/hive.dart';
import 'package:test_app_eds/models/albums/albums_model.dart';
import 'package:test_app_eds/models/comments/comments_model.dart';
import 'package:test_app_eds/models/photos/photos_model.dart';
import 'package:test_app_eds/models/posts/posts_model.dart';
import 'package:test_app_eds/models/users_info/users_info_model.dart';

abstract class Repository{

 Future<List<UsersModel>> getUserInfo();
 Future<List<UserPostsModel>> getCurrentUserPosts({required int userId});
 Future<List<CommentsModel>> getCurrentUserPostsComments({required int postId});
 Future<List<AlbumsModel>> getCurrentUserAlbums({required int userId});
 Future<List<PhotosModel>> getCurrentUserAlbumsPhoto({required int albumId});

 Future<void> postCurrentUserPostsComments({required int postId,required CommentsModel commentsModel});

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


      HiveStoreMe.putData(boxName: 'users', keyWord: 'key', data: users);



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
      ).toList();


      HiveStoreMe.putData(boxName: 'posts', keyWord: 'post$userId', data: posts);




      return posts;

    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<List<AlbumsModel>> getCurrentUserAlbums({required int userId}) async {
    Dio _dio = Dio(DioSettings.dioBaseOptions);

    final Response response = await _dio.get('/albums?userId=$userId' );
    // print(response);

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      List<AlbumsModel> albums = (response.data as List)
          .map(
            (e) => AlbumsModel.fromJson(e as Map<String, dynamic>),
      )
          .toList();

      HiveStoreMe.putData(boxName: 'albums', keyWord: 'album$userId', data: albums);

      return albums;
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<List<PhotosModel>> getCurrentUserAlbumsPhoto({required int albumId}) async {
    Dio _dio = Dio(DioSettings.dioBaseOptions);

    final Response response = await _dio.get('/photos?albumId=$albumId' );
    // print(response);

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      List<PhotosModel> photos = (response.data as List)
          .map(
            (e) => PhotosModel.fromJson(e as Map<String, dynamic>),
      )
          .toList();

      HiveStoreMe.putData(boxName: 'photos', keyWord: 'photo$albumId', data: photos);

      return photos;
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<List<CommentsModel>> getCurrentUserPostsComments({required int postId}) async{
    Dio _dio = Dio(DioSettings.dioBaseOptions);
    final Response response = await _dio.get('/comments?postId=$postId' );
    // print(response);

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      List<CommentsModel> comments = (response.data as List)
          .map(
            (e) => CommentsModel.fromJson(e as Map<String, dynamic>),
      )
          .toList();

      HiveStoreMe.putData(boxName: 'comments', keyWord: 'comment$postId', data: comments);

      return comments;
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<void> postCurrentUserPostsComments({required int postId, required CommentsModel commentsModel}) async {
    Dio _dio = Dio(DioSettings.dioBaseOptions);
    final Response response = await _dio.post(
      '/comments?postId=$postId',
      data: commentsModel,
    );
    print('/comment/');
    print('postId = $postId');
    print(response.data);
    print(response.statusCode);
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
    } else {
      throw ServerFailure();
    }

  }




}