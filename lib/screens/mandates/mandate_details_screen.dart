import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';
import '../../models/mandate.dart';
import '../../utils/currency_formatter.dart';
import '../../utils/date_formatter.dart';
import '../../widgets/bank_logo_avatar.dart';
import '../../widgets/mandate_info_row.dart';
import '../../widgets/mandate_status_badge.dart';

/// Mandate Details Screen displaying the comprehensive mandate parameters
/// while maintaining strict information hierarchy and clarity.
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
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Back to Mandates',
        ),
        title: const Text('Mandate Details'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // 1. HERO STATUS & AMOUNT CARD
            // ==========================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: mandate.isActive ? AppColors.border : AppColors.borderSubtle,
                  width: 1.2,
                ),
                boxShadow: AppColors.cardShadow,
              ),
              child: Column(
                children: [
                  // Status Badge
                  MandateStatusBadge(status: status, isLarge: true),
                  const SizedBox(height: 14),

                  // Mandate Type & Classification
                  Text(
                    mandate.mandateType.displayName,
                    style: AppTypography.screenHeader.copyWith(fontSize: 22),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mandate.mandateType.subcategory,
                    style: AppTypography.bodySmall,
                  ),

                  const SizedBox(height: 18),
                  const Divider(color: AppColors.borderSubtle),
                  const SizedBox(height: 16),

                  // Amount
                  const Text(
                    'Maximum Transaction Limit',
                    style: AppTypography.metaLabel,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    CurrencyFormatter.format(mandate.amount),
                    style: AppTypography.amountLarge.copyWith(
                      color: mandate.isActive
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Status Description Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: status.backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: status.borderColor, width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(status.icon, size: 18, color: status.dotColor),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            status.detailedDescription,
                            style: TextStyle(
                              fontSize: 12,
                              color: status.textColor,
                              fontWeight: FontWeight.w500,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ==========================================
            // 2. MANDATE IDENTIFIERS
            // ==========================================
            const Text(
              'Mandate Information',
              style: AppTypography.sectionTitle,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border, width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
                    value: mandate.mandateType.displayName,
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

            const SizedBox(height: 24),

            // ==========================================
            // 3. BANK & ACCOUNT DETAILS
            // ==========================================
            const Text(
              'Bank & Account Details',
              style: AppTypography.sectionTitle,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border, width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        BankLogoAvatar(
                          bankName: mandate.bankName,
                          shortCode: mandate.bankShortCode,
                          size: 42,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Bank Name', style: AppTypography.metaLabel),
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
                    icon: Icons.account_balance_rounded,
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

            const SizedBox(height: 24),

            // ==========================================
            // 4. TIMELINE & VALIDITY
            // ==========================================
            const Text(
              'Timeline & Validity',
              style: AppTypography.sectionTitle,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border, width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
                      icon: Icons.history_rounded,
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
