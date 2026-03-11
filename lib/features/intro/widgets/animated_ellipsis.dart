import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hoxton_task/core/design/palette/app_colors.dart';

class AnimatedEllipsis extends StatefulWidget {
  const AnimatedEllipsis({
    super.key,
    this.prefix = 'Typing',
    this.style,
    this.tickDuration = const Duration(milliseconds: 500),
  });

  final String prefix;
  final TextStyle? style;
  final Duration tickDuration;

  @override
  State<AnimatedEllipsis> createState() => _AnimatedEllipsisState();
}

class _AnimatedEllipsisState extends State<AnimatedEllipsis> {
  final ValueNotifier<int> _dotCount = ValueNotifier(0);
  Timer? _timer;

  static const int _dotCountMax = 3;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.tickDuration, (_) {
      _dotCount.value = ((_dotCount.value % _dotCountMax) + 1);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _dotCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = DefaultTextStyle.of(context).style;
    final effectiveStyle = defaultStyle.merge(widget.style);
    final dotColor = effectiveStyle.color ??
        Theme.of(context).textTheme.bodyMedium?.color ??
        AppColors.white;

    return ValueListenableBuilder<int>(
      valueListenable: _dotCount,
      builder: (context, visibleDotCount, _) {
        final spans = <InlineSpan>[
          TextSpan(text: widget.prefix),
          ...List.generate(_dotCountMax, (i) {
            final visible = (i + 1) <= visibleDotCount;
            return TextSpan(
              text: '.',
              style: effectiveStyle.copyWith(
                color: dotColor.withValues(alpha: visible ? 1 : 0),
              ),
            );
          }),
        ];

        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(style: effectiveStyle, children: spans),
        );
      },
    );
  }
}
