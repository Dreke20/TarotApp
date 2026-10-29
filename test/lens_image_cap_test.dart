import 'package:flutter_test/flutter_test.dart';
import 'package:tarot_app/features/lens/data/tarot_lens_service.dart';

void main() {
  test('card photos over about 1.5 MB are not sent', () {
    expect(lensImageWithinCap(kMaxLensImageBytes), isTrue);
    expect(lensImageWithinCap(kMaxLensImageBytes + 1), isFalse);
    expect(kMaxLensImageBytes, (1.5 * 1024 * 1024).floor());
  });
}
