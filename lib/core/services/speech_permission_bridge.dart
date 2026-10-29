import 'package:flutter/services.dart';

/// Reads microphone / speech-recognition permission state and opens Settings.
///
/// Status strings are `granted`, `denied`, `permanentlyDenied`, `restricted`,
/// or `undetermined`. Android reports speech recognition as `granted` because
/// that permission is folded into the microphone.
class SpeechPermissionBridge {
  SpeechPermissionBridge({MethodChannel? channel})
      : _channel = channel ?? const MethodChannel('oraculum/speech_permissions');

  final MethodChannel _channel;

  Future<String> microphoneStatus() => _status('microphoneStatus');

  Future<String> speechStatus() => _status('speechStatus');

  Future<bool> openSettings() async {
    try {
      final opened = await _channel.invokeMethod<bool>('openSettings');
      return opened ?? false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  Future<String> _status(String method) async {
    try {
      final status = await _channel.invokeMethod<String>(method);
      return status ?? 'undetermined';
    } on PlatformException {
      return 'undetermined';
    } on MissingPluginException {
      return 'undetermined';
    }
  }
}
