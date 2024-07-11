import 'package:dio/dio.dart';
import 'package:exchange_app/src/data/local/exchange_dao.dart';
import 'package:exchange_app/src/data/local/hive_helper.dart';
import 'package:exchange_app/src/data/model/exchange.dart';
import 'package:exchange_app/src/data/network/dio_service.dart';
import 'package:exchange_app/src/data/network/exchange_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final exchangeRepository = Provider<ExchangeRepository>((ref) => ExchangeRepositoryImpl(
      exchangeDao: HiveHelper.exchangeDao,
      exchangeApi: ApiService().exchangeApi,
    ));

abstract class ExchangeRepository {
  Future<List<Exchange>> getExchangeList({required CancelToken cancelToken});
}

class ExchangeRepositoryImpl implements ExchangeRepository {
  final ExchangeDao _dao;
  final ExchangeApi _api;

  const ExchangeRepositoryImpl({
    required ExchangeDao exchangeDao,
    required ExchangeApi exchangeApi,
  })  : _dao = exchangeDao,
        _api = exchangeApi;

  @override
  Future<List<Exchange>> getExchangeList({required CancelToken cancelToken}) async {
    final list = _dao.getExchangeList();

    if (list.isNotEmpty) {
      return list;
    } else {
      return _api
          .getExchangeList(cancelToken: cancelToken)
          .then((value) => _dao.setExchangeList(exchangeList: value).then((_) => value));
    }
  }
}
