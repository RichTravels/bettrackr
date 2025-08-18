import 'package:flutter/material.dart';

class AnimatedMoney extends StatelessWidget {
  final double value;
  final TextStyle? style;
  final Duration duration;
  final bool signed; // show +/-

  const AnimatedMoney({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 650),
    this.signed = true,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, v, _) {
        final prefix = signed ? (v >= 0 ? '+' : '-') : '';
        final abs = v.abs().toStringAsFixed(2);
        return Text('$prefix\$$abs', style: style);
      },
    );
  }
}
