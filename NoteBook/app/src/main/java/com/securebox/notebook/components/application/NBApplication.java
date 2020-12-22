package com.securebox.notebook.components.application;

import android.app.Application;
import dagger.hilt.android.HiltAndroidApp;

@HiltAndroidApp
public class NBApplication extends Application {

    @Override
    public void onLowMemory() {
        super.onLowMemory();
    }

    @Override
    public void onCreate() { //When the application first starts up, register all the services, configure your database, etc
        super.onCreate();

    }

    @Override
    public void onTerminate() {
        super.onTerminate();
    }
}
