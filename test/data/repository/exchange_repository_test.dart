import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:exchange_app/src/data/repository/exchange_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data_source/data_source.dart';
import '../local/fake_exchange_dao.dart';
import '../network/fake_exchange_api.dart';

void main() {
  final exchangeRepository = ExchangeRepositoryImpl(
    exchangeDao: FakeExchangeDao(),
    exchangeApi: FakeExchangeApi(),
  );

  group("Exchange repository test", () {
    test("getExchangeList", () async {
      final list = await exchangeRepository.getExchangeList(cancelToken: CancelToken());

      expect(const ListEquality().equals(list, DataSource.getExchangeList()), true);
    });
  });
}
