import 'package:equatable/equatable.dart';
import 'package:exchange_app/src/data/model/exchange.dart';
import 'package:exchange_app/src/util/string_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'convert_ui_state.freezed.dart';

@Freezed(equal: false)
class ConvertUiState with _$ConvertUiState, EquatableMixin {
  const ConvertUiState._();

  const factory ConvertUiState({
    required String amountText,
    required Exchange fromExchange,
    required Exchange toExchange,
    required String rateText,
    required String resultText,
  }) = _ConvertUiState;

  factory ConvertUiState.byDefault({required Exchange exchange}) => ConvertUiState(
        amountText: "1",
        fromExchange: exchange,
        toExchange: exchange,
        rateText: 1.0.toStringAsFixed(exchange.amountDecimal),
        resultText: formatDoubleWithDecimalPlaces(1, exchange.amountDecimal),
      );

  @override
  List<Object?> get props => [
        amountText,
        fromExchange,
        toExchange,
        rateText,
        resultText,
      ];
}
