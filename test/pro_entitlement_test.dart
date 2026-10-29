import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot_app/features/auth/data/auth_repository.dart';
import 'package:tarot_app/features/auth/domain/user_profile.dart';
import 'package:tarot_app/features/auth/presentation/auth_notifier.dart';
import 'package:tarot_app/features/subscription/presentation/oracle_pro_modal.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await AuthRepository().signOut();
  });

  group('Oracle Pro comes only from a store entitlement', () {
    test('gating reads the profile entitlement', () {
      const guest = AuthState();
      expect(guest.isPro, isFalse);

      const free = AuthState(
        profile: UserProfile(
          id: 'seeker-1',
          email: 'seeker@example.com',
          isPro: false,
        ),
      );
      expect(free.isPro, isFalse);
      expect(
        free.copyWith(profile: free.profile!.copyWith(isPro: true)).isPro,
        isTrue,
      );
    });

    test('a promo redemption does not grant Pro', () async {
      final repo = AuthRepository();

      await expectLater(
        repo.verifyAndActivatePro(
          action: 'redeem_promo',
          receipt: 'reviewer-code-token',
        ),
        throwsA(
          isA<Exception>().having(
            (error) => error.toString(),
            'message',
            contains('Promo codes are not accepted'),
          ),
        ),
      );
      expect((await repo.getCurrentProfile()).isPro, isFalse);

      await expectLater(
        repo.verifyAndActivatePro(action: 'subscribe', plan: 'yearly'),
        throwsA(isA<Exception>()),
      );
      expect((await repo.getCurrentProfile()).isPro, isFalse);
    });

    test('a store receipt does not grant guest Pro', () async {
      final repo = AuthRepository();
      await expectLater(
        repo.verifyAndActivatePro(
          action: 'subscribe',
          plan: 'lifetime',
          receipt: 'play-purchase-token',
          productId: 'oracle_pro_lifetime',
          source: 'google_play',
        ),
        throwsA(
          isA<Exception>().having(
            (error) => error.toString(),
            'message',
            contains('Sign in'),
          ),
        ),
      );
      expect((await repo.getCurrentProfile()).isPro, isFalse);

      const sneakyGuest = AuthState(
        profile: UserProfile(id: 'local_seeker_001', isPro: true),
      );
      expect(sneakyGuest.isGuest, isTrue);
      expect(sneakyGuest.isPro, isFalse);
    });

    test('setProStatus(true) does not grant Pro', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(authProvider.notifier).loadProfile();
      expect(container.read(isProUserProvider), isFalse);

      await container.read(authProvider.notifier).setProStatus(true);

      expect(container.read(authProvider).isPro, isFalse);
      expect(container.read(isProUserProvider), isFalse);
      expect(container.read(authProvider).errorMessage, contains('store purchase'));
    });
  });

  testWidgets('Oracle Pro paywall has no unlock-code field', (tester) async {
    tester.view.physicalSize = const Size(800, 1800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: OracleProModal(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('ORACLE PRO'), findsOneWidget);
    expect(find.text('Restore Previous Purchases'), findsOneWidget);
    expect(find.text('Redeem Celestial Code'), findsNothing);
    expect(find.text('APPLY'), findsNothing);
    expect(find.byType(TextField), findsNothing);
  });
}
