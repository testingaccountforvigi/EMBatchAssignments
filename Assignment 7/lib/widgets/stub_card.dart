import 'package:flutter/material.dart';

import '../app/app_theme.dart';

/// A ticket stub: rounded card, two punched notches, and a dashed tear line
/// between the [top] and [bottom] halves. This is the one bold shape in the
/// app - every other surface stays plain.
class StubCard extends StatelessWidget {
  const StubCard({
    super.key,
    required this.top,
    required this.bottom,
    this.notchColor,
  });

  final Widget top;
  final Widget bottom;
  final Color? notchColor;

  @override
  Widget build(BuildContext context) {
    final Color notch = notchColor ?? AppColors.paperLilac;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(color: AppColors.hairline, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: top,
          ),
          // The notches are filled with the page colour so the perforation
          // reads as punched out of the paper rather than painted on.
          _TearLine(notchColor: notch),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: bottom,
          ),
        ],
      ),
    );
  }
}

class _TearLine extends StatelessWidget {
  const _TearLine({required this.notchColor});

  final Color notchColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22,
      child: Row(
        children: <Widget>[
          _Notch(alignment: Alignment.centerLeft, color: notchColor),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                const double dash = 6;
                const double gap = 5;
                final int count =
                    (constraints.maxWidth / (dash + gap)).floor().clamp(1, 200);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List<Widget>.generate(
                    count,
                    (_) => Container(
                      width: dash,
                      height: 1.4,
                      decoration: BoxDecoration(
                        color: AppColors.hairline,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _Notch(alignment: Alignment.centerRight, color: notchColor),
        ],
      ),
    );
  }
}

class _Notch extends StatelessWidget {
  const _Notch({required this.alignment, required this.color});

  final Alignment alignment;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final bool isLeft = alignment == Alignment.centerLeft;
    return SizedBox(
      width: 12,
      height: 22,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: AppColors.hairline, width: 1.2),
          borderRadius: BorderRadius.horizontal(
            left: isLeft ? Radius.zero : const Radius.circular(12),
            right: isLeft ? const Radius.circular(12) : Radius.zero,
          ),
        ),
      ),
    );
  }
}
