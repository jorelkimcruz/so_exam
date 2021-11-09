import 'package:dio/dio.dart';
import 'package:so_exam/models/user_login.dart';

abstract class LoginServiceProtocol {
  Future<UserLoginModel> login(Map<String, dynamic> login);
  Future<void> getStationList();
}

class LoginService extends LoginServiceProtocol {
  LoginService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  /// Access token is set on Client.,dart
  /// it intercepts request when user is authenticated
  ///
  @override
  Future<void> getStationList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = login;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, dynamic>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/stations?all',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    print(_result);
    return;
  }

  @override
  Future<UserLoginModel> login(Map<String, dynamic> login) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = login;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserLoginModel>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'v2/sessions',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserLoginModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
