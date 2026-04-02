package com.example.daily_tarot_poc_app_12

import android.content.Intent
import android.graphics.Bitmap
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)


        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "daily_tarot_poc_app_12"
        ).setMethodCallHandler { call, result ->

            when (call.method) {

                "share" -> {
                    val text = call.argument<String>("text")

                    if (text == null) {
                        result.notImplemented()
                        return@setMethodCallHandler
                    }
                    share(text)
                    result.success(true)

                }

            }


        }

    }


    fun share(text: String) {
        val intent = Intent().apply {
            action = Intent.ACTION_SEND
            putExtra(Intent.EXTRA_TEXT, text)
            type = "text/plain"
        }
        startActivity(Intent.createChooser(intent, null))
    }


    fun save(bitmap: Bitmap) {
        
    }




}
