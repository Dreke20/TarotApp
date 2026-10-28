package oraculum.dirtysouth

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.provider.Settings
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            SPEECH_PERMISSIONS_CHANNEL,
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "microphoneStatus" -> result.success(microphoneStatus())
                "speechStatus" -> result.success("granted")
                "openSettings" -> result.success(openAppSettings())
                else -> result.notImplemented()
            }
        }
    }

    private fun microphoneStatus(): String {
        val permission = Manifest.permission.RECORD_AUDIO
        val granted = ContextCompat.checkSelfPermission(this, permission) ==
            PackageManager.PERMISSION_GRANTED
        if (granted) return "granted"
        val canAskAgain = ActivityCompat.shouldShowRequestPermissionRationale(this, permission)
        return if (canAskAgain) "denied" else "permanentlyDenied"
    }

    private fun openAppSettings(): Boolean {
        return try {
            val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS).apply {
                data = Uri.fromParts("package", packageName, null)
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            }
            startActivity(intent)
            true
        } catch (_: Exception) {
            false
        }
    }

    companion object {
        private const val SPEECH_PERMISSIONS_CHANNEL = "oraculum/speech_permissions"
    }
}
