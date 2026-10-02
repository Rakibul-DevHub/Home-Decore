/**
package com.devindeamaral.kolek

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity()
*/





package com.devindeamaral.kolek

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.View
import android.view.WindowInsets
import android.view.WindowInsetsAnimation
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {

    private val hideHandler = Handler(Looper.getMainLooper())
    private val hideRunnable = Runnable { applyImmersiveConstraints() }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 1. Force the layout frame to draw edge-to-edge natively
        WindowCompat.setDecorFitsSystemWindows(window, false)

        // 2. Intercept manual swipe actions on the system navigation bars
        window.decorView.setOnSystemUiVisibilityChangeListener { visibility ->
            if ((visibility and View.SYSTEM_UI_FLAG_HIDE_NAVIGATION) == 0) {
                resetHideTimer()
            }
        }

        // 3. Catch modern Android 15 IME (Keyboard) open/close animation lifecycles
        window.decorView.setWindowInsetsAnimationCallback(object : WindowInsetsAnimation.Callback(DISPATCH_MODE_STOP) {
            override fun onProgress(insets: WindowInsets, runningAnimations: List<WindowInsetsAnimation>): WindowInsets {
                return insets
            }

            override fun onEnd(animation: WindowInsetsAnimation) {
                super.onEnd(animation)
                // When keyboard animation finishes closing or opening, trigger the auto-hide count
                resetHideTimer()
            }
        })
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            applyImmersiveConstraints()
        }
    }

    private fun resetHideTimer() {
        hideHandler.removeCallbacks(hideRunnable)
        hideHandler.postDelayed(hideRunnable, 2000) // Exactly 2 seconds
    }

    private fun applyImmersiveConstraints() {
        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)

        // Use non-sticky transient behavior so the overlay can be modified programmatically
        windowInsetsController.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE

        // PIN the status bar permanently, HIDE the navigation bar
        windowInsetsController.show(WindowInsetsCompat.Type.statusBars())
        windowInsetsController.hide(WindowInsetsCompat.Type.navigationBars())
    }
}
