package com.securebox.notebook.components.activities.dashboard.view_models;

import android.app.Application;
import android.util.Log;
import androidx.annotation.NonNull;
import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;

import javax.inject.Inject;
import dagger.hilt.android.AndroidEntryPoint;

//Data
import com.securebox.notebook.database.NBDatabaseConnection;

public final class DashboardViewModel extends AndroidViewModel {
    NBDatabaseConnection databaseConnection;

    //Inject all dependencies using the Hilt
    public DashboardViewModel(@NonNull Application application) {
        super(application);

        Log.i("application_log", "Application Item" + application);
    }

    public String getDatabaseConnection(){
        return "Returned Database: " + databaseConnection;
    }

    public void setDatabaseConnection(NBDatabaseConnection databaseConnectionItem){
        this.databaseConnection = databaseConnectionItem;
    }
}
