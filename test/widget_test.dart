import 'package:cutbg/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CutBGApp se vykreslí s domovskou obrazovkou', (tester) async {
    await tester.pumpWidget(const CutBGApp());
    expect(find.text('CutBG'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
