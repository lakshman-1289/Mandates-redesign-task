import 'package:flutter/material.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/app_typography.dart';
import '../models/mandate.dart';
import '../utils/currency_formatter.dart';
import '../utils/date_formatter.dart';
import 'bank_logo_avatar.dart';
import 'mandate_status_badge.dart';

/// Reusable Mandate Card component.
/// Strictly implements the required information hierarchy:
/// 1. Top: UMRN & Status badge
/// 2. Middle: Bank name & Masked account number
/// 3. Bottom: Mandate Amount & Registration Date
class MandateCard extends StatelessWidget {
  final Mandate mandate;
  final VoidCallback onTap;

  const MandateCard({
    super.key,
    required this.mandate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = mandate.isActive;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.surface : const Color(0xFFFCFDFE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? AppColors.border : AppColors.borderSubtle,
          width: 1.2,
        ),
        boxShadow: isActive ? AppColors.cardShadow : AppColors.cardShadowSubdued,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ==========================================
                // 1. TOP ROW: UMRN & Status Badge
                // ==========================================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Subtle mandate type + UMRN identifier
                          Text(
                            '${mandate.mandateType.displayName.toUpperCase()} · UMRN',
                            style: AppTypography.umrnLabel,
                          ),
                          const SizedBox(height: 3),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              mandate.umrn,
                              style: AppTypography.umrnValue.copyWith(
                                color: isActive
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Current Status (always in top-right for instant scanning)
                    MandateStatusBadge(status: mandate.status),
                  ],
                ),

                const SizedBox(height: 14),

                // ==========================================
                // 2. MIDDLE SECTION: Bank Name & Masked Account
                // ==========================================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BankLogoAvatar(
                      bankName: mandate.bankName,
                      shortCode: mandate.bankShortCode,
                      size: 38,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mandate.bankName,
                            style: AppTypography.bankName.copyWith(
                              color: isActive
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'A/C ${mandate.maskedAccountNumber}',
                            style: AppTypography.accountNumber,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Subtle dividing line separating secondary info from primary financial amount
                const Divider(height: 1, color: AppColors.borderSubtle),

                const SizedBox(height: 12),

                // ==========================================
                // 3. BOTTOM SECTION: Amount & Registration Date
                // ==========================================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Mandate Amount (High Visual Hierarchy)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Max Limit',
                            style: AppTypography.metaLabel,
                          ),
                          const SizedBox(height: 2),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              CurrencyFormatter.format(mandate.amount),
                              style: AppTypography.amountCard.copyWith(
                                color: isActive
                                    ? AppColors.primaryDark
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Registration Date (Visually secondary)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Registered',
                          style: AppTypography.metaLabel,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          DateFormatter.format(mandate.registrationDate),
                          style: AppTypography.metaValue.copyWith(
                            color: isActive
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
