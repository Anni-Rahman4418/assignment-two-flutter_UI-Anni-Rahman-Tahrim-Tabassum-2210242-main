import 'package:flutter_test/flutter_test.dart';
import 'package:student_finance_app/main.dart';

void main() {
  testWidgets('App renders without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const StudentFinanceApp());
    expect(find.text('Anni Rahman Tahrim Tabassum'), findsWidgets);
  });
}
