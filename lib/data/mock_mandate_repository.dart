import 'dart:async';
import '../models/mandate.dart';
import '../models/mandate_status.dart';
import '../models/mandate_type.dart';
import 'mandate_repository.dart';

/// Available demonstration scenarios for reviewing UI/UX states.
enum DemoScenario {
  oneActive('One Active (Reference)', 'Original reference mandate from application screenshot'),
  multipleActive('Multiple Active (3)', '3 currently active mandates across different banks'),
  mixedStatuses('Mixed Statuses (4)', '1 Active, 1 Inactive, 1 Expired, 1 Cancelled'),
  fiveMandates('5 Mandates', 'Realistic collection of 5 varied mandates'),
  tenPlusMandates('10+ Mandates (12)', 'Extensive collection showing vertical scalability'),
  empty('Empty State (0)', 'Zero mandates associated with the user account'),
  loading('Loading State', 'Demonstrates skeleton shimmer loading cards'),
  error('Error State', 'Simulates network failure with functional Retry');

  final String title;
  final String description;

  const DemoScenario(this.title, this.description);
}

/// Mock implementation providing realistic financial data for all scenarios.
class MockMandateRepository implements MandateRepository {
  DemoScenario _currentScenario = DemoScenario.mixedStatuses;
  int simulatedDelayMs = 600;

  DemoScenario get currentScenario => _currentScenario;

  void setScenario(DemoScenario scenario) {
    _currentScenario = scenario;
  }

  // --- Reference Mandate from Existing Application Screenshot ---
  static final Mandate refMandate = Mandate(
    id: 'mandate-sbi-001',
    umrn: 'SBIN702231220003687',
    amount: 100000.0,
    bankName: 'State Bank of India',
    maskedAccountNumber: '•••• 4540',
    registrationDate: DateTime(2022, 11, 22),
    mandateType: MandateType.eMandate,
    status: MandateStatus.active,
    accountHolderName: 'Lakshman Kumar',
    accountType: 'Savings Account',
    frequency: 'As and when presented',
    purpose: 'Ezfinanz Personal Loan EMI',
    bankShortCode: 'SBI',
    expiryDate: DateTime(2032, 11, 21),
    lastDebitedDate: DateTime(2026, 9, 5),
  );

  static final Mandate hdfcActive = Mandate(
    id: 'mandate-hdfc-002',
    umrn: 'HDFC700492100845192',
    amount: 50000.0,
    bankName: 'HDFC Bank',
    maskedAccountNumber: '•••• 8912',
    registrationDate: DateTime(2023, 4, 15),
    mandateType: MandateType.eMandate,
    status: MandateStatus.active,
    accountHolderName: 'Lakshman Kumar',
    accountType: 'Salary Account',
    frequency: 'Monthly',
    purpose: 'Consumer Durable EMI',
    bankShortCode: 'HDFC',
    expiryDate: DateTime(2028, 4, 14),
    lastDebitedDate: DateTime(2026, 9, 10),
  );

  static final Mandate iciciActive = Mandate(
    id: 'mandate-icici-003',
    umrn: 'ICIC991048201948271',
    amount: 25000.0,
    bankName: 'ICICI Bank',
    maskedAccountNumber: '•••• 3091',
    registrationDate: DateTime(2023, 8, 30),
    mandateType: MandateType.upiAutopay,
    status: MandateStatus.active,
    accountHolderName: 'Lakshman Kumar',
    accountType: 'Savings Account',
    frequency: 'Monthly',
    purpose: 'Medical Loan EMI',
    bankShortCode: 'ICICI',
    expiryDate: DateTime(2026, 8, 29),
    lastDebitedDate: DateTime(2026, 9, 1),
  );

