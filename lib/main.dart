import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/constants/app_theme.dart';
import 'core/services/admob_service.dart';
import 'core/services/notification_service.dart';
import 'core/supabase/supabase_config.dart';
import 'features/tarot/presentation/screens/tarot_table_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  // Initialize Daily Notification Service
  try {
    final notificationService = NotificationService();
    await notificationService.initialize();
  } catch (e) {
    debugPrint('Notification service setup note: $e');
  }

  // Initialize Google Mobile Ads (AdMob)
  try {
    await AdMobService.instance.initialize();
  } catch (e) {
    debugPrint('AdMob initialization note: $e');
  }

  runApp(
    const ProviderScope(
      child: TarotApp(),
    ),
  );
}

class TarotApp extends StatelessWidget {
  const TarotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Astral Guidance',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const TarotTableScreen(),
    );
  }
}
