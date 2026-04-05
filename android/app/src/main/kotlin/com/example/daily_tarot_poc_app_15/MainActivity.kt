package com.example.daily_tarot_poc_app_15

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "mc"
        ).setMethodCallHandler { call, result ->

            when (call.method) {
                "send" -> {
                    sendMessage(call.argument<String>("text")!!)
                    result.success(true)
                    return@setMethodCallHandler
                }
            }
            result.notImplemented()


        }

    }


    fun sendMessage(text: String) {
        val intent = Intent().apply {
            action = Intent.ACTION_SEND
            putExtra(Intent.EXTRA_TEXT, text)
            type = "text/plain"
        }
        startActivity(Intent.createChooser(intent, null))
    }


}
