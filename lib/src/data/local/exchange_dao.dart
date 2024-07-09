import 'package:exchange_app/src/data/local/hive_helper.dart';
import 'package:exchange_app/src/data/model/exchange.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum _ExchangeKey {
  exchangeList;
}

abstract class ExchangeDao {
  List<Exchange> getExchangeList();

  Future<void> setExchangeList({required List<Exchange> exchangeList});
}

class ExchangeDaoImpl implements ExchangeDao {
  final Box _box;

  const ExchangeDaoImpl({required Box box}) : _box = box;

  @override
  List<Exchange> getExchangeList() => _box.getValue(_ExchangeKey.exchangeList, const []).cast<Exchange>();

  @override
  Future<void> setExchangeList({required List<Exchange> exchangeList}) =>
      _box.setValue(_ExchangeKey.exchangeList, exchangeList);
}
