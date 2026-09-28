import 'package:flutter/material.dart';

/// Represents the classification type of the mandate.
enum MandateType {
  eMandate,
  physicalMandate,
  upiAutopay;

  String get displayName {
    switch (this) {
      case MandateType.eMandate:
        return 'E-Mandate';
      case MandateType.physicalMandate:
        return 'Physical Mandate';
      case MandateType.upiAutopay:
        return 'UPI Autopay';
    }
  }

  String get subcategory {
    switch (this) {
      case MandateType.eMandate:
        return 'eNACH Paperless';
      case MandateType.physicalMandate:
        return 'Signed NACH Form';
      case MandateType.upiAutopay:
        return 'NPCI Recurring UPI';
    }
  }

  IconData get icon {
    switch (this) {
      case MandateType.eMandate:
        return Icons.credit_card_rounded;
      case MandateType.physicalMandate:
        return Icons.description_outlined;
      case MandateType.upiAutopay:
        return Icons.account_balance_wallet_outlined;
    }
  }
}
