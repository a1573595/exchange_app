import 'package:collection/collection.dart';
import 'package:exchange_app/src/data/local/hive_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../util/test_util.dart';
import '../data_source/data_source.dart';

void main() {
  group("Exchange dao test", () {
    setUpAll(() async {
      final dir = await getHiveTempDir();
      Hive.init(dir.path);
      await HiveHelper.init();
    });

    tearDownAll(() async {
      await Hive.deleteFromDisk();
    });

    test("getExchangeList", () {
      final list = HiveHelper.exchangeDao.getExchangeList();

      expect(const ListEquality().equals(list, const []), true);
    });

    test("setExchangeList", () async {
      await HiveHelper.exchangeDao.setExchangeList(exchangeList: DataSource.getExchangeList());

      final list = HiveHelper.exchangeDao.getExchangeList();

      expect(const ListEquality().equals(list, DataSource.getExchangeList()), true);
    });
  });
}
