import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:practiceinsights_emr_provider/core/config/http_config.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:rxdart/rxdart.dart';

class HttpService {
  static final HttpService _instance = HttpService._();

  final String _baseUrl = HttpConfig.BASE_URL;

  HttpService._();

  factory HttpService() {
    return _instance;
  }

  Map<String, String> get _defaultHeader => {
        'Authorization': 'Bearer ${TokenService().token}',
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json, text/plain, */*'
      };

  ///
  /// Http [GET] method.
  /// Method Params:
  /// [path] = URL path after [HttpConfig.BASE_URL]
  /// Return type: [Observable]
  ///
  Observable<T> get<T>({@required path}) {
    return Observable.fromFuture(http.get(
      '$_baseUrl/$path',
      headers: _defaultHeader,
    )).flatMap((_) {
      if (_.statusCode >= 400) {
        return Observable.error(_.body);
      } else {
        return Observable.just(_);
      }
    }).map((_) => jsonDecode(_.body));
  }

  ///
  /// Http [POST] method.
  /// Method Params:
  /// [url] = URL path after [HttpConfig.BASE_URL]
  /// [encodedJson] = json body
  /// Return type: [Observable]
  ///
  Observable<T> post<T>({@required String url, @required String encodedJson}) {
    return Observable.fromFuture(http.post(
      '$_baseUrl/$url',
      headers: _defaultHeader,
      body: encodedJson,
    )).flatMap((_) {
      if (_.statusCode >= 400) {
        return Observable.error(
          Failure(
            code: _.statusCode,
            message: _.reasonPhrase,
          ),
        );
      } else {
        return Observable.just(_);
      }
    }).map((_) => jsonDecode(_.body));
  }

  ///
  /// Http [PUT] method.
  /// Method Params:
  /// [url] = URL path after [HttpConfig.BASE_URL]
  /// [encodedJson] = json body
  /// Return type: [Observable]
  ///
  Observable<T> put<T>({@required String url, @required String encodedJson}) {
    return Observable.fromFuture(http.put('$_baseUrl/$url',
            headers: _defaultHeader, body: encodedJson))
        .flatMap((_) {
      if (_.statusCode >= 400) {
        return Observable.error(_.body);
      } else {
        return Observable.just(_);
      }
    }).map((_) => jsonDecode(_.body));
  }

  ///
  /// Http [DELETE] method.
  /// Method Params:
  /// [url] = URL path after [HttpConfig.BASE_URL]
  /// Return type: [Observable]
  ///
  Observable<T> delete<T>({@required String url}) {
    return Observable.fromFuture(
            http.delete('$_baseUrl/$url', headers: _defaultHeader))
        .flatMap((_) {
      if (_.statusCode >= 400) {
        return Observable.error(_.body);
      } else {
        return Observable.just(_);
      }
    }).map((_) => jsonDecode(_.body));
  }
}
