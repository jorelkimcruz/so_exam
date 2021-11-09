import 'package:dio/dio.dart';
import 'package:so_exam/models/stations.dart';

abstract class UserServiceProtocol {
  Future<Stations> getStationList();
}

class UserService extends UserServiceProtocol {
  UserService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  /// Access token is set on Client.,dart
  /// it intercepts request when user is authenticated
  ///
  @override
  Future<Stations> getStationList() async {
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result =
        await _dio.request('/stations?all',
            options: Options(
              method: 'GET',
            ),
            data: _data);

    return Stations.fromJson(_result.data!);
  }
}
