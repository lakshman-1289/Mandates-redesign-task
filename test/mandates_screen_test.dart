import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ezfinanz_mandates/app/app.dart';
import 'package:ezfinanz_mandates/data/mandate_repository.dart';
import 'package:ezfinanz_mandates/models/mandate.dart';
import 'package:ezfinanz_mandates/models/mandate_status.dart';
import 'package:ezfinanz_mandates/models/mandate_type.dart';
import 'package:ezfinanz_mandates/screens/mandates/mandate_details_screen.dart';
import 'package:ezfinanz_mandates/widgets/mandate_card.dart';
import 'package:ezfinanz_mandates/widgets/mandates_empty_state.dart';
import 'package:ezfinanz_mandates/widgets/mandates_error_state.dart';
import 'package:ezfinanz_mandates/widgets/mandates_loading_state.dart';

/// Test repository allowing precise control of returned data, loading and errors
class TestMandateRepository implements MandateRepository {
  List<Mandate> mandates;
  bool shouldThrow;
  String errorMessage;
  Future<List<Mandate>>? customFuture;

  TestMandateRepository({
    this.mandates = const [],
    this.shouldThrow = false,
    this.errorMessage = 'Network connection failed',
    this.customFuture,
  });

  @override
  Future<List<Mandate>> getMandates() async {
    if (customFuture != null) {
      return customFuture!;
    }
    if (shouldThrow) {
      throw Exception(errorMessage);
    }
    return mandates;
  }

  @override
  Future<Mandate?> getMandateById(String id) async {
    try {
      return mandates.firstWhere((m) => m.id == id);
    } catch (_) {
      return null;
    }
  }
}

