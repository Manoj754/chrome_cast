package com.example.cast_example
import android.os.Bundle
import com.google.android.gms.cast.framework.CastContext
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterFragmentActivity 

class MainActivity: FlutterFragmentActivity () {
//    override fun onCreate(Bundle savedInstanceState){
//
//    }


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
     
      
        CastContext.getSharedInstance(applicationContext)
      

//        GeneratedPluginRegistrant.registerWith(this) // here is the error: Type mismatch. Required: FlutterEngine! Found: MainActivity
//
//        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
//            if (call.method == "helloFromNativeCode") {
//                val greetings = helloFromNativeCode()
//                result.success(greetings)
//            }
//        }
    }

//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//
//
//    }
}
