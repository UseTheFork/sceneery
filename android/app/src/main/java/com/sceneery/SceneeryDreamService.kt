package com.sceneery

import android.service.dreams.DreamService
import android.view.View
import com.facebook.react.ReactInstanceManager
import com.facebook.react.ReactRootView
import com.facebook.react.common.LifecycleState
import com.facebook.react.modules.core.DefaultHardwareBackBtnHandler
import com.facebook.react.shell.MainReactPackage

/**
 * SceneeryDreamService - Minimal DreamService wrapper for React Native
 * 
 * This service extends Android's DreamService to enable screensaver functionality
 * while hosting a React Native view for the UI.
 */
class SceneeryDreamService : DreamService(), DefaultHardwareBackBtnHandler {
    
    private var reactRootView: ReactRootView? = null
    private var reactInstanceManager: ReactInstanceManager? = null

    override fun onAttachedToWindow() {
        super.onAttachedToWindow()
        
        // Configure screensaver behavior
        isInteractive = false
        isFullscreen = true
        
        // Initialize React Native
        reactRootView = ReactRootView(this)
        reactInstanceManager = ReactInstanceManager.builder()
            .setApplication(application)
            .setCurrentActivity(null)
            .setBundleAssetName("index.android.bundle")
            .setJSMainModulePath("index")
            .addPackage(MainReactPackage())
            .setUseDeveloperSupport(BuildConfig.DEBUG)
            .setInitialLifecycleState(LifecycleState.RESUMED)
            .build()
        
        // Start React application
        reactRootView?.startReactApplication(
            reactInstanceManager,
            "Sceneery",
            null
        )
        
        // Set the React view as the dream content
        setContentView(reactRootView)
    }

    override fun onDreamingStarted() {
        super.onDreamingStarted()
        reactInstanceManager?.onHostResume(null, this)
    }

    override fun onDreamingStopped() {
        super.onDreamingStopped()
        reactInstanceManager?.onHostPause(null)
    }

    override fun onDetachedFromWindow() {
        super.onDetachedFromWindow()
        
        // Clean up React Native
        reactInstanceManager?.onHostDestroy(null)
        reactRootView?.unmountReactApplication()
        reactRootView = null
        reactInstanceManager = null
    }

    override fun invokeDefaultOnBackPressed() {
        // No-op for screensaver
    }
}