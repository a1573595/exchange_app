import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:decimal/decimal.dart';
import 'package:exchange_app/src/data/model/exchange.dart';
import 'package:exchange_app/src/data/repository/exchange_repository.dart';
import 'package:exchange_app/src/ui/l10n/l10n.dart';
import 'package:exchange_app/src/ui/page/bean/convert_ui_state.dart';
import 'package:exchange_app/src/ui/style/format_style.dart';
import 'package:exchange_app/src/ui/style/regex_style.dart';
import 'package:exchange_app/src/ui/style/widget_style.dart';
import 'package:exchange_app/src/ui/widget/picker_sheet.dart';
import 'package:exchange_app/src/ui/widget/twice_pop_scope.dart';
import 'package:exchange_app/src/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'home_page.dart';

part 'rate_page.dart';

part 'convert_page.dart';

final pagePositionProvider = StateProvider.autoDispose<int>((ref) => 0);

final exchangeListProvider = FutureProvider.autoDispose<List<Exchange>>((ref) {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());

  return ref.read(exchangeRepository).getExchangeList(cancelToken: cancelToken);
});

final convertUiStateProvider =
    NotifierProvider.autoDispose<ConvertUiStateNotifier, ConvertUiState>(ConvertUiStateNotifier.new);

class ConvertUiStateNotifier extends AutoDisposeNotifier<ConvertUiState> {
  Decimal _amountDecimal = Decimal.fromInt(1);
  Decimal _rateDecimal = Decimal.fromInt(1);

  @override
  ConvertUiState build() {
    final list = ref.read(exchangeListProvider.select((value) => value.requireValue));

    return ConvertUiState.byDefault(exchange: list.first);
  }

  void updateAmountText(String value) => _calculateResult(amountDecimal: Decimal.tryParse(value));

  void updateFromExchange(Exchange value) => _calculateResult(fromExchange: value);

  void switchExchange() => _calculateResult(fromExchange: state.toExchange, toExchange: state.fromExchange);

  void updateToExchange(Exchange value) => _calculateResult(toExchange: value);

  void _calculateResult({Decimal? amountDecimal, Exchange? fromExchange, Exchange? toExchange}) {
    _amountDecimal = amountDecimal ?? _amountDecimal;

    if (fromExchange != null || toExchange != null) {
      _calculateRateDecimal(fromExchange: fromExchange, toExchange: toExchange);
    }

    final result = (_amountDecimal * _rateDecimal).toDouble();

    state = state.copyWith(
      amountText: _amountDecimal.toString(),
      fromExchange: fromExchange ??= state.fromExchange,
      toExchange: toExchange ??= state.toExchange,
      rateText: _rateDecimal.toStringAsFixed(toExchange.amountDecimal),
      resultText: formatDoubleWithDecimalPlaces(result, toExchange.amountDecimal),
    );
  }

  void _calculateRateDecimal({Exchange? fromExchange, Exchange? toExchange}) {
    fromExchange ??= state.fromExchange;
    toExchange ??= state.toExchange;

    final fromDecimal = Decimal.fromJson(fromExchange.twdPrice.toString());
    final toDecimal = Decimal.fromJson(toExchange.twdPrice.toString());

    _rateDecimal = (fromDecimal / toDecimal).toDecimal(
      scaleOnInfinitePrecision: fromExchange.amountDecimal + toExchange.amountDecimal,
    );
  }
}
