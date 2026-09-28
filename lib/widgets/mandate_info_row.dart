import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/app_typography.dart';

/// Reusable detailed information row with optional copy action.
class MandateInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final bool enableCopy;
  final String? copySuccessMessage;
  final Widget? trailing;

  const MandateInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.enableCopy = false,
    this.copySuccessMessage,
    this.trailing,
  });

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(copySuccessMessage ?? '$label copied to clipboard'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 18, color: AppColors.primary),
            ),
            const SizedBox(width: 14),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTypography.metaLabel),
                const SizedBox(height: 3),
                Text(value, style: AppTypography.bankName),
              ],
            ),
          ),
          if (enableCopy)
            IconButton(
              icon: const Icon(Icons.copy_rounded, size: 18, color: AppColors.primary),
              tooltip: 'Copy $label',
              onPressed: () => _copyToClipboard(context),
            )
          else
            ?trailing,
        ],
      ),
    );
  }
}
