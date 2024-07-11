import 'package:exchange_app/src/util/serializable_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Serializable util test", () {
    test("stringToInt", () {
      expect(stringToInt('0'), 0);
      expect(stringToInt('1'), 1);
      expect(stringToInt('10'), 10);
      expect(stringToInt('-10'), -10);

      expect(stringToInt('9223372036854775807'), 9223372036854775807);
      expect(stringToInt('-9223372036854775808'), -9223372036854775808);

      expect(() => stringToInt(double.maxFinite.toString()), throwsFormatException);
      expect(() => stringToInt(double.minPositive.toString()), throwsFormatException);
    });

    test("intToString", () {
      expect(intToString(0), '0');
      expect(intToString(1), '1');
      expect(intToString(10), '10');
      expect(intToString(-10), '-10');

      expect(intToString(9223372036854775807), '9223372036854775807');
      expect(intToString(-9223372036854775808), '-9223372036854775808');
    });
  });
}
