import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../lib/pages/login.dart';
import '../../lib/pages/inicio.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

  void main() {
    TestWidgetsFlutterBinding.ensureInitialized();

    group('Login form', () {
      late MockNavigatorObserver mockObserver;

      setUp(() {
        mockObserver = MockNavigatorObserver();
      });

      Future<void> pumpLoginScreen(WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          home: Login(),
          navigatorObservers: [mockObserver],
        ));
        await tester.pumpAndSettle();
      }

      testWidgets('deve mostrar mensagem de erro se username está vazio',
          (WidgetTester tester) async {
        await pumpLoginScreen(tester);
        await tester.enterText(find.byType(TextFormField).at(1), 'password123');
        await tester.tap(find.text('Login'));
        await tester.pump();
        expect(find.text('Por favor, insira um nome de usuário.'), findsOneWidget);
      });
    });
  }

