import 'package:dio/src/cancel_token.dart';
import 'package:exchange_app/src/data/model/exchange.dart';
import 'package:exchange_app/src/data/network/exchange_api.dart';

import '../data_source/data_source.dart';

class FakeExchangeApi implements ExchangeApi {
  @override
  Future<List<Exchange>> getExchangeList({required CancelToken cancelToken}) => DataSource.exchangeList;
}
