import 'package:dio/dio.dart';
import 'package:exchange_app/src/data/network/exchange_api.dart';

class ApiService {
  static final ApiService _instance = ApiService._();

  factory ApiService() => _instance;

  late final ExchangeApi _exchangeApi;

  ExchangeApi get exchangeApi => _exchangeApi;

  ApiService._() {
    final dio = Dio(BaseOptions(
      baseUrl: "https://65efcc68ead08fa78a50f929.mockapi.io/api/",
      headers: {
        Headers.contentTypeHeader: Headers.jsonContentType,
      },
    ));

    _exchangeApi = ExchangeApiImpl(dio: dio);
  }
}
