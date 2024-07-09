import 'package:dio/src/cancel_token.dart';
import 'package:exchange_app/src/data/model/exchange.dart';
import 'package:exchange_app/src/data/repository/exchange_repository.dart';

import '../data_source/data_source.dart';

class FakeExchangeRepository implements ExchangeRepository {
  @override
  Future<List<Exchange>> getExchangeList({required CancelToken cancelToken}) => DataSource.exchangeList;
}
