import 'package:flutter/material.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/app_typography.dart';

/// Polished empty state shown when zero mandates exist.
class MandatesEmptyState extends StatelessWidget {
  final VoidCallback onSetupAutopay;

  const MandatesEmptyState({
    super.key,
    required this.onSetupAutopay,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Custom modern fintech illustration
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryLight,
                  width: 2,
                ),
              ),
              child: Center(
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: AppColors.cardShadow,
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 38,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            Text(
              'No mandates yet',
              style: AppTypography.screenHeader,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            Text(
              'You don\'t have any active or past mandates\nassociated with your account.',
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Intentional CTA for Auto Pay setup
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 260),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onSetupAutopay,
                  icon: const Icon(Icons.add_rounded, size: 20),
                  label: const Text('Set up Auto Pay'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
