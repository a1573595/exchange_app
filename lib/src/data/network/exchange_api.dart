import 'package:dio/dio.dart';
import 'package:exchange_app/src/data/model/exchange.dart';

abstract class ExchangeApi {
  Future<List<Exchange>> getExchangeList({required CancelToken cancelToken});
}

class ExchangeApiImpl implements ExchangeApi {
  final Dio _dio;

  const ExchangeApiImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<Exchange>> getExchangeList({required CancelToken cancelToken}) => _dio
      .get('v1/pairs', cancelToken: cancelToken)
      .then((value) => value.data as List)
      .then((value) => value.map((e) => Exchange.fromJson(e)))
      .then((value) => value.toList());
}