  static final Mandate axisInactive = Mandate(
    id: 'mandate-axis-004',
    umrn: 'UTIB882940192840193',
    amount: 75000.0,
    bankName: 'Axis Bank',
    maskedAccountNumber: '•••• 1204',
    registrationDate: DateTime(2021, 6, 10),
    mandateType: MandateType.eMandate,
    status: MandateStatus.inactive,
    accountHolderName: 'Lakshman Kumar',
    accountType: 'Savings Account',
    frequency: 'As and when presented',
    purpose: 'Education Loan Autopay',
    bankShortCode: 'AXIS',
    expiryDate: DateTime(2026, 6, 9),
    lastDebitedDate: DateTime(2024, 3, 15),
  );

  static final Mandate kotakExpired = Mandate(
    id: 'mandate-kotak-005',
    umrn: 'KKBK550192837465910',
    amount: 35000.0,
    bankName: 'Kotak Mahindra Bank',
    maskedAccountNumber: '•••• 6732',
    registrationDate: DateTime(2020, 1, 14),
    mandateType: MandateType.physicalMandate,
    status: MandateStatus.expired,
    accountHolderName: 'Lakshman Kumar',
    accountType: 'Savings Account',
    frequency: 'Monthly',
    purpose: 'Appliance Loan Mandate',
    bankShortCode: 'KOTAK',
    expiryDate: DateTime(2023, 1, 13),
    lastDebitedDate: DateTime(2023, 1, 5),
  );

  static final Mandate bobCancelled = Mandate(
    id: 'mandate-bob-006',
    umrn: 'BARB449102938475610',
    amount: 150000.0,
    bankName: 'Bank of Baroda',
    maskedAccountNumber: '•••• 9845',
    registrationDate: DateTime(2022, 3, 5),
    mandateType: MandateType.eMandate,
    status: MandateStatus.cancelled,
    accountHolderName: 'Lakshman Kumar',
    accountType: 'Current Account',
    frequency: 'As and when presented',
    purpose: 'Business Equipment Loan',
    bankShortCode: 'BOB',
    expiryDate: DateTime(2025, 3, 4),
    lastDebitedDate: DateTime(2023, 11, 20),
  );

  static final Mandate pnbActive = Mandate(
    id: 'mandate-pnb-007',
    umrn: 'PUNB339201948572019',
    amount: 40000.0,
    bankName: 'Punjab National Bank',
    maskedAccountNumber: '•••• 5123',
    registrationDate: DateTime(2024, 2, 18),
    mandateType: MandateType.eMandate,
    status: MandateStatus.active,
    accountHolderName: 'Lakshman Kumar',
    accountType: 'Savings Account',
    frequency: 'Monthly',
    purpose: 'Two Wheeler Loan EMI',
    bankShortCode: 'PNB',
    expiryDate: DateTime(2027, 2, 17),
    lastDebitedDate: DateTime(2026, 9, 18),
  );

  static final Mandate canaraExpired = Mandate(
    id: 'mandate-canara-008',
    umrn: 'CNRB229103948572011',
    amount: 18000.0,
    bankName: 'Canara Bank',
    maskedAccountNumber: '•••• 7741',
    registrationDate: DateTime(2019, 9, 12),
    mandateType: MandateType.physicalMandate,
    status: MandateStatus.expired,
    accountHolderName: 'Lakshman Kumar',
    accountType: 'Savings Account',
    frequency: 'Monthly',
    purpose: 'Consumer Electronic Loan',
    bankShortCode: 'CANARA',
    expiryDate: DateTime(2022, 9, 11),
    lastDebitedDate: DateTime(2022, 8, 12),
  );

  static final Mandate unionCancelled = Mandate(
    id: 'mandate-union-009',
    umrn: 'UBIN110293847561928',
    amount: 60000.0,
    bankName: 'Union Bank of India',
    maskedAccountNumber: '•••• 3399',
    registrationDate: DateTime(2021, 10, 8),
    mandateType: MandateType.eMandate,
    status: MandateStatus.cancelled,
    accountHolderName: 'Lakshman Kumar',
    accountType: 'Savings Account',
    frequency: 'Monthly',
    purpose: 'Home Renovation EMI',
    bankShortCode: 'UNION',
    expiryDate: DateTime(2024, 10, 7),
    lastDebitedDate: DateTime(2023, 6, 8),
  );

