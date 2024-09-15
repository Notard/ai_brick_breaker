import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

class ParticleEffect extends PositionComponent {
  final double particleSize;
  final double lifespan;
  final Function onComplete;

  ParticleEffect({
    required this.particleSize,
    required this.lifespan,
    required this.onComplete,
  });

  @override
  void onLoad() {
    super.onLoad();
    final particle = Particle.generate(
      count: 40, // 파티클 개수를 조금 더 늘림
      lifespan: lifespan, // 파티클이 사라지는 시간

      generator: (i) {
        // 파티클의 초기 속도를 약하게 설정
        final randomAngle = Random().nextDouble() * 2 * pi; // 0~2pi 사이의 랜덤 각도
        final speed = Random().nextDouble(); // 속도
        final direction = Vector2(cos(randomAngle), sin(randomAngle)) * speed;

        return AcceleratedParticle(
          acceleration: Vector2.zero(), // 가속도 없이 부드럽게 흩어짐
          speed: direction, // 초기 속도 설정

          lifespan: lifespan,
          child: CircleParticle(
            radius: particleSize, // 파티클의 크기
            // 랜덤한 칼라
            paint: Paint()
              ..color = Color.fromARGB(
                200,
                Random().nextInt(255),
                Random().nextInt(255),
                Random().nextInt(255),
              ),
          ),
        );
      },
    );
    add(ParticleSystemComponent(particle: particle));
    Future.delayed(Duration(seconds: lifespan.toInt()), () {
      onComplete(this);
    });
  }
}
