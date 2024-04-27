import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mockito/mockito.dart';
import 'package:study_at/pages/map.dart';

class MockMapController extends Mock implements MapController {}

void main() {
  group('MapPage Widget Tests', () {
    late MockMapController mockMapController;

    setUp(() {
      mockMapController = MockMapController();
    });

    testWidgets('MapPage renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MapPage());

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Container), findsNWidgets(2));
    });

    testWidgets('Search function works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MapPage());
      await tester.enterText(find.byType(TextField), 'Place to search');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
      verify(mockMapController.move(LatLng(41.1780, -8.5980), 18)).called(1);
    });
  });
}
