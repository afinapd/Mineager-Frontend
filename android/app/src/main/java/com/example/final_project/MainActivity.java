package com.example.final_project;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;

import com.rscja.deviceapi.RFIDWithUHF;
import com.rscja.deviceapi.entity.SimpleRFIDEntity;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "info.mylabstudio.dev/smm";
    RFIDWithUHF mReader;
    InitUhf initUhf;

    @Override
    protected void onDestroy() {
        super.onDestroy();
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    switch (call.method) {
                        case "getBatteryLevel":
                            int batteryLevel = getBatteryLevel();

                            if (batteryLevel != -1) {
                                result.success(batteryLevel);
                            } else {
                                result.error("UNAVAILABLE", "Battery level not available.", null);
                            }
                            break;
                        case "initUhfReader":
                            String resultInfo = initDevice();
                            switch (resultInfo) {
                                case "0":
                                    result.success(true);
                                    break;
                                case "1":
                                    result.error("002", "failed", null);
                                    break;
                                case "2":
                                    result.error("001", "already init", null);
                                    break;
                                default:
                                    result.error("006", "unknown state", null);
                            }
                            break;
                        case "disposeUhfReader":
                            Boolean resultDispose = disposeDevice();
                            if (resultDispose) {
                                result.success(true);
                            } else {
                                result.error("003", "device is not active yet", null);
                            }
                            break;
                        case "scanIDCard":
                            String idCard = getIdCardInfo();
                            if (idCard != null && idCard.length() > 0) {
                                result.success(idCard);
                            } else {
                                result.error("004", "Card can not be read", null);
                            }
                            break;
                        default:
                            result.notImplemented();
                    }
                });
    }

    private String initDevice() {
        if (initUhf == null) {
            initUhf = new InitUhf();
            mReader = initUhf.getmReader();
            return "0";
        } else {
            return "2";
        }
    }

    private Boolean disposeDevice() {
        if (mReader != null) {
            mReader.free();
            initUhf = null;
            return true;
        } else {
            return false;
        }
    }

    private String getIdCardInfo() {
        SimpleRFIDEntity entity = null;
        String data = "";
        try {
            entity = mReader.readData("00000000", RFIDWithUHF.BankEnum.valueOf("UII"), 0, 6);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        if (entity != null) {
            data = entity.getData();
        } else {
            data = "";
        }
        return data;
    }

    private int getBatteryLevel() {
        int batteryLevel = -1;
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(getApplicationContext()).registerReceiver(null,
                    new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100)
                    / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }

        return batteryLevel;
    }
}
