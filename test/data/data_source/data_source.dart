import 'dart:convert';
import 'dart:io';

import 'package:exchange_app/src/data/model/exchange.dart';

class DataSource {
  DataSource._();

  static String _testPath(String relativePath) {
    Directory current = Directory.current;
    String path = current.path.endsWith('/test') ? current.path : '${current.path}/test';
    return '$path/$relativePath';
  }

  static List<Exchange> getExchangeList() {
    final json = File(_testPath('data/data_source/exchange.json')).readAsStringSync();

    final jsonList = (jsonDecode(json) as List);
    final value = jsonList.map((e) => Exchange.fromJson(e));
    return value.toList();
  }

  static final Future<List<Exchange>> exchangeList = File(_testPath('json/exchange.json'))
      .readAsString()
      .then((value) => (jsonDecode(value) as List))
      .then((value) => value.map((e) => Exchange.fromJson(e)))
      .then((value) => value.toList());
}
