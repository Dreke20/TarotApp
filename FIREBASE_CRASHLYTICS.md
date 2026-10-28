# Firebase Crashlytics (Spark)

Oraculum reports fatal crashes to **Firebase Crashlytics** only. Do not add Firebase Analytics or any other Firebase product. Crashlytics on the free **Spark** plan does not require them. When the Firebase console asks to enable Google Analytics, leave it **off**. Breadcrumbs are the only Crashlytics feature that needs Analytics, and this app does not use them.

Packages: `firebase_core` ^5.1.0 and `firebase_crashlytics` ^6.0.1. Android Gradle plugins, applied only when `android/app/google-services.json` exists **and** its `package_name` matches the app id:

- `com.google.gms.google-services` 4.5.0
- `com.google.firebase.crashlytics` 3.0.8

`firebase_crashlytics` 6.0.1 does not depend on `firebase_analytics`. The Android Crashlytics SDK (BOM 35.1.0 / `firebase-crashlytics` 21.0.1) depends on `firebase-installations` and `firebase-sessions`, plus the `firebase-measurement-connector` stub. That stub is not the Analytics SDK (it depends only on `play-services-basement` and `firebase-annotations`) and does not collect Analytics events, so there is nothing to disable. If a later change adds `firebase_analytics`, stop and set `firebase_analytics_collection_deactivated` / `FIREBASE_ANALYTICS_COLLECTION_DEACTIVATED` before shipping.

## Where Dreke's file goes

Dreke is creating the Firebase project. Put the downloaded Android config here, and nowhere else:

`android/app/google-services.json`

That is the directory that already contains `build.gradle.kts`, not `android/app/src/`. The Google Services and Crashlytics Gradle plugins turn on only when that file exists and contains `"package_name": "oraculum.dirtysouth"`. Until then, debug and release builds still succeed and Crashlytics stays dormant.

**Package id mismatch:** Play's `applicationId` in `android/app/build.gradle.kts` is `oraculum.dirtysouth`. The id mentioned for the new Firebase Android app, `com.tarotapp.tarot_app`, does not match. A json registered as `com.tarotapp.tarot_app` will not activate the plugins (the build keeps working and logs a warning). Register the Android app as `oraculum.dirtysouth`, or change `applicationId` to match the Firebase app before dropping the file in. iOS is separate: `PRODUCT_BUNDLE_IDENTIFIER` is `com.tarotapp.tarotApp`. Put `GoogleService-Info.plist` in `ios/Runner/` and add it to the Runner target.

Once the matching json is in place, **release and profile builds upload crashes**. Debug builds do not (`setCrashlyticsCollectionEnabled(!kDebugMode)`), and the manifest / Info.plist keep native collection off until Dart enables it.

`initCrashReporting()` in `lib/core/services/crash_reporting.dart` (called from `main`):

1. Install local `FlutterError.onError` and `PlatformDispatcher.instance.onError` handlers.
2. `Firebase.initializeApp()` with no Dart options. There is no `lib/firebase_options.dart` yet; do not invent one. Android and iOS read the native config files.
3. If init throws, print a local note and return. The app keeps running.
4. On success, `FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode)`.
5. Replace the handlers with `recordFlutterFatalError` and `recordError(..., fatal: true)`.

The app never calls `setUserIdentifier`, `log`, or `setCustomKey`.

### PII check

