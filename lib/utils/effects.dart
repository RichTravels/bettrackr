// lib/utils/effects.dart
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Public API
void showMoneyRain(BuildContext context, {Duration? duration}) {
  _insertOverlay(
    context,
    _MoneyRain(duration: duration ?? const Duration(milliseconds: 1400)),
    duration ?? const Duration(milliseconds: 1400),
  );
}

void showHotStreakFire(BuildContext context, {int streak = 3, Duration? duration}) {
  _insertOverlay(
    context,
    _FireRiseBanner(
      label: 'HOT STREAK: ${streak}W 🔥',
      duration: duration ?? const Duration(milliseconds: 1400),
    ),
    duration ?? const Duration(milliseconds: 1400),
  );
}

void showColdStreakIce(BuildContext context, {int streak = 3, Duration? duration}) {
  _insertOverlay(
    context,
    _SnowFallBanner(
      label: 'COLD STREAK: ${streak}L ❄️',
      duration: duration ?? const Duration(milliseconds: 1400),
    ),
    duration ?? const Duration(milliseconds: 1400),
  );
}

/// Overlay helper
void _insertOverlay(BuildContext context, Widget child, Duration life) {
  final overlay = Overlay.of(context);
  if (overlay == null) return;
  late OverlayEntry entry;
  entry = OverlayEntry(builder: (_) => child);
  overlay.insert(entry);
  Timer(life + const Duration(milliseconds: 200), entry.remove);
}

/// ===== MONEY RAIN =====
class _MoneyRain extends StatelessWidget {
  final Duration duration;
  const _MoneyRain({required this.duration});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final rng = math.Random();

    // spawn bills + money-with-wings
    final particles = List.generate(24, (i) {
      final x = rng.nextDouble() * size.width;
      final s = 0.8 + rng.nextDouble() * 1.2; // scale
      final d = Duration(milliseconds: 900 + rng.nextInt(900));
      final drift = 20 + rng.nextDouble() * 40;
      final emoji = rng.nextBool() ? '💵' : '💸';
      final delay = Duration(milliseconds: rng.nextInt(250));
      return _FallingEmoji(
        emoji: emoji,
        startX: x,
        scale: s,
        duration: d,
        totalSize: size,
        drift: drift,
        startDelay: delay,
        rotate: rng.nextBool(),
      );
    });

    return IgnorePointer(
      child: Stack(
        children: [
          // subtle darken to make it pop
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.05)),
          ),
          ...particles,
        ],
      ),
    );
  }
}

class _FallingEmoji extends StatelessWidget {
  final String emoji;
  final double startX;
  final double scale;
  final Duration duration;
  final Duration startDelay;
  final Size totalSize;
  final double drift;
  final bool rotate;

  const _FallingEmoji({
    required this.emoji,
    required this.startX,
    required this.scale,
    required this.duration,
    required this.totalSize,
    required this.drift,
    required this.startDelay,
    required this.rotate,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: -80, end: totalSize.height + 80),
      duration: duration,
      curve: Curves.easeIn,
      onEnd: () {},
      builder: (context, y, child) {
        final t = (y + 80) / (totalSize.height + 160); // 0..1
        final x = startX + math.sin(t * math.pi * 2) * drift;
        final rot = rotate ? (t * 2 * math.pi) : 0.0;

        return Positioned(
          top: y,
          left: x.clamp(0.0, totalSize.width - 32),
          child: Opacity(
            opacity: 0.15 + 0.85 * (1.0 - (y / (totalSize.height + 80)).clamp(0.0, 1.0)),
            child: Transform.rotate(
              angle: rot,
              child: Transform.scale(
                scale: scale,
                child: Text(emoji, style: const TextStyle(fontSize: 28)),
              ),
            ),
          ),
        );
      },
      // simple delay by starting off-screen then rebuilding
      child: null,
    );
  }
}

/// ===== FIRE (hot streak) =====
class _FireRiseBanner extends StatelessWidget {
  final String label;
  final Duration duration;
  const _FireRiseBanner({required this.label, required this.duration});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final rng = math.Random();

    final flames = List.generate(18, (i) {
      final x = rng.nextDouble() * size.width;
      final s = 0.9 + rng.nextDouble() * 1.3;
      final d = Duration(milliseconds: 900 + rng.nextInt(800));
      final drift = 10 + rng.nextDouble() * 30;
      return _RisingEmoji(
        emoji: '🔥',
        startX: x,
        scale: s,
        duration: d,
        totalSize: size,
        drift: drift,
      );
    });

    return IgnorePointer(
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.orange.withOpacity(0.12),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          ...flames,
          // Center banner
          Center(
            child: _GlassBanner(text: label, accent: Colors.orange),
          ),
        ],
      ),
    );
  }
}

class _RisingEmoji extends StatelessWidget {
  final String emoji;
  final double startX;
  final double scale;
  final Duration duration;
  final Size totalSize;
  final double drift;

  const _RisingEmoji({
    required this.emoji,
    required this.startX,
    required this.scale,
    required this.duration,
    required this.totalSize,
    required this.drift,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: totalSize.height + 60, end: -80),
      duration: duration,
      curve: Curves.easeOut,
      builder: (context, y, _) {
        final t = 1.0 - ((y + 80) / (totalSize.height + 140)).clamp(0.0, 1.0);
        final x = startX + math.sin(t * math.pi * 2) * drift;
        return Positioned(
          top: y,
          left: x.clamp(0.0, totalSize.width - 32),
          child: Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: 0.2 + 0.8 * t,
              child: Text(emoji, style: const TextStyle(fontSize: 28)),
            ),
          ),
        );
      },
    );
  }
}

/// ===== ICE (cold streak) =====
class _SnowFallBanner extends StatelessWidget {
  final String label;
  final Duration duration;
  const _SnowFallBanner({required this.label, required this.duration});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final rng = math.Random();

    final flakes = List.generate(24, (i) {
      final x = rng.nextDouble() * size.width;
      final s = 0.8 + rng.nextDouble() * 1.4;
      final d = Duration(milliseconds: 1000 + rng.nextInt(900));
      final drift = 15 + rng.nextDouble() * 35;
      return _FallingEmoji(
        emoji: '❄️',
        startX: x,
        scale: s,
        duration: d,
        totalSize: size,
        drift: drift,
        startDelay: Duration(milliseconds: rng.nextInt(200)),
        rotate: false,
      );
    });

    return IgnorePointer(
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.lightBlueAccent.withOpacity(0.10),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          ...flakes,
          Center(child: _GlassBanner(text: label, accent: Colors.lightBlueAccent)),
        ],
      ),
    );
  }
}

class _GlassBanner extends StatelessWidget {
  final String text;
  final Color accent;
  const _GlassBanner({required this.text, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.35),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withOpacity(0.7), width: 1.2),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
