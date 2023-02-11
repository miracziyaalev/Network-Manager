import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reqres/users/model/detail_model.dart';
import 'package:reqres/users/model/users_model.dart';

abstract class IUserServices {
  Future<List<UsersModel>?> getUserList();
  Future<List<DetailModel>?> fetchDetail(int postId);
}

class UserServices implements IUserServices {
  late final Dio _reqresManager;

  UserServices() : _reqresManager = Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com/"));

  @override
  Future<List<UsersModel>?> getUserList() async {
    try {
      final response = await _reqresManager.get(_RequestPaths.posts.name);

      if (response.statusCode == HttpStatus.ok) {
        final datas = response.data;

        if (datas is List) {
          return datas.map((e) => UsersModel.fromJson(e)).toList();
        }
      }
      return null;
    } on DioError catch (error) {
      _ShowDebug()._showDioDebugError(error);
    }
    return null;
  }

  @override
  Future<List<DetailModel>?> fetchDetail(int postId) async {
    try {
      final response = await _reqresManager
          .get(_RequestPaths.comments.name, queryParameters: {_QueryParameters.postId.name: postId});

      if (response.statusCode == HttpStatus.ok) {
        final datas = response.data;

        if (datas is List) {
          return datas.map((e) => DetailModel.fromJson(e)).toList();
        }
      }
    } on DioError catch (error) {
      _ShowDebug()._showDioDebugError(error);
    }
    return null;
  }
}

class _ShowDebug {
  void _showDioDebugError(DioError error) {
    if (kDebugMode) {
      print(error.message);
    }
  }
}

enum _RequestPaths {
  posts,
  comments,
}

enum _QueryParameters {
  postId,
}
