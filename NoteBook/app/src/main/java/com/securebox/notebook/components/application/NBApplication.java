package com.securebox.notebook.components.application;

import android.app.Application;

import androidx.room.Room;
import androidx.room.RoomDatabase;

import com.securebox.notebook.database.NBDatabaseConnection;
import com.securebox.notebook.database.access.DataAccessManager;
import com.securebox.notebook.database.constants.DatabaseInfoConstants;

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

        DataAccessManager.localDatabaseConnection = Room.databaseBuilder(getApplicationContext(),
                NBDatabaseConnection.class, DatabaseInfoConstants.databaseName).build();
    }

    @Override
    public void onTerminate() {
        super.onTerminate();

    }
}
