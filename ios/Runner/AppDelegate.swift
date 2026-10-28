import AVFoundation
import Flutter
import Speech
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    let channel = FlutterMethodChannel(
      name: "oraculum/speech_permissions",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )
    channel.setMethodCallHandler { call, result in
      switch call.method {
      case "microphoneStatus":
        result(Self.microphoneStatus())
      case "speechStatus":
        result(Self.speechStatus())
      case "openSettings":
        result(Self.openSettings())
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }

  private static func microphoneStatus() -> String {
    switch AVAudioSession.sharedInstance().recordPermission {
    case .granted:
      return "granted"
    case .denied:
      return "permanentlyDenied"
    case .undetermined:
      return "undetermined"
    @unknown default:
      return "undetermined"
    }
  }

  private static func speechStatus() -> String {
    switch SFSpeechRecognizer.authorizationStatus() {
    case .authorized:
      return "granted"
    case .denied, .restricted:
      return "permanentlyDenied"
    case .notDetermined:
      return "undetermined"
    @unknown default:
      return "undetermined"
    }
  }

  private static func openSettings() -> Bool {
    guard let url = URL(string: UIApplication.openSettingsURLString) else {
      return false
    }
    DispatchQueue.main.async {
      UIApplication.shared.open(url)
    }
    return true
  }
}
