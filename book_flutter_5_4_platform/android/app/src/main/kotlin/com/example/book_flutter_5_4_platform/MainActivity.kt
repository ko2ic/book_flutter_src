package com.example.book_flutter_5_4_platform

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {

    companion object {
        const val CHANNEL = "sample/toPlatformScreen"
        const val REQUEST_CODE = 100
    }

    lateinit var channel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        this.channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).apply {
            setMethodCallHandler { call: MethodCall?, result: MethodChannel.Result? ->
                when (call?.method) {
                    "toPlatformScreen" -> {
                        val label = call.argument<String>("label_from_dart")
                        startActivityForResult(NextActivity.intent(this@MainActivity).apply {
                            putExtra("label", label)
                        }, REQUEST_CODE)
                        result?.success("Platform Screen was displayed!!")
                    }
                    else -> result?.notImplemented()
                }
            }
        }

    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        when (requestCode) {
            REQUEST_CODE -> {
                channel.invokeMethod("onClosed", mapOf("from_platform" to "Called onClosed() in Android"))
            }
        }
    }
}

