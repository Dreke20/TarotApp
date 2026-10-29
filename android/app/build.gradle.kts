import java.util.Properties
import java.io.FileInputStream
import java.io.File

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // Resolved here, applied at the bottom only when google-services.json is present
    // and its package_name matches applicationId. See FIREBASE_CRASHLYTICS.md.
    id("com.google.gms.google-services") apply false
    id("com.google.firebase.crashlytics") apply false
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "oraculum.dirtysouth"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "28.2.13676358"

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    signingConfigs {
        create("release") {
            val keyAliasVal = keystoreProperties.getProperty("keyAlias")
            val keyPasswordVal = keystoreProperties.getProperty("keyPassword")
            val storeFileVal = keystoreProperties.getProperty("storeFile")
            val storePasswordVal = keystoreProperties.getProperty("storePassword")
            if (keyAliasVal != null && storeFileVal != null) {
                val candidateFile = File(storeFileVal)
                storeFile = if (candidateFile.isAbsolute) candidateFile else rootProject.file(storeFileVal)
                keyAlias = keyAliasVal
                keyPassword = keyPasswordVal
                storePassword = storePasswordVal
            }
        }
    }

    defaultConfig {
        // Must match package_name in android/app/google-services.json
        // (Firebase project oraculum-5d56e). Store listing docs still say
        // oraculum.dirtysouth; this id is the one Crashlytics is registered for.
        applicationId = "com.tarotapp.tarot_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        // Play requires target API 36 for new apps. Do not inherit Flutter's default.
        targetSdk = 36
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            val releaseSigning = signingConfigs.findByName("release")
            val store = releaseSigning?.storeFile
            if (keystorePropertiesFile.exists() && store != null && store.exists()) {
                signingConfig = releaseSigning
            }
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }

    }

    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
        jniLibs {
            // Strip debug symbols for slim direct APK distribution
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

// A release artifact must be signed with the upload key. Do not fall back to
// the debug keystore when android/key.properties is missing.
gradle.taskGraph.whenReady {
    val assemblingRelease = allTasks.any { task ->
        val name = task.name
        val isRelease = name.contains("Release")
        val packagesApp = name.startsWith("assemble") ||
            name.startsWith("bundle") ||
            name.startsWith("sign") ||
            name.startsWith("package")
        isRelease && packagesApp
    }
    if (!assemblingRelease) return@whenReady
    if (!keystorePropertiesFile.exists()) {
        throw GradleException(
            "Release builds require android/key.properties and an upload keystore. Refusing to sign with the debug key.",
        )
    }
    val storePath = keystoreProperties.getProperty("storeFile")
    if (storePath.isNullOrBlank()) {
        throw GradleException("android/key.properties is missing storeFile.")
    }
    val namedStore = File(storePath)
    val resolvedStore = if (namedStore.isAbsolute) namedStore else rootProject.file(storePath)
    if (!resolvedStore.exists()) {
        throw GradleException(
            "Release builds require the upload keystore named in android/key.properties. " +
                "Refusing to sign with the debug key.",
        )
    }
}

// google-services fails the build when the json is missing or its package_name
// does not match applicationId. iOS has no GoogleService-Info.plist yet; Dart
// init catches that and keeps running.
val crashlyticsApplicationId = "com.tarotapp.tarot_app"
val googleServicesFile = file("google-services.json")
val googleServicesReady = googleServicesFile.exists() &&
    googleServicesFile.readText().contains("\"package_name\": \"$crashlyticsApplicationId\"")
if (googleServicesReady) {
    apply(plugin = "com.google.gms.google-services")
    apply(plugin = "com.google.firebase.crashlytics")
} else if (googleServicesFile.exists()) {
    logger.warn(
        "android/app/google-services.json is present but package_name is not " +
            "$crashlyticsApplicationId. Crashlytics Gradle plugins were not applied. " +
            "See FIREBASE_CRASHLYTICS.md.",
    )
}
