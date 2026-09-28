import 'mandate_status.dart';
import 'mandate_type.dart';

/// Comprehensive domain model for a bank or UPI mandate.
class Mandate {
  final String id;
  final String umrn;
  final double amount;
  final String bankName;
  final String maskedAccountNumber;
  final DateTime registrationDate;
  final MandateType mandateType;
  final MandateStatus status;
  final String accountHolderName;
  final String accountType;
  final String frequency;
  final String purpose;
  final DateTime? expiryDate;
  final DateTime? lastDebitedDate;
  final String? bankShortCode;
  final String? logoAssetPath;

  const Mandate({
    required this.id,
    required this.umrn,
    required this.amount,
    required this.bankName,
    required this.maskedAccountNumber,
    required this.registrationDate,
    required this.mandateType,
    required this.status,
    this.accountHolderName = 'Customer',
    this.accountType = 'Savings Account',
    this.frequency = 'As and when presented',
    this.purpose = 'Ezfinanz NBFC Loan EMI',
    this.expiryDate,
    this.lastDebitedDate,
    this.bankShortCode,
    this.logoAssetPath,
  });

  bool get isActive => status == MandateStatus.active;

  Mandate copyWith({
    String? id,
    String? umrn,
    double? amount,
    String? bankName,
    String? maskedAccountNumber,
    DateTime? registrationDate,
    MandateType? mandateType,
    MandateStatus? status,
    String? accountHolderName,
    String? accountType,
    String? frequency,
    String? purpose,
    DateTime? expiryDate,
    DateTime? lastDebitedDate,
    String? bankShortCode,
  }) {
    return Mandate(
      id: id ?? this.id,
      umrn: umrn ?? this.umrn,
      amount: amount ?? this.amount,
      bankName: bankName ?? this.bankName,
      maskedAccountNumber: maskedAccountNumber ?? this.maskedAccountNumber,
      registrationDate: registrationDate ?? this.registrationDate,
      mandateType: mandateType ?? this.mandateType,
      status: status ?? this.status,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      accountType: accountType ?? this.accountType,
      frequency: frequency ?? this.frequency,
      purpose: purpose ?? this.purpose,
      expiryDate: expiryDate ?? this.expiryDate,
      lastDebitedDate: lastDebitedDate ?? this.lastDebitedDate,
      bankShortCode: bankShortCode ?? this.bankShortCode,
    );
  }
}
