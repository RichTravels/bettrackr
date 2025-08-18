// lib/widgets/app_logo.dart
import 'package:flutter/material.dart';

/// Centered “BET ▷ SHIELD ◁ TRACKR” word-mark.
/// Usage:  AppBar(title: const AppLogo(fontSize: 26))
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.fontSize = 22,
    this.badgeCount,
    this.shieldScale = 1.35, // tweak if you want the shield a touch bigger/smaller
  });

  /// Text size for BET and TRACKR
  final double fontSize;

  /// Optional small number above the shield (e.g., live bets count)
  final int? badgeCount;

  /// Multiplier from fontSize to shield square size
  final double shieldScale;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _GradientWord(
              'BET',
              fontSize: fontSize,
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF00E5C0), // teal
                  Color(0xFF5CF3E3), // aqua
                ],
              ),
            ),
            SizedBox(width: fontSize * 0.42),
            _SpikyShield(size: fontSize * shieldScale),
            SizedBox(width: fontSize * 0.42),
            _GradientWord(
              'TRACKR',
              fontSize: fontSize,
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF3AA1FF), // blue
                  Color(0xFF00E58E), // green
                ],
              ),
            ),
          ],
        ),

        if (badgeCount != null && badgeCount! > 0)
          Positioned(
            top: -fontSize * 0.9,
            child: _BadgePill(
              label: '×$badgeCount',
              bg: const Color(0xFF2E2E2E),
              fg: Colors.white,
              paddingH: 8,
              height: fontSize * 0.9,
            ),
          ),
      ],
    );
  }
}

class _GradientWord extends StatelessWidget {
  const _GradientWord(
      this.text, {
        required this.fontSize,
        required this.gradient,
      });

  final String text;
  final double fontSize;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    // ShaderMask keeps the gradient perfectly mapped to the actual text bounds.
    return ShaderMask(
      shaderCallback: (Rect bounds) => gradient.createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: Text(
        text,
        textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          letterSpacing: 2.0,
          color: Colors.white, // masked by the shader
        ),
      ),
    );
  }
}

class _SpikyShield extends StatelessWidget {
  const _SpikyShield({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    // Square so it never looks “stepped on” (squished).
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _SpikyShieldPainter(),
      ),
    );
  }
}

class _SpikyShieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Base shield path with THREE spikes (left corner, center, right corner)
    // Proportions tuned to match your screenshot vibe.
    final top = h * 0.28;
    final spikeCenter = h * 0.18;
    final spikeCorner = h * 0.12;

    final path = Path()
      ..moveTo(w * 0.16, top)
    // left-corner spike
      ..lineTo(w * 0.24, top - spikeCorner)
      ..lineTo(w * 0.31, top)
    // run to just before center spike
      ..lineTo(w * 0.44, top)
    // big center spike
      ..lineTo(w * 0.50, top - spikeCenter)
      ..lineTo(w * 0.56, top)
    // to just before right-corner spike
      ..lineTo(w * 0.69, top)
    // right-corner spike
      ..lineTo(w * 0.76, top - spikeCorner)
      ..lineTo(w * 0.84, top)
    // taper down the right side, curve to bottom point, then back up left
      ..lineTo(w * 0.86, top + h * 0.34)
      ..quadraticBezierTo(w * 0.84, top + h * 0.64, w * 0.50, h * 0.93)
      ..quadraticBezierTo(w * 0.16, top + h * 0.64, w * 0.14, top + h * 0.34)
      ..close();

    // Fill with vertical gradient (teal → aqua), then a subtle outline.
    final fill = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF00E5C0), Color(0xFF4FEFE0)],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(path, fill);

    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = h * 0.06
      ..color = Colors.black.withOpacity(0.20);
    canvas.drawPath(path, stroke);

    // Inner soft highlight
    final inner = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.22, top + h * 0.12, w * 0.56, h * 0.40),
        Radius.circular(h * 0.16),
      ));
    canvas.drawPath(
      inner,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white24, Colors.white10, Colors.transparent],
          stops: [0.0, 0.5, 1.0],
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );

    // Diamond behind the check (subtle)
    final diamond = Path()
      ..moveTo(w * 0.50, top + h * 0.18)
      ..lineTo(w * 0.60, top + h * 0.30)
      ..lineTo(w * 0.50, top + h * 0.42)
      ..lineTo(w * 0.40, top + h * 0.30)
      ..close();
    canvas.drawPath(diamond, Paint()..color = Colors.white.withOpacity(0.12));

    // Check mark (crisp + a tiny shadow)
    final check = Path()
      ..moveTo(w * 0.43, top + h * 0.30)
      ..lineTo(w * 0.49, top + h * 0.36)
      ..lineTo(w * 0.60, top + h * 0.24);

    final checkShadow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = h * 0.11
      ..color = Colors.black.withOpacity(0.30);
    canvas.drawPath(check, checkShadow);

    final checkPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = h * 0.08
      ..color = Colors.white;
    canvas.drawPath(check, checkPaint);
  }

  @override
  bool shouldRepaint(covariant _SpikyShieldPainter oldDelegate) => false;
}

class _BadgePill extends StatelessWidget {
  const _BadgePill({
    required this.label,
    required this.bg,
    required this.fg,
    required this.paddingH,
    required this.height,
  });

  final String label;
  final Color bg;
  final Color fg;
  final double paddingH;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: paddingH),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(height * 0.6),
        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: height * 0.46,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

