import 'package:flutter/material.dart';
import '../app/theme/app_colors.dart';

/// Renders the real bank logo or falls back to stylized initials.
class BankLogoAvatar extends StatelessWidget {
  final String bankName;
  final String? shortCode;
  final String? logoAssetPath;
  final double size;

  const BankLogoAvatar({
    super.key,
    required this.bankName,
    this.shortCode,
    this.logoAssetPath,
    this.size = 32,
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
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size * 0.25),
        border: Border.all(
          color: AppColors.border,
          width: 0.9,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.2),
        child: logoAssetPath != null && logoAssetPath!.isNotEmpty
            ? Image.asset(
                logoAssetPath!,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => _buildFallback(),
              )
            : _buildFallback(),
      ),
    );
  }

  Widget _buildFallback() {
    final initials = _deriveInitials();
    return Center(
      child: Text(
        initials,
        style: TextStyle(
          fontSize: size * 0.32,
          fontWeight: FontWeight.w800,
          color: AppColors.primary,
          letterSpacing: 0.1,
        ),
        maxLines: 1,
        overflow: TextOverflow.clip,
      ),
    );
  }
}
