import 'package:flutter_test/flutter_test.dart';
import 'package:ezfinanz_mandates/app/app.dart';
import 'package:ezfinanz_mandates/data/mock_mandate_repository.dart';
import 'package:ezfinanz_mandates/widgets/mandate_card.dart';

void main() {
  testWidgets('Ezfinanz Mandates smoke test boots cleanly', (WidgetTester tester) async {
    final repository = MockMandateRepository();
    repository.simulatedDelayMs = 0; // Immediate for testing
    repository.setScenario(DemoScenario.oneActive);

    await tester.pumpWidget(EzfinanzApp(repository: repository));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Mandates'), findsOneWidget);
    expect(find.text('Your Mandates'), findsOneWidget);
    expect(find.byType(MandateCard), findsOneWidget);
    expect(find.text('ACTIVE'), findsOneWidget);
    expect(find.text('SBIN702231220003687'), findsOneWidget);
  });
}
