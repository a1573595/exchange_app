// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExchangeAdapter extends TypeAdapter<Exchange> {
  @override
  final int typeId = 0;

  @override
  Exchange read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exchange(
      id: fields[0] as int,
      currency: fields[1] as String,
      currencyIcon: fields[2] as String,
      twdPrice: fields[3] as double,
      amountDecimal: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Exchange obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.currency)
      ..writeByte(2)
      ..write(obj.currencyIcon)
      ..writeByte(3)
      ..write(obj.twdPrice)
      ..writeByte(4)
      ..write(obj.amountDecimal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExchangeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exchange _$ExchangeFromJson(Map<String, dynamic> json) => Exchange(
      id: stringToInt(json['id'] as String),
      currency: json['currency'] as String,
      currencyIcon: json['currency_icon'] as String,
      twdPrice: (json['twd_price'] as num).toDouble(),
      amountDecimal: stringToInt(json['amount_decimal'] as String),
    );

Map<String, dynamic> _$ExchangeToJson(Exchange instance) => <String, dynamic>{
      'id': stringFromInt(instance.id),
      'currency': instance.currency,
      'currency_icon': instance.currencyIcon,
      'twd_price': instance.twdPrice,
      'amount_decimal': stringFromInt(instance.amountDecimal),
    };
