import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Helper to safely launch external portals, including Whispers & Warnings live readers.
class ExternalLaunchService {
  static const String liveReaderUrl = 'https://www.whispers26.com/';
  static const String privacyPolicyUrl = String.fromEnvironment(
    'PRIVACY_POLICY_URL',
    defaultValue: 'https://raw.githubusercontent.com/Dreke20/TarotApp/main/PRIVACY_POLICY.md',
  );
  static const String termsOfServiceUrl = String.fromEnvironment(
    'TERMS_URL',
    defaultValue: 'https://raw.githubusercontent.com/Dreke20/TarotApp/main/TERMS_OF_SERVICE.md',
  );
  static const String googlePlaySubscriptionsUrl =
      'https://play.google.com/store/account/subscriptions';

  /// Helper to safely launch external URLs.
  static Future<bool> _launch(String urlString, [BuildContext? context]) async {
    final uri = Uri.parse(urlString);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unable to open link. Please visit $urlString in your browser.'),
            backgroundColor: const Color(0xFF1E1A25),
          ),
        );
      }
      return launched;
    } catch (e) {
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error launching link: $e'),
            backgroundColor: const Color(0xFF1E1A25),
          ),
        );
      }
      return false;
    }
  }

  /// Opens the live intuitive reader consultation portal at whispers26.com.
  static Future<bool> openLiveReader([BuildContext? context]) =>
      _launch(liveReaderUrl, context);

  /// Opens the official Privacy Policy.
  static Future<bool> openPrivacyPolicy([BuildContext? context]) =>
      _launch(privacyPolicyUrl, context);

  /// Opens the official Terms of Service.
  static Future<bool> openTermsOfService([BuildContext? context]) =>
      _launch(termsOfServiceUrl, context);

  /// Opens Google Play's native subscription management page.
  static Future<bool> openManageSubscriptions([BuildContext? context]) =>
      _launch(googlePlaySubscriptionsUrl, context);
}
