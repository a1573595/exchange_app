import 'package:exchange_app/src/data/local/exchange_dao.dart';
import 'package:exchange_app/src/data/model/exchange.dart';

import '../data_source/data_source.dart';

class FakeExchangeDao implements ExchangeDao {
  @override
  List<Exchange> getExchangeList() => DataSource.getExchangeList();

  @override
  Future<void> setExchangeList({required List<Exchange> exchangeList}) async {}
}
