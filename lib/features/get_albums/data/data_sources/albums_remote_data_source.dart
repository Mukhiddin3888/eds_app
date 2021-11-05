

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_app_eds/core/errors/exeptions.dart';


import 'package:test_app_eds/features/get_albums/data/model/albums_model.dart';

abstract class AlbumsRemoteDataSource{


  Future<AlbumsModel> getAlbums(int userId);
}

class AlbumsRemoteDataSourceImpl implements AlbumsRemoteDataSource{

  final http.Client client;

  AlbumsRemoteDataSourceImpl({required this.client});

  @override
  Future<AlbumsModel> getAlbums(int userId) => _getAlbumsFromUrl('https://jsonplaceholder.typicode.com//albums?userId=$userId');

  Future<AlbumsModel> _getAlbumsFromUrl(String url)async{

    final response =  await client.get(Uri.parse(url), headers: { "Content-Type": 'application/json'});

    if(response.statusCode == 200){
      return AlbumsModel.fromJson(jsonDecode(response.body));
    }else{
      throw ServerException();
    }

  }



}
