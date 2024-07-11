import 'package:exchange_app/src/util/string_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("String util test", () {
    test("formatDoubleWithDecimalPlaces", () {
      expect(formatDoubleWithDecimalPlaces(0, 2), '0.00');
      expect(formatDoubleWithDecimalPlaces(123.456, 3), '123.456');
      expect(formatDoubleWithDecimalPlaces(123.4567, 3), '123.457');
      expect(formatDoubleWithDecimalPlaces(-123.456, 3), '-123.456');
      expect(formatDoubleWithDecimalPlaces(-123.4567, 3), '-123.457');

      expect(formatDoubleWithDecimalPlaces(0.000001, 6), '0.000001');
      expect(formatDoubleWithDecimalPlaces(0.00000123456789, 6), '0.000001');
      expect(formatDoubleWithDecimalPlaces(-0.000001, 6), '-0.000001');
      expect(formatDoubleWithDecimalPlaces(-0.00000123456789, 6), '-0.000001');

      expect(() => formatDoubleWithDecimalPlaces(123.456, -1), throwsA(const TypeMatcher<TypeError>()));
    });
  });
}
