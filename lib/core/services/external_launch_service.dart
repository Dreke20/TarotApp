import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Helper to safely launch external portals, including Whispers & Warnings live readers.
class ExternalLaunchService {
  static const String liveReaderUrl = 'https://www.whispers26.com/';

  /// Opens the live intuitive reader consultation portal at whispers26.com.
  static Future<bool> openLiveReader([BuildContext? context]) async {
    final uri = Uri.parse(liveReaderUrl);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to open portal. Please visit https://www.whispers26.com/ in your browser.'),
            backgroundColor: Color(0xFF1E1A25),
          ),
        );
      }
      return launched;
    } catch (e) {
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error launching live reader portal: $e'),
            backgroundColor: const Color(0xFF1E1A25),
          ),
        );
      }
      return false;
    }
  }
}
