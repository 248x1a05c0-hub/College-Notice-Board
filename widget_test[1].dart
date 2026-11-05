import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:campus_connect/main.dart';
import 'package:campus_connect/providers/notice_provider.dart';
import 'package:campus_connect/services/storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Campus Connect displays the notice board title', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => NoticeProvider(StorageService())..loadNotices(),
        child: const CampusConnectApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Campus Connect'), findsOneWidget);
    expect(find.text('No notices available'), findsOneWidget);
  });
}
