import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme/app_colors.dart';

/// Clean summary header with Ezfinanz-inspired segmented filter control
/// and compact mandate count indicators.
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
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(14, 6, 14, 2),
      child: Container(
        padding: const EdgeInsets.all(3.5),
        decoration: BoxDecoration(
          color: const Color(0xFFE9EEF5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: _SegmentTab(
                label: 'All ($totalCount)',
                isSelected: selectedFilter == 'all',
                onTap: () => onFilterSelected('all'),
              ),
            ),
            Expanded(
              child: _SegmentTab(
                label: 'Active ($activeCount)',
                isSelected: selectedFilter == 'active',
                onTap: () => onFilterSelected('active'),
              ),
            ),
            if (otherCount > 0)
              Expanded(
                child: _SegmentTab(
                  label: 'Other ($otherCount)',
                  isSelected: selectedFilter == 'other',
                  onTap: () => onFilterSelected('other'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SegmentTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SegmentTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: Color(0x10000000),
                    blurRadius: 4,
                    offset: Offset(0, 1.5),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.interTight(
              fontSize: 12.5,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
              letterSpacing: -0.1,
            ),
          ),
        ),
      ),
    );
  }
}