  static final Mandate idfcActive = Mandate(
    id: 'mandate-idfc-010',
    umrn: 'IDFB990192837465019',
    amount: 85000.0,
    bankName: 'IDFC FIRST Bank',
    maskedAccountNumber: '•••• 2200',
    registrationDate: DateTime(2024, 5, 20),
    mandateType: MandateType.eMandate,
    status: MandateStatus.active,
    accountHolderName: 'Lakshman Kumar',
    accountType: 'Savings Account',
    frequency: 'As and when presented',
    purpose: 'Commercial Equipment EMI',
    bankShortCode: 'IDFC',
    expiryDate: DateTime(2029, 5, 19),
    lastDebitedDate: DateTime(2026, 9, 20),
  );

  static final Mandate yesbankInactive = Mandate(
    id: 'mandate-yes-011',
    umrn: 'YESB881920394857201',
    amount: 30000.0,
    bankName: 'Yes Bank',
    maskedAccountNumber: '•••• 6611',
    registrationDate: DateTime(2023, 1, 10),
    mandateType: MandateType.upiAutopay,
    status: MandateStatus.inactive,
    accountHolderName: 'Lakshman Kumar',
    accountType: 'Savings Account',
    frequency: 'Monthly',
    purpose: 'Fitness Equipment EMI',
    bankShortCode: 'YES',
    expiryDate: DateTime(2025, 1, 9),
    lastDebitedDate: DateTime(2024, 8, 10),
  );

  static final Mandate indusindActive = Mandate(
    id: 'mandate-indus-012',
    umrn: 'INDB771029384756201',
    amount: 120000.0,
    bankName: 'IndusInd Bank',
    maskedAccountNumber: '•••• 8833',
    registrationDate: DateTime(2024, 7, 1),
    mandateType: MandateType.eMandate,
    status: MandateStatus.active,
    accountHolderName: 'Lakshman Kumar',
    accountType: 'Savings Account',
    frequency: 'As and when presented',
    purpose: 'SME Working Capital Loan',
    bankShortCode: 'INDUS',
    expiryDate: DateTime(2030, 6, 30),
    lastDebitedDate: DateTime(2026, 9, 1),
  );

  @override
  Future<List<Mandate>> getMandates() async {
    // Simulate real network delay for polished UX feel
    await Future.delayed(Duration(milliseconds: simulatedDelayMs));

    switch (_currentScenario) {
      case DemoScenario.empty:
        return [];

      case DemoScenario.oneActive:
        return [refMandate];

      case DemoScenario.multipleActive:
        return [refMandate, hdfcActive, iciciActive];

      case DemoScenario.mixedStatuses:
        return [refMandate, axisInactive, kotakExpired, bobCancelled];

      case DemoScenario.fiveMandates:
        return [
          refMandate,
          hdfcActive,
          axisInactive,
          kotakExpired,
          bobCancelled,
        ];

      case DemoScenario.tenPlusMandates:
        return [
          refMandate,
          hdfcActive,
          iciciActive,
          idfcActive,
          pnbActive,
          indusindActive,
          axisInactive,
          yesbankInactive,
          kotakExpired,
          canaraExpired,
          bobCancelled,
          unionCancelled,
        ];

      case DemoScenario.loading:
        // Delay long enough to observe loading state in UI tests/review
        await Completer<void>().future; // Will never complete unless cancelled
        return [];

      case DemoScenario.error:
        throw Exception(
          'Network connection error: Unable to connect to Ezfinanz mandate service. (HTTP 503)',
        );
    }
  }

  @override
  Future<Mandate?> getMandateById(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final all = [
      refMandate,
      hdfcActive,
      iciciActive,
      axisInactive,
      kotakExpired,
      bobCancelled,
      pnbActive,
      canaraExpired,
      unionCancelled,
      idfcActive,
      yesbankInactive,
      indusindActive,
    ];
    try {
      return all.firstWhere((m) => m.id == id);
    } catch (_) {
      return null;
    }
  }
}
