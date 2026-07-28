import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamrah_physio/main.dart';

void main() {
  testWidgets('Hamrah Physio App Smoke Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: HamrahPhysioApp(),
      ),
    );
    expect(find.byType(HamrahPhysioApp), findsOneWidget);
  });
}
