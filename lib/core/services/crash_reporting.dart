import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// Installs Crashlytics for fatal Flutter and platform-dispatcher errors.
///
/// Missing Firebase config is non-fatal. [Firebase.initializeApp] without
/// `firebase_options.dart` reads `android/app/google-services.json` and
/// `ios/Runner/GoogleService-Info.plist`. If those are absent, init throws
/// and the local handlers stay in place so the app still launches.
///
/// The manifest and Info.plist default collection to false. This function
/// turns it on only outside debug (`setCrashlyticsCollectionEnabled(!kDebugMode)`),
/// so release builds report crashes once Dreke's config file is in place.
///
/// Do not call [FirebaseCrashlytics.setUserIdentifier], `log`, or
/// `setCustomKey`. Crashlytics stores the plain-text message of an uncaught
/// exception. Existing throw sites do not interpolate seeker questions,
/// readings, transcripts, emails, or account ids. Caught failures only
/// `debugPrint` and are not forwarded.
Future<void> initCrashReporting() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('[Oraculum Error] ${details.exceptionAsString()}');
  };
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint('[Oraculum Async Error] $error');
    return true;
  };

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
  } catch (error) {
    debugPrint(
      '[Crashlytics] Firebase is not configured; crash reporting stays off. $error',
    );
    return;
  }

  final FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
  await crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    crashlytics.recordFlutterFatalError(details);
  };
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    crashlytics.recordError(error, stack, fatal: true);
    return true;
  };
}
