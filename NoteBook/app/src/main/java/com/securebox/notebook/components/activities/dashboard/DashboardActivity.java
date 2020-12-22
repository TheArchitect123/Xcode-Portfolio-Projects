package com.securebox.notebook.components.activities.dashboard;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.lifecycle.ViewModelProvider;

import android.os.Bundle;

import com.securebox.notebook.R;
import com.securebox.notebook.components.activities.dashboard.view_models.DashboardViewModel;

import javax.inject.Inject;

import butterknife.BindView;
import butterknife.BindViews;

public class DashboardActivity extends AppCompatActivity {

    private DashboardViewModel viewModel;

    //Views
    @BindViews(R.id.accelerate) Toolbar dashToolbar;


    //@BindViews(R.id.)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_dashboard);
        initializeServices();

        //Reset the toolbar for backportable support
        this.setSupportActionBar(this.dashToolbar);
    }

    private void initializeServices(){
        this.viewModel = new ViewModelProvider(this).get(DashboardViewModel.class); //Register the view model
    }
}