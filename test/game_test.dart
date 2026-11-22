import 'package:bulmaca_motoru/bulmaca_motoru.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oyun_sayi_birlestirme/oyun_sayi_birlestirme.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('33 dilde ad ve anlatım', () {
    expect(zincirConfig.title.length, 33);
    expect(zincirConfig.tagline.length, 33);
    for (final s in zincirConfig.tutorial) {
      expect(s.text.length, 33);
    }
  });

  test('bölümler üretilir, doğrulanır ve kaydedilip geri yüklenir', () {
    final planner = LevelPlanner(gameId: zincirId, optionalMechanics: const []);
    for (final lv in [1, 77, 1500, 33333, 99999]) {
      final gl = zincirRules.build(planner.spec(lv));
      expect(gl.validation.ok, isTrue, reason: 'bölüm $lv');
      final k = zincirRules.kindForLevel(gl.spec.difficulty);
      final start = k.initial(gl.puzzle);
      expect(PState.restore(start.serialize(), gl.puzzle), isNotNull);
      expect(PLevel.fromJson(gl.puzzle.toJson()).toJson().toString(), gl.puzzle.toJson().toString());
    }
  });
}
