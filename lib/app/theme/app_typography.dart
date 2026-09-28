import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized typography styles using GoogleFonts "Inter Tight"
/// optimized for high information density and clear visual hierarchy.
class AppTypography {
  AppTypography._();

  // App Bar & Main Titles
  static TextStyle appBarTitle = GoogleFonts.interTight(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  static TextStyle screenHeader = GoogleFonts.interTight(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  static TextStyle sectionTitle = GoogleFonts.interTight(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.1,
  );

  // Financial Amount Hierarchy
  static TextStyle amountLarge = GoogleFonts.interTight(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.4,
  );

  static TextStyle amountCard = GoogleFonts.interTight(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  // Card Content: UMRN & Bank (Compact sizes for fitting more cards)
  static TextStyle umrnLabel = GoogleFonts.interTight(
    fontSize: 10.5,
    fontWeight: FontWeight.w600,
    color: AppColors.textTertiary,
    letterSpacing: 0.3,
  );

  static TextStyle umrnValue = GoogleFonts.interTight(
    fontSize: 12.5,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
  );

  static TextStyle bankName = GoogleFonts.interTight(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.1,
  );

  static TextStyle accountNumber = GoogleFonts.interTight(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    letterSpacing: 0.2,
  );

  // Metadata: Date & Labels
  static TextStyle metaLabel = GoogleFonts.interTight(
    fontSize: 10.5,
    fontWeight: FontWeight.w600,
    color: AppColors.textTertiary,
    letterSpacing: 0.1,
  );

  static TextStyle metaValue = GoogleFonts.interTight(
    fontSize: 12.5,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.1,
  );

  // Status Badge
  static TextStyle statusBadge = GoogleFonts.interTight(
    fontSize: 10.5,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.4,
  );

  // Body & Descriptions
  static TextStyle bodyMedium = GoogleFonts.interTight(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.35,
  );

  static TextStyle bodySmall = GoogleFonts.interTight(
    fontSize: 11.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 1.25,
  );

  static TextStyle buttonText = GoogleFonts.interTight(
    fontSize: 13.5,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );
}