Crashlytics stores the plain-text exception message of an uncaught error ([examples of information collected by Crashlytics](https://firebase.google.com/support/privacy)). Current throw sites do not interpolate seeker questions, readings, transcripts, emails, or account ids. Caught failures only `debugPrint`. Do not put user content into a new `throw`. Account deletion does not delete Crashlytics reports, because they are not keyed to a Supabase user id.

## Setup steps

1. In the [Firebase console](https://console.firebase.google.com/), use the Spark plan. Leave Google Analytics **disabled**.
2. Add an Android app whose package name is **`oraculum.dirtysouth`** (the Gradle `applicationId`). Download `google-services.json` into **`android/app/google-services.json`**.
3. Add an iOS app with bundle id `com.tarotapp.tarotApp`. Download `GoogleService-Info.plist` into `ios/Runner/` and add it to the Runner target.
4. From the repo root:

   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```

   Commit `lib/firebase_options.dart`, the json, the plist, and `ios/firebase_app_id_file.json`. The running app does not import `firebase_options.dart` yet; native files are enough for Android and iOS init. The generated Dart file and `firebase_app_id_file.json` are for symbol upload and a later `DefaultFirebaseOptions` switch.
5. Open **Crashlytics** in the console and enable it for both apps. Do not enable another Firebase product.
6. Restrict the client API key in Google Cloud Console: Android package `oraculum.dirtysouth` plus your SHA-1 certificates, iOS bundle id `com.tarotapp.tarotApp`, and only the Firebase APIs you use. The key ships in the binary; it is not a server secret, but an unrestricted key can burn quota.
7. Confirm a report with a **profile or release** run (`flutter run --profile` or `--release`). A debug crash will not appear. A temporary `throw StateError('Crashlytics test');` on a non-store build is enough; remove it afterward. The first report can take a few minutes ([Flutter get started](https://firebase.google.com/docs/crashlytics/flutter/get-started)).

Do not commit placeholder API keys.

### Commit the client config

`google-services.json`, `GoogleService-Info.plist`, `lib/firebase_options.dart`, and `ios/firebase_app_id_file.json` are not secret. This repo gitignores `.env`, keystores, and `key.properties`, and commits client identifiers (the AdMob app id in the manifest). **Commit** the Firebase client files. `.gitignore` says they are not ignored.

### iOS platform and dSYM upload

`ios/Podfile` sets `platform :ios, '15.0'`. `ios/Flutter/Debug.xcconfig` and `Release.xcconfig` optionally include the Pods xcconfigs.

On a Mac, `pod install` runs `crashlytics_add_upload_symbols`. If `ios/firebase_app_id_file.json` is missing, that script exits without editing the Xcode project. After `flutterfire configure`, run `pod install` in `ios/` and confirm the Runner target has a Run Script phase named `[firebase_crashlytics] Crashlytics Upload Symbols`. It calls `"$PODS_ROOT/FirebaseCrashlytics/upload-symbols"` with `--flutter-project "$PROJECT_DIR/firebase_app_id_file.json"` and skips Debug and the simulator. Input files:

- `${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}`
- `${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/`
- `${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Info.plist`
- `$(TARGET_BUILD_DIR)/$(EXECUTABLE_PATH)`
- `$(PROJECT_DIR)/firebase_app_id_file.json`

If the phase is missing, add that Run Script on Runner. For an obfuscated Android build, upload Dart symbols with `firebase crashlytics:symbols:upload --app=FIREBASE_APP_ID PATH/TO/symbols` (`mobilesdk_app_id` in the json). Release mapping-file upload is handled by the Crashlytics Gradle plugin once the json is applied.

## Likely overlaps

Voice input, `CELESTIAL_PRO` removal, and paywall/billing work may also touch `pubspec.yaml`, `pubspec.lock`, `android/settings.gradle.kts`, `android/app/build.gradle.kts`, `AndroidManifest.xml`, and `lib/main.dart`. This change does not edit billing, promo codes, or voice.

## Google Play Data safety (this Crashlytics setup)

Answer these for Crashlytics only. AdMob's advertising ID stays a separate **Device or other IDs** row that **is** shared. Sources:

- [Prepare for Google Play's data disclosure requirements](https://firebase.google.com/docs/android/play-data-disclosure) (Crashlytics, Installations, and Firebase sessions; page updated 2026-10-21)
- [Firebase privacy and security](https://firebase.google.com/support/privacy) (Crashlytics row, stored-field examples, encryption, 90-day retention)
- [Get started with Crashlytics for Flutter](https://firebase.google.com/docs/crashlytics/flutter/get-started) (Analytics is optional and only for breadcrumbs)
- [Play Console data safety help](https://support.google.com/googleplay/android-developer/answer/10787469) (collected vs shared; service providers; the Analytics purpose includes diagnosing crashes)

### Collected when release collection is on

Automatic Crashlytics SDK data ([disclosure](https://firebase.google.com/docs/android/play-data-disclosure#crashlytics)):

| Data | This app |
| --- | --- |
| Stack traces | Fatal Flutter framework errors and uncaught async errors. |
| Relevant application state | Crash-time state only. No custom keys. |
| Relevant device metadata | Field list below. |
| Crashlytics installation UUID | Counts installs hit by a crash. Not a user id. `setUserIdentifier` is never called. |

Also stored, from the [privacy examples](https://firebase.google.com/support/privacy):

- RFC-4122 UUID used to deduplicate crashes
- Firebase installation ID (FID). The installations SDK says this per-install id does **not** uniquely identify a user or physical device. Crashlytics uses it to rotate the Crashlytics installation UUID and stores it with the crash.
- Firebase session ID (random UUID tagging events with a session)
- Crash timestamp
- App bundle identifier and full version number
- Operating system name and version
- Whether the device is jailbroken or rooted
- Device model name, CPU architecture, RAM, and disk space
- Instruction pointers and, when available, plain-text method names
- Exception class name and message, or fatal signal name and code
- Loaded binary image name, UUID, size, and base address
- Whether the app was in the background
- Screen rotation
- Whether the proximity sensor was triggered

Not collected here (usage-dependent, and we do not use them): custom keys, Crashlytics logs, free-text user ids, developer-defined non-fatal events, Analytics breadcrumbs, Remote Config rollout metadata, `version-control-info.textproto`. Raw NDK minidumps are processed only if a native crash produces one, then discarded; extracted minidump data follows the 90-day retention.

The Crashlytics SDK depends on **Firebase sessions** ([disclosure](https://firebase.google.com/docs/android/play-data-disclosure#firebase-sessions)). That SDK collects app metadata (package name, OS information, SDK version, network connection type), device manufacturer and model, and when the app was foregrounded to start a session. Performance Monitoring is not included.

### IP address

The Crashlytics product row and the Crashlytics examples on the [privacy page](https://firebase.google.com/support/privacy) do **not** list IP address as stored crash data. Performance Monitoring does ("Country (based on IP address)"); Crashlytics does not. Do not add an IP type for Crashlytics. Firebase's general service-data wording mentions IP as technical data Google may process while operating Firebase; that is not a Crashlytics field this app reads or logs.

### Retention, encryption, sharing, optional

| Question | Answer | Source |
| --- | --- | --- |
| Retention | Crash stack traces, extracted minidump data, and associated identifiers (Crashlytics installation UUIDs and Firebase installation IDs) are kept **90 days**, then removed from live and backup systems. Raw NDK minidump bytes are temporary. | [Privacy page, Crashlytics row](https://firebase.google.com/support/privacy) |
| Encryption in transit | **Yes.** HTTPS. | [Data encryption](https://firebase.google.com/support/privacy#data-encryption) |
| Encryption at rest | **Yes.** Crashlytics is listed. | Same section |
| Shared? | **No.** Google processes reports as a service provider. Play does not treat that as sharing. Do not enable BigQuery export or integrations that forward report contents. AdMob sharing is a different SDK. | [Play data safety help](https://support.google.com/googleplay/android-developer/answer/10787469) |
| Collection optional? | **No** for release users. Profile and release call `setCrashlyticsCollectionEnabled(true)`. There is no in-app opt-out. Debug builds and a missing or mismatched `google-services.json` do not upload. On the form, collection is **required**. | This repo; [opt-in guide](https://firebase.google.com/support/privacy) (we did not ship the toggle) |
| Purpose | **Analytics** in Play's sense: diagnosing crashes. Not advertising. | [Play purpose definitions](https://support.google.com/googleplay/android-developer/answer/10787469) |
| Ephemeral? | **No.** Up to 90 days. | Privacy page |
| User-linked? | **No.** | This repo |

### Categories to tick

Collected, not shared, required, purpose Analytics (app health), encrypted in transit:

| Play category | Fields |
| --- | --- |
| **App info and performance > Crash logs** | Stack traces, exception class and message, signal name/code, instruction pointers, method names, binary image addresses, dedupe UUID |
| **App info and performance > Diagnostics** | Device model, manufacturer, CPU architecture, RAM, disk space, OS name and version, app version and bundle id, crash timestamp, foreground/background, screen rotation, proximity sensor, rooted/jailbroken flag, session foreground timing, SDK version, network connection type |
| **Device or other IDs** | Crashlytics installation UUID, Firebase installation ID (FID), Firebase session ID |

Do not tick Location, Personal info, Messages, Photos, Audio, or Financial info for Crashlytics. Network connection type is diagnostics, not precise location.
