import 'package:flutter/material.dart';
import '../app/theme/app_colors.dart';

/// Represents the status of a mandate with clear semantic styling tokens.
/// Does not rely solely on color; includes explicit labels, dot indicators,
/// icons, and semantic descriptions.
enum MandateStatus {
  active,
  inactive,
  expired,
  cancelled;

  String get label {
    switch (this) {
      case MandateStatus.active:
        return 'ACTIVE';
      case MandateStatus.inactive:
        return 'INACTIVE';
      case MandateStatus.expired:
        return 'EXPIRED';
      case MandateStatus.cancelled:
        return 'CANCELLED';
    }
  }

  String get badgeText => '● $label';

  Color get textColor {
    switch (this) {
      case MandateStatus.active:
        return AppColors.statusActiveText;
      case MandateStatus.inactive:
        return AppColors.statusInactiveText;
      case MandateStatus.expired:
        return AppColors.statusExpiredText;
      case MandateStatus.cancelled:
        return AppColors.statusCancelledText;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case MandateStatus.active:
        return AppColors.statusActiveBg;
      case MandateStatus.inactive:
        return AppColors.statusInactiveBg;
      case MandateStatus.expired:
        return AppColors.statusExpiredBg;
      case MandateStatus.cancelled:
        return AppColors.statusCancelledBg;
    }
  }

  Color get borderColor {
    switch (this) {
      case MandateStatus.active:
        return AppColors.statusActiveBorder;
      case MandateStatus.inactive:
        return AppColors.statusInactiveBorder;
      case MandateStatus.expired:
        return AppColors.statusExpiredBorder;
      case MandateStatus.cancelled:
        return AppColors.statusCancelledBorder;
    }
  }

  Color get dotColor {
    switch (this) {
      case MandateStatus.active:
        return AppColors.statusActiveDot;
      case MandateStatus.inactive:
        return AppColors.statusInactiveDot;
      case MandateStatus.expired:
        return AppColors.statusExpiredDot;
      case MandateStatus.cancelled:
        return AppColors.statusCancelledDot;
    }
  }

  IconData get icon {
    switch (this) {
      case MandateStatus.active:
        return Icons.check_circle_outline_rounded;
      case MandateStatus.inactive:
        return Icons.pause_circle_outline_rounded;
      case MandateStatus.expired:
        return Icons.history_rounded;
      case MandateStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }

  String get detailedDescription {
    switch (this) {
      case MandateStatus.active:
        return 'This mandate is active and will be used for scheduled auto-debit payments.';
      case MandateStatus.inactive:
        return 'This mandate is currently inactive. Automatic deductions are paused.';
      case MandateStatus.expired:
        return 'This mandate has completed its validity period and is no longer valid.';
      case MandateStatus.cancelled:
        return 'This mandate was cancelled and will not be used for future deductions.';
    }
  }

  bool get isActive => this == MandateStatus.active;
}