void main() {
  final sampleActiveMandate = Mandate(
    id: 'test-active-1',
    umrn: 'SBIN702231220003687',
    amount: 100000.0,
    bankName: 'State Bank of India',
    maskedAccountNumber: '•••• 4540',
    registrationDate: DateTime(2022, 11, 22),
    mandateType: MandateType.eMandate,
    status: MandateStatus.active,
    accountHolderName: 'Lakshman Kumar',
  );

  final sampleCancelledMandate = Mandate(
    id: 'test-cancelled-2',
    umrn: 'BARB449102938475610',
    amount: 150000.0,
    bankName: 'Bank of Baroda',
    maskedAccountNumber: '•••• 9845',
    registrationDate: DateTime(2022, 3, 5),
    mandateType: MandateType.eMandate,
    status: MandateStatus.cancelled,
    accountHolderName: 'Lakshman Kumar',
  );

  final sampleExpiredMandate = Mandate(
    id: 'test-expired-3',
    umrn: 'KKBK550192837465910',
    amount: 35000.0,
    bankName: 'Kotak Mahindra Bank',
    maskedAccountNumber: '•••• 6732',
    registrationDate: DateTime(2020, 1, 14),
    mandateType: MandateType.physicalMandate,
    status: MandateStatus.expired,
    accountHolderName: 'Lakshman Kumar',
  );

  group('Mandates Screen & Flow Tests', () {
    testWidgets('1. Empty state is displayed when there are zero mandates',
        (tester) async {
      final repo = TestMandateRepository(mandates: []);

      await tester.pumpWidget(EzfinanzApp(repository: repo));
      await tester.pump(); // Start loading
      await tester.pump(const Duration(milliseconds: 100)); // Finish future

      expect(find.byType(MandatesEmptyState), findsOneWidget);
      expect(find.text('No mandates yet'), findsOneWidget);
      expect(find.text('Set up Auto Pay'), findsOneWidget);
    });

    testWidgets('2. Active mandate displays ACTIVE status', (tester) async {
      final repo = TestMandateRepository(mandates: [sampleActiveMandate]);

      await tester.pumpWidget(EzfinanzApp(repository: repo));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('ACTIVE'), findsOneWidget);
      expect(find.text('SBIN702231220003687'), findsOneWidget);
      expect(find.text('State Bank of India'), findsOneWidget);
      expect(find.text('A/C •••• 4540'), findsOneWidget);
      expect(find.text('₹1,00,000'), findsOneWidget);
    });

    testWidgets('3. Cancelled mandate displays CANCELLED status',
        (tester) async {
      final repo = TestMandateRepository(mandates: [sampleCancelledMandate]);

      await tester.pumpWidget(EzfinanzApp(repository: repo));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('CANCELLED'), findsOneWidget);
      expect(find.text('BARB449102938475610'), findsOneWidget);
      expect(find.text('Bank of Baroda'), findsOneWidget);
    });

    testWidgets('4. Multiple mandates are rendered', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final repo = TestMandateRepository(mandates: [
        sampleActiveMandate,
        sampleCancelledMandate,
        sampleExpiredMandate,
      ]);

      await tester.pumpWidget(EzfinanzApp(repository: repo));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(MandateCard), findsNWidgets(3));
      expect(find.textContaining('All'), findsOneWidget);
      expect(find.text('Active Mandates'), findsOneWidget);
      expect(find.text('Past & Inactive Mandates'), findsOneWidget);
    });

    testWidgets('5. Mandate details screen displays mandate information',
        (tester) async {
      final repo = TestMandateRepository(mandates: [sampleActiveMandate]);

      await tester.pumpWidget(EzfinanzApp(repository: repo));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Tap the mandate card
      await tester.tap(find.byType(MandateCard));
      await tester.pumpAndSettle();

      // Verify Details screen
      expect(find.byType(MandateDetailsScreen), findsOneWidget);
      expect(find.text('Mandate Details'), findsOneWidget);
      expect(find.text('Mandate Information'), findsOneWidget);
      expect(find.text('Bank & Account Details'), findsOneWidget);
      expect(find.text('Timeline & Validity'), findsOneWidget);
      expect(find.text('State Bank of India'), findsOneWidget);
      expect(find.text('•••• 4540'), findsOneWidget);
    });

    testWidgets('6. Error state displays Retry and triggers reload',
        (tester) async {
      final repo = TestMandateRepository(shouldThrow: true);

      await tester.pumpWidget(EzfinanzApp(repository: repo));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(MandatesErrorState), findsOneWidget);
      expect(find.text('Unable to load mandates'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);

      // Now set repository to succeed and tap Retry
      repo.shouldThrow = false;
      repo.mandates = [sampleActiveMandate];

      await tester.tap(find.text('Retry'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(MandateCard), findsOneWidget);
    });

    testWidgets('7. Loading state displays loading skeleton UI', (tester) async {
      final completer = Completer<List<Mandate>>();
      final repo = TestMandateRepository(customFuture: completer.future);

      await tester.pumpWidget(EzfinanzApp(repository: repo));
      await tester.pump(); // Enter loading state without completing

      expect(find.byType(MandatesLoadingState), findsOneWidget);

      // Complete to finish cleanly
      completer.complete([]);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
    });

    testWidgets('8. Filtering between Active and Other mandates works',
        (tester) async {
      final repo = TestMandateRepository(mandates: [
        sampleActiveMandate,
        sampleCancelledMandate,
      ]);

      await tester.pumpWidget(EzfinanzApp(repository: repo));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(MandateCard), findsNWidgets(2));

      // Filter to Active only
      await tester.tap(find.text('Active (1)'));
      await tester.pump();

      expect(find.byType(MandateCard), findsOneWidget);
      expect(find.text('ACTIVE'), findsOneWidget);
      expect(find.text('CANCELLED'), findsNothing);

      // Filter to Other only
      await tester.tap(find.text('Other (1)'));
      await tester.pump();

      expect(find.byType(MandateCard), findsOneWidget);
      expect(find.text('CANCELLED'), findsOneWidget);
      expect(find.text('ACTIVE'), findsNothing);
    });
  });
}
