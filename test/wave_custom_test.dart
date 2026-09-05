import 'package:wave_custom/wave_custom.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('WaveCustom.circle debe tener los valores por defecto correctos', () {
    final wave = ShapeMode.circle();

    expect(wave.shape, HeartbeatShape.circle);
    expect(wave.checkScale, 0.6);
    expect(wave.zigzagHeightScale, 0.7);
  });
}
