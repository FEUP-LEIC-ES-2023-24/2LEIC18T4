import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:study_at/pages/discover_page.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  testWidgets('DiscoverPage - Renders Boavista location', (WidgetTester tester) async {
    // Arrange
    final locationName = 'Boavista';
    final mockClient = MockHttpClient();

    // Mock HTTP client response
    when(mockClient.get(Uri.parse('https://picsum.photos/seed/67/600')))
        .thenAnswer((_) async => http.Response('', 200)); // Add responses for all image URLs

    // Act
    await tester.pumpWidget(MaterialApp(
      home: DiscoverPage(),
    ));

    // Assert - Find location name text
    final locationTextFinder = find.text(locationName);
    expect(tester.widget<Text>(locationTextFinder).data, locationName);
  });
}
