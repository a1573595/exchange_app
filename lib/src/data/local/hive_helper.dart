import 'package:exchange_app/src/data/local/exchange_dao.dart';
import 'package:exchange_app/src/data/model/exchange.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  const HiveHelper._();

  static late final Box _box;

  static late final ExchangeDao _exchangeDao;

  static ExchangeDao get exchangeDao => _exchangeDao;

  static Future<void> init() async {
    Hive.registerAdapter<Exchange>(ExchangeAdapter());
    _box = await Hive.openBox('exchange');

    _exchangeDao = ExchangeDaoImpl(box: _box);
  }

  static Future<void> close() => _box.close();
}

extension BoxExtension on Box {
  T getValue<T>(Enum key, T defaultValue) => get(key.name, defaultValue: defaultValue);

  Future<void> setValue<T>(Enum key, T? value) => null != value ? put(key.name, value) : delete(key.name);
}
