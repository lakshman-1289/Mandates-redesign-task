import 'package:flutter/material.dart';

/// Design tokens and semantic color definitions for Ezfinanz Mandates.
class AppColors {
  AppColors._();

  // Brand Primaries (Vivid Fintech Sapphire Blue)
  static const Color primary = Color(0xFF0B57D0); // Vivid Financial Sapphire
  static const Color primaryDark = Color(0xFF0842A0);
  static const Color primaryLight = Color(0xFFEBF3FD);
  static const Color primarySurface = Color(0xFFF0F6FE);

  // Accent / Supporting
  static const Color accent = Color(0xFF00B4D8);
  static const Color accentLight = Color(0xFFE0F7FA);

  // Neutral Backgrounds & Surfaces
  static const Color background = Color(0xFFF7F9FC); // Crisp modern off-white
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFFFFFFF);
  static const Color surfaceSubtle = Color(0xFFF1F5F9);

  // Borders & Dividers
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderSubtle = Color(0xFFEDF2F7);
  static const Color divider = Color(0xFFE2E8F0);

  // Typography - High Contrast & Vivid Brightness
  static const Color textPrimary = Color(0xFF0F172A); // Slate 900 - ultra crisp, rich black/navy
  static const Color textSecondary = Color(0xFF334155); // Slate 700 - sharp, vivid, highly readable
  static const Color textTertiary = Color(0xFF64748B); // Slate 500 - clear & bright labels, never dim
  static const Color textDisabled = Color(0xFF94A3B8);

  // Status: ACTIVE (Emerald Green)
  static const Color statusActiveText = Color(0xFF065F46);
  static const Color statusActiveBg = Color(0xFFECFDF5);
  static const Color statusActiveBorder = Color(0xFFA7F3D0);
  static const Color statusActiveDot = Color(0xFF059669);

  // Status: INACTIVE (Neutral Slate)
  static const Color statusInactiveText = Color(0xFF475569);
  static const Color statusInactiveBg = Color(0xFFF1F5F9);
  static const Color statusInactiveBorder = Color(0xFFCBD5E1);
  static const Color statusInactiveDot = Color(0xFF64748B);

  // Status: EXPIRED (Warm Amber / Ochre)
  static const Color statusExpiredText = Color(0xFF92400E);
  static const Color statusExpiredBg = Color(0xFFFFFBEB);
  static const Color statusExpiredBorder = Color(0xFFFDE68A);
  static const Color statusExpiredDot = Color(0xFFD97706);

  // Status: CANCELLED (Restrained Rose / Crimson - never alarming)
  static const Color statusCancelledText = Color(0xFF991B1B);
  static const Color statusCancelledBg = Color(0xFFFEF2F2);
  static const Color statusCancelledBorder = Color(0xFFFECACA);
  static const Color statusCancelledDot = Color(0xFFDC2626);

  // Soft Shadows
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x080F52BA),
      blurRadius: 12,
      offset: Offset(0, 4),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x05000000),
      blurRadius: 4,
      offset: Offset(0, 1),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> cardShadowSubdued = [
    BoxShadow(
      color: Color(0x04000000),
      blurRadius: 6,
      offset: Offset(0, 2),
      spreadRadius: 0,
    ),
  ];
}
