package com.example.pltfrm_chnl_demo

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "pltfrm_chnl_demo/info"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery Level not available.", null)
                }
            } else if (call.method == "getBatteryStatus") {
                try {
                    val batteryStatus = getBatteryStatus()
                    if (batteryStatus != -1) {
                        result.success(batteryStatus)
                    } else {
                        result.error("UNAVAILABLE", "Battery Status not available", null)
                    }
                } catch (e: Error) {
                    result.error("UNAVAILABLE", e.message, e.localizedMessage)
                }
            }
        }
    }

    private fun getBatteryLevel() : Int {
        val batteryLevel: Int
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100/ intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }

    private fun getBatteryStatus() :Int {
        val batteryStatus: Int
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryStatus = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_STATUS)
        } else {
            val intent  = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryStatus = intent!!.getIntExtra(BatteryManager.EXTRA_STATUS, -1)
        }

        return batteryStatus
    }
}
