package com.changmin.carwashChangMin

//import io.flutter.embedding.android.FlutterActivity
//class MainActivity: FlutterActivity() {
//}

// 2023-12-15.RSY.네이버 로그인 아이디를 위해 아래 코드로 변경함.
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterFragmentActivity(
        override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
        if (checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            requestPermissions(arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), 0);
        }
    }
}
)
