import 'package:dio/dio.dart';

class DioSettings {
   static BaseOptions dioBaseOptions = BaseOptions(

    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: 35000,
    receiveTimeout: 33000,
    followRedirects: false,
    headers: {'Accept-Language': 'uz'},
    validateStatus: (status) {
      return status != null && status <= 500;
    },
  );

}
