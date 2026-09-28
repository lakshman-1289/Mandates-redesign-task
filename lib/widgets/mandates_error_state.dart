import 'package:flutter/material.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/app_typography.dart';

/// Error state component with retry action.
class MandatesErrorState extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback onRetry;

  const MandatesErrorState({
    super.key,
    this.errorMessage,
    required this.onRetry,
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
            // Error icon container
            Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                color: AppColors.statusCancelledBg,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.cloud_off_rounded,
                    size: 34,
                    color: AppColors.statusCancelledDot,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Unable to load mandates',
              style: AppTypography.screenHeader,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            Text(
              errorMessage ??
                  'We couldn\'t retrieve your mandates right now.\nPlease check your connection and try again.',
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 220),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh_rounded, size: 20),
                  label: const Text('Retry'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
