package com.securebox.notebook.components.activities.dashboard.view_models;

import android.app.Application;

import androidx.annotation.NonNull;
import androidx.lifecycle.AndroidViewModel;

public class DashboardViewModel extends AndroidViewModel {

    //Inject all dependencies using the Hilt
    public DashboardViewModel(@NonNull Application application) {
        super(application);
    }
}
