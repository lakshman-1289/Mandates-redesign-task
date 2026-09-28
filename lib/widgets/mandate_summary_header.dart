import 'package:flutter/material.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/app_typography.dart';

/// Clean summary header displayed directly beneath the App Bar.
/// Displays total counts, active vs inactive count badges, and optional filter chips.
class MandateSummaryHeader extends StatelessWidget {
  final int totalCount;
  final int activeCount;
  final int otherCount;
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;

  const MandateSummaryHeader({
    super.key,
    required this.totalCount,
    required this.activeCount,
    required this.otherCount,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (totalCount == 0) return const SizedBox.shrink();

    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Title & Summary text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Text(
                  'Your Mandates',
                  style: AppTypography.screenHeader,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              // Compact summary badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primaryLight,
                    width: 1,
                  ),
                ),
                child: Text(
                  '$activeCount Active${otherCount > 0 ? ' · $otherCount Other' : ''}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),

          // Show filter chips only when multiple categories exist (to prevent clutter)
          if (otherCount > 0) ...[
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(
                    label: 'All ($totalCount)',
                    isSelected: selectedFilter == 'all',
                    onTap: () => onFilterSelected('all'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Active ($activeCount)',
                    isSelected: selectedFilter == 'active',
                    onTap: () => onFilterSelected('active'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Other ($otherCount)',
                    isSelected: selectedFilter == 'other',
                    onTap: () => onFilterSelected('other'),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1.2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
