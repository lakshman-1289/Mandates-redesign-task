import 'package:flutter/material.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/app_typography.dart';
import '../models/mandate.dart';
import '../utils/currency_formatter.dart';
import '../utils/date_formatter.dart';
import 'bank_logo_avatar.dart';
import 'mandate_status_badge.dart';

/// Reusable Mandate Card component.
/// Optimized for high information density to fit more cards on screen,
/// with prominent amount sizing, compact secondary details, real bank logos,
/// and clear visual hierarchy.
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
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4.5),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : const Color(0xFFE8EDF4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isActive ? AppColors.border : const Color(0xFFD2D9E3),
          width: 1.0,
        ),
        boxShadow: isActive
            ? const [
                BoxShadow(
                  color: Color(0x06000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ]
            : const [
                BoxShadow(
                  color: Color(0x04000000),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 11, 14, 11),
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
                          Row(
                            children: [
                              Icon(
                                mandate.mandateType.icon,
                                size: 12,
                                color: AppColors.textTertiary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${mandate.mandateType.displayName.toUpperCase()} · UMRN',
                                style: AppTypography.umrnLabel,
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              mandate.umrn,
                              style: AppTypography.umrnValue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Status Badge (top-right for immediate scanning)
                    MandateStatusBadge(status: mandate.status),
                  ],
                ),

                const SizedBox(height: 9),

                // ==========================================
                // 2. MIDDLE SECTION: Real Bank Logo & Account
                // ==========================================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BankLogoAvatar(
                      bankName: mandate.bankName,
                      shortCode: mandate.bankShortCode,
                      logoAssetPath: mandate.logoAssetPath,
                      size: 32,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mandate.bankName,
                            style: AppTypography.bankName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 1),
                          Row(
                            children: [
                              const Icon(
                                Icons.account_balance_outlined,
                                size: 11,
                                color: AppColors.textTertiary,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                'A/C ${mandate.maskedAccountNumber}',
                                style: AppTypography.accountNumber,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                      color: AppColors.textTertiary,
                    ),
                  ],
                ),

                const SizedBox(height: 9),

                // Subtle separating line
                Divider(
                  height: 1,
                  color: isActive ? AppColors.borderSubtle : const Color(0xFFD6DDE7),
                ),

                const SizedBox(height: 8),

                // ==========================================
                // 3. BOTTOM SECTION: Amount & Registration Date
                // ==========================================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Mandate Amount (High visual weight)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Max Limit',
                            style: AppTypography.metaLabel,
                          ),
                          const SizedBox(height: 1),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              CurrencyFormatter.format(mandate.amount),
                              style: AppTypography.amountCard.copyWith(
                                color: isActive
                                    ? AppColors.primary
                                    : const Color(0xFF334155),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Registration Date
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Registered',
                          style: AppTypography.metaLabel,
                        ),
                        const SizedBox(height: 1),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              size: 11,
                              color: AppColors.textTertiary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              DateFormatter.format(mandate.registrationDate),
                              style: AppTypography.metaValue,
                            ),
                          ],
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
