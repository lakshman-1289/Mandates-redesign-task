import 'package:flutter/material.dart';
import '../app/theme/app_colors.dart';

/// Renders a polished bank avatar with consistent fintech aesthetics.
class BankLogoAvatar extends StatelessWidget {
  final String bankName;
  final String? shortCode;
  final double size;

  const BankLogoAvatar({
    super.key,
    required this.bankName,
    this.shortCode,
    this.size = 38,
  });

  String _deriveInitials() {
    if (shortCode != null && shortCode!.isNotEmpty) {
      return shortCode!.toUpperCase();
    }
    final words = bankName.split(' ');
    if (words.length == 1) {
      return words[0].substring(0, words[0].length >= 3 ? 3 : words[0].length).toUpperCase();
    }
    return words.take(3).map((w) => w.isNotEmpty ? w[0] : '').join().toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final initials = _deriveInitials();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(size * 0.28),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontSize: size * 0.32,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
            letterSpacing: 0.2,
          ),
          maxLines: 1,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }
}
