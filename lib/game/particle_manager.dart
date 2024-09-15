import 'dart:ui';

import 'package:brick_breaker/game/brick_destroy_effect.dart';
import 'package:flame/components.dart';

class ParticleManager extends PositionComponent {
  final List<ParticleEffect> _activeParticles = [];

  void createParticleEffect({
    required Vector2 position,
    required double particleSize,
    required double lifespan,
  }) {
    ParticleEffect particleEffect = ParticleEffect(
      particleSize: particleSize,
      lifespan: lifespan,
      onComplete: (ParticleEffect effect) {
        _removeParticleEffect(effect);
      },
    );
    particleEffect.position = position;
    _activeParticles.add(particleEffect);
    add(particleEffect);
  }

  void _removeParticleEffect(ParticleEffect particleEffect) {
    _activeParticles.remove(particleEffect);
    particleEffect.removeFromParent();
  }
}
