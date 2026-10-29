import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/app_theme.dart';
import 'core/services/admob_service.dart';
import 'core/services/crash_reporting.dart';
import 'features/notifications/data/notification_settings_store.dart';
import 'features/notifications/data/sanctuary_notification_service.dart';
import 'core/supabase/supabase_config.dart';
import 'features/onboarding/presentation/screens/sacred_initiation_screen.dart';
import 'features/tarot/presentation/screens/tarot_table_screen.dart';
import 'features/tarot/services/tarot_widget_service.dart';
import 'core/services/sensory_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Fatal framework and async errors go to Crashlytics when Firebase is
  // configured. Debug builds and a missing google-services.json do not upload.
  // Release builds enable collection. See FIREBASE_CRASHLYTICS.md.
  await initCrashReporting();

  // Lock preferred orientation to portrait for sacred card table geometry
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Immersive edge-to-edge UI style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize Supabase if remote credentials are provided
  if (SupabaseConfig.isConfigured) {
    try {
      await Supabase.initialize(
        url: SupabaseConfig.url,
        publishableKey: SupabaseConfig.anonKey,
      );
    } catch (e) {
      debugPrint('Supabase initialization note: $e');
    }
  }

  // Refresh the rolling window of sanctuary notifications (daily guidance,
  // lunar peaks, Sabbat eves) for seekers who have opted in.
  try {
    if (await NotificationSettingsStore.isConfigured()) {
      final settings = await NotificationSettingsStore.load();
      await SanctuaryNotificationService.instance.syncSchedule(settings);
    }
  } catch (e) {
    debugPrint('Notification service setup note: $e');
  }

  // Initialize Google Mobile Ads (AdMob)
  try {
    await AdMobService.instance.initialize();
  } catch (e) {
    debugPrint('AdMob initialization note: $e');
  }

  // Initialize and synchronize Android Home Screen Widget (Daily Card & Moon Phase)
  try {
    final widgetService = TarotWidgetService();
    await widgetService.syncFromPreferences();
  } catch (e) {
    debugPrint('Home widget initialization note: $e');
  }

  // Initialize sensory settings (haptics and sound preferences)
  try {
    await SensoryService.init();
  } catch (e) {
    debugPrint('Sensory initialization note: $e');
  }

  // Check if seeker has completed the Sacred Initiation ritual
  bool hasCompletedInitiation = true;
  try {
    final prefs = await SharedPreferences.getInstance();
    hasCompletedInitiation = prefs.getBool('has_completed_initiation') ?? false;
  } catch (e) {
    debugPrint('SharedPreferences read note: $e');
  }

  runApp(
    ProviderScope(
      child: TarotApp(hasCompletedInitiation: hasCompletedInitiation),
    ),
  );
}

class TarotApp extends StatelessWidget {
  final bool hasCompletedInitiation;

  const TarotApp({super.key, this.hasCompletedInitiation = true});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oraculum • Astral Guidance',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: hasCompletedInitiation
          ? const TarotTableScreen()
          : const SacredInitiationScreen(),
    );
  }
}
