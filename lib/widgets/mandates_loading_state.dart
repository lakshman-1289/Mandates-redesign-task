import 'package:flutter/material.dart';
import '../app/theme/app_colors.dart';
import 'shimmer_box.dart';

/// Loading state skeleton widget.
/// Accurately matches the layout and geometry of the final MandateCard
/// for seamless visual transition without layout jumps.
class MandatesLoadingState extends StatelessWidget {
  const MandatesLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border, width: 1.2),
            boxShadow: AppColors.cardShadow,
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: UMRN + Status Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBox(width: 80, height: 11, borderRadius: 4),
                      SizedBox(height: 6),
                      ShimmerBox(width: 150, height: 15, borderRadius: 4),
                    ],
                  ),
                  ShimmerBox(width: 72, height: 24, borderRadius: 12),
                ],
              ),
              SizedBox(height: 16),

              // Middle Section: Bank + Account
              Row(
                children: [
                  ShimmerBox(width: 38, height: 38, borderRadius: 10),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBox(width: 140, height: 16, borderRadius: 4),
                      SizedBox(height: 6),
                      ShimmerBox(width: 90, height: 12, borderRadius: 4),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),

              Divider(height: 1, color: AppColors.borderSubtle),
              SizedBox(height: 14),

              // Bottom Section: Amount + Registration Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBox(width: 50, height: 11, borderRadius: 4),
                      SizedBox(height: 6),
                      ShimmerBox(width: 110, height: 22, borderRadius: 4),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ShimmerBox(width: 60, height: 11, borderRadius: 4),
                      SizedBox(height: 6),
                      ShimmerBox(width: 80, height: 14, borderRadius: 4),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
