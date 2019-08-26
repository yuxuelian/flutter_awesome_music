package com.kaibo.flutter_common_plugin

import android.app.Activity
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.ActivityInfo
import android.content.res.TypedArray
import android.graphics.Color
import android.os.BatteryManager
import android.os.Build
import android.view.View
import android.view.WindowManager

/**
 * @author: kaibo
 * @date: 2019/8/21 12:26
 * @GitHub: https://github.com/yuxuelian
 * @qq: 568966289
 * @description:
 */

/**
 * 设置沉浸式
 * isLight是否对状态栏颜色变黑
 */
fun Activity.immersive(isLight: Boolean) {
    with(window) {
        when {
            Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP -> {
                //清除状态栏默认状态
                clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS or WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION)
                addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
                //SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN 布局设置为全屏布局
                //SYSTEM_UI_FLAG_LAYOUT_STABLE
                //SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
                decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or
                        View.SYSTEM_UI_FLAG_LAYOUT_STABLE or
                        if (isLight && Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                            View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
                        } else {
                            0
                        }
                statusBarColor = Color.TRANSPARENT
            }
            Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT -> {
                this.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
            }
            else -> {
                return
            }
        }
    }
}

// 获取手机电量
fun Activity.getBatteryLevel() = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
    val systemService = applicationContext.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
    systemService.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
} else {
    val intent: Intent? = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
    intent?.let {
        it.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / it.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
    } ?: -1
}

private fun isTranslucentOrFloating(activity: Activity) = try {
    val styleableRes = Class.forName("com.android.internal.R\$styleable").getField("Window").get(null) as IntArray
    ActivityInfo::class.java.getMethod("isTranslucentOrFloating", TypedArray::class.java).run {
        isAccessible = true
        invoke(null, activity.obtainStyledAttributes(styleableRes)) as Boolean
    }
} catch (e: Exception) {
    e.printStackTrace()
    false
}

// 固定横屏
fun Activity.fixedScreenVertical() {
    if (Build.VERSION.SDK_INT == Build.VERSION_CODES.O && isTranslucentOrFloating(this)) {
        return
    } else {
        // 设置屏幕方向为纵向
        requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_PORTRAIT
    }
}