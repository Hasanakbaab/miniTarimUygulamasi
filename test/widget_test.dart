import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_proje_uygulamasi/main.dart';

void main() {
  testWidgets('Register and Login buttons should be present',
      (WidgetTester tester) async {
    // Uygulamayı başlat
    await tester.pumpWidget(const MyApp());

    // "Register" ve "Login" butonlarını bulmalı
    expect(find.text('Register'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Tap Register button and check UI response',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Kullanıcı giriş bilgilerini gir
    await tester.enterText(
        find.byType(TextField).first, 'testuser@example.com'); // Email
    await tester.enterText(find.byType(TextField).last, 'password123'); // Şifre

    // Register butonuna bas
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle(); // UI güncellenmesini bekle

    // Hata mesajı olup olmadığını kontrol et
    expect(find.textContaining('Error:'), findsNothing);
  });

  testWidgets('Tap Login button and check UI response',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Kullanıcı giriş bilgilerini gir
    await tester.enterText(
        find.byType(TextField).first, 'testuser@example.com'); // Email
    await tester.enterText(find.byType(TextField).last, 'password123'); // Şifre

    // Login butonuna bas
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle(); // UI güncellenmesini bekle

    // Hata mesajı olup olmadığını kontrol et
    expect(find.textContaining('Error:'), findsNothing);
  });
}
