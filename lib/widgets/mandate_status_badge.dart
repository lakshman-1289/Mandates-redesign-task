import 'package:flutter/material.dart';
import '../app/theme/app_typography.dart';
import '../models/mandate_status.dart';

/// Reusable status badge chip for mandate states.
/// Communicates status clearly through explicit text, colored dot,
/// background tint, and border.
class MandateStatusBadge extends StatelessWidget {
  final MandateStatus status;
  final bool isLarge;

  const MandateStatusBadge({
    super.key,
    required this.status,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final dotSize = isLarge ? 8.0 : 6.5;
    final horizontalPadding = isLarge ? 12.0 : 9.0;
    final verticalPadding = isLarge ? 6.0 : 4.0;
    final fontSize = isLarge ? 12.0 : 11.0;

    return Semantics(
      label: 'Status: ${status.label}',
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: status.backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: status.borderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: status.dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5.5),
            Text(
              status.label,
              style: AppTypography.statusBadge.copyWith(
                color: status.textColor,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
