import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';
import '../../models/mandate.dart';
import '../../utils/currency_formatter.dart';
import '../../utils/date_formatter.dart';
import '../../widgets/bank_logo_avatar.dart';
import '../../widgets/mandate_info_row.dart';
import '../../widgets/mandate_status_badge.dart';

/// Mandate Details Screen inspired by the Ezfinanz Loan Details architecture,
/// featuring a prominent deep-blue Hero card, real bank logos, clear metadata tiles,
/// and quick clipboard copy.
class MandateDetailsScreen extends StatelessWidget {
  final Mandate mandate;

  const MandateDetailsScreen({
    super.key,
    required this.mandate,
  });

  @override
  Widget build(BuildContext context) {
    final status = mandate.status;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Back to Mandates',
        ),
        title: const Text('Mandate Details'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // 1. HERO CARD (Inspired by Ezfinanz Loan Details)
            // ==========================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0F52BA),
                    Color(0xFF0A3B85),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x220F52BA),
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: UMRN & Status Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.credit_card_rounded,
                            size: 16,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            mandate.mandateType.displayName.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      MandateStatusBadge(status: status, isLarge: true),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Amount Label & Prominent Value
                  const Text(
                    'Maximum Transaction Limit',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    CurrencyFormatter.formatWithDecimals(mandate.amount),
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Status Description Banner (Translucent Pill)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(status.icon, size: 15, color: Colors.white),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            status.detailedDescription,
                            style: const TextStyle(
                              fontSize: 11.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              height: 1.25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ==========================================
            // 2. PAYMENT & MANDATE INFORMATION
            // ==========================================
            Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Mandate Information',
                  style: AppTypography.sectionTitle,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 2-Box Summary Row (Inspired by Ezfinanz info grid)
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border, width: 0.9),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.currency_rupee_rounded, size: 13, color: AppColors.primary),
                            const SizedBox(width: 4),
                            Text('Max Limit', style: AppTypography.metaLabel),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          CurrencyFormatter.format(mandate.amount),
                          style: AppTypography.amountCard.copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border, width: 0.9),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined, size: 13, color: AppColors.primary),
                            const SizedBox(width: 4),
                            Text('Registered On', style: AppTypography.metaLabel),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormatter.format(mandate.registrationDate),
                          style: AppTypography.amountCard.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Detailed Specifications Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border, width: 0.9),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Column(
                children: [
                  MandateInfoRow(
                    label: 'UMRN',
                    value: mandate.umrn,
                    icon: Icons.tag_rounded,
                    enableCopy: true,
                    copySuccessMessage: 'UMRN copied: ${mandate.umrn}',
                  ),
                  const Divider(color: AppColors.borderSubtle),
                  MandateInfoRow(
                    label: 'Mandate Type',
                    value: '${mandate.mandateType.displayName} (${mandate.mandateType.subcategory})',
                    icon: mandate.mandateType.icon,
                  ),
                  const Divider(color: AppColors.borderSubtle),
                  MandateInfoRow(
                    label: 'Frequency',
                    value: mandate.frequency,
                    icon: Icons.repeat_rounded,
                  ),
                  const Divider(color: AppColors.borderSubtle),
                  MandateInfoRow(
                    label: 'Purpose',
                    value: mandate.purpose,
                    icon: Icons.description_outlined,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ==========================================
            // 3. BANK & ACCOUNT DETAILS
            // ==========================================
            Row(
              children: [
                const Icon(
                  Icons.account_balance_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Bank & Account Details',
                  style: AppTypography.sectionTitle,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border, width: 0.9),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        BankLogoAvatar(
                          bankName: mandate.bankName,
                          shortCode: mandate.bankShortCode,
                          logoAssetPath: mandate.logoAssetPath,
                          size: 38,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Bank Name', style: AppTypography.metaLabel),
                              const SizedBox(height: 2),
                              Text(mandate.bankName, style: AppTypography.bankName),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: AppColors.borderSubtle),
                  MandateInfoRow(
                    label: 'Account Number',
                    value: mandate.maskedAccountNumber,
                    icon: Icons.credit_card_outlined,
                  ),
                  const Divider(color: AppColors.borderSubtle),
                  MandateInfoRow(
                    label: 'Account Type',
                    value: mandate.accountType,
                    icon: Icons.account_box_outlined,
                  ),
                  const Divider(color: AppColors.borderSubtle),
                  MandateInfoRow(
                    label: 'Account Holder',
                    value: mandate.accountHolderName,
                    icon: Icons.person_outline_rounded,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ==========================================
            // 4. TIMELINE & VALIDITY
            // ==========================================
            Row(
              children: [
                const Icon(
                  Icons.history_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Timeline & Validity',
                  style: AppTypography.sectionTitle,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border, width: 0.9),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Column(
                children: [
                  MandateInfoRow(
                    label: 'Registered On',
                    value: DateFormatter.formatFull(mandate.registrationDate),
                    icon: Icons.calendar_today_rounded,
                  ),
                  if (mandate.expiryDate != null) ...[
                    const Divider(color: AppColors.borderSubtle),
                    MandateInfoRow(
                      label: 'Valid Until',
                      value: DateFormatter.formatFull(mandate.expiryDate!),
                      icon: Icons.event_available_rounded,
                    ),
                  ],
                  if (mandate.lastDebitedDate != null) ...[
                    const Divider(color: AppColors.borderSubtle),
                    MandateInfoRow(
                      label: 'Last Debited',
                      value: DateFormatter.formatFull(mandate.lastDebitedDate!),
                      icon: Icons.payment_rounded,
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
