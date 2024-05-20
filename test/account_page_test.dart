import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_database/firebase_database.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:study_at/pages/account_page.dart";

import "account_page_test.mocks.dart";

// Define MockUser class that extends User
class MockUser extends Mock implements User {}

@GenerateNiceMocks([
  MockSpec<FirebaseAuth>(),
  MockSpec<DatabaseReference>(),
  MockSpec<Stream<DatabaseEvent>>(),
  MockSpec<FirebaseDatabase>(),
  MockSpec<DataSnapshot>()
])
void main() {
  setUpAll(() async {
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: 'AIzaSyBIdFDn75aSB6zm6LiRKxZ0k9ZCyr8j5ho',
      appId: '1:206182314858:android:a9e8effc89c2801675ab13',
      databaseURL:
          'https://studyatapp-default-rtdb.europe-west1.firebasedatabase.app',
      messagingSenderId: '206182314858',
      projectId: 'studyatapp',
      storageBucket: 'studyatapp.appspot.com',
    ));
  });

  group('AccountPage Widget Tests', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late MockFirebaseDatabase mockFirebaseDatabase;
    late MockStream mockStream;
    late MockDatabaseReference mockDatabaseReference;
    late MockDataSnapshot mockDataSnapshot;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockFirebaseDatabase = MockFirebaseDatabase();
      mockStream = MockStream();
      mockDatabaseReference = MockDatabaseReference();
      mockDataSnapshot = MockDataSnapshot();

      when(mockDatabaseReference.child(any)).thenReturn(mockDatabaseReference);
      when(mockFirebaseDatabase.ref()).thenReturn(mockDatabaseReference);
      when(mockDatabaseReference.onValue)
          .thenAnswer((realInvocation) => mockStream);
    });

    testWidgets('AccountPage renders correctly', (WidgetTester tester) async {
      final mockUser = MockUser();
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

      when(mockDatabaseReference.get())
          .thenAnswer((realInvocation) => Future.value(mockDataSnapshot));
      when(mockDataSnapshot.value).thenReturn({
        'bio': 'Biografia do user de teste.',
        'faculty': {'color': 2634012160, 'name': 'FMUP'},
        'name': 'teste',
        'profileImage': 'https://picsum.photos/seed/283/600',
        'stars': [174],
        'username': 'teste'
      });

      await tester.pumpWidget(
        MaterialApp(
          home: AccountPage(),
        ),
      );

      expect(find.text('Account'), findsOneWidget);
      expect(find.text('Edit Profile'), findsOneWidget);

      verify(mockDatabaseReference.child('users/teste_gmail_com')).called(1);
      verify(mockDatabaseReference.get()).called(1);
    });
  });
}
