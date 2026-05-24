import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_bloc/injection_container.dart' as di;
import 'package:flutter_clean_bloc/main.dart';

void main() {
  testWidgets('app builds and shows posts screen', (WidgetTester tester) async {
    di.init();
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('Posts'), findsOneWidget);
  });
}
