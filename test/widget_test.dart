import 'package:fazal_portfolio/main.dart';
import 'package:fazal_portfolio/providers/contact_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('portfolio app renders the landing content', (tester) async {
    await tester.pumpWidget(const MyPortfolio());
    await tester.pump();

    expect(find.text('Hello i am ,'), findsOneWidget);
    expect(find.text('Download Resume'), findsOneWidget);
  });

  test('contact provider ignores empty submissions', () async {
    final provider = ContactProvider();
    addTearDown(provider.dispose);

    await provider.sendEmail();

    expect(provider.isSending, isFalse);
    expect(provider.nameController.text, isEmpty);
    expect(provider.emailController.text, isEmpty);
    expect(provider.messageController.text, isEmpty);
  });
}
