package com.alexapps.sukar;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.view.ViewTreeObserver;
import android.view.WindowManager;


import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;
public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    //make transparent status bar
    getWindow().setStatusBarColor(0x00000000);
    GeneratedPluginRegistrant.registerWith(this); 
    //Remove full screen flag after load
    ViewTreeObserver vto = getFlutterView().getViewTreeObserver();
    vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
      @Override
      public void onGlobalLayout() {
        getFlutterView().getViewTreeObserver().removeOnGlobalLayoutListener(this);
        getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
      }
    });
  }
}




public class Application extends FlutterApplication implements PluginRegistrantCallback {
  @Override
  public void onCreate() {
    super.onCreate();
    FlutterFirebaseMessagingService.setPluginRegistrant(this);
  }

  @Override
  public void registerWith(PluginRegistry registry) {
    GeneratedPluginRegistrant.registerWith(registry);
  }
}