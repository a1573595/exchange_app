import 'package:equatable/equatable.dart';
import 'package:exchange_app/src/util/serializable_util.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exchange.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Exchange with EquatableMixin, HiveObjectMixin {
  @HiveField(0)
  @JsonKey(fromJson: stringToInt, toJson: stringFromInt)
  final int id;
  @HiveField(1)
  final String currency;
  @HiveField(2)
  @JsonKey(name: "currency_icon")
  final String currencyIcon;
  @HiveField(3)
  @JsonKey(name: "twd_price")
  final double twdPrice;
  @HiveField(4)
  @JsonKey(name: "amount_decimal", fromJson: stringToInt, toJson: stringFromInt)
  final int amountDecimal;

  Exchange({
    required this.id,
    required this.currency,
    required this.currencyIcon,
    required this.twdPrice,
    required this.amountDecimal,
  });

  factory Exchange.fromJson(Map<String, dynamic> json) => _$ExchangeFromJson(json);

  @override
  List<Object?> get props => [
    id,
    currency,
    currencyIcon,
    twdPrice,
    amountDecimal,
  ];
}
