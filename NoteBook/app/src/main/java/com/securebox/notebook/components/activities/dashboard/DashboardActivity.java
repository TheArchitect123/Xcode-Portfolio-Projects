package com.securebox.notebook.components.activities.dashboard;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.lifecycle.ViewModelProvider;

import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;

import com.securebox.notebook.R;
import com.securebox.notebook.components.activities.BaseCompatActivity;
import com.securebox.notebook.components.activities.dashboard.view_models.DashboardViewModel;
import com.securebox.notebook.database.NBDatabaseConnection;

import javax.inject.Inject;
import butterknife.BindViews;
import dagger.hilt.android.AndroidEntryPoint;

@AndroidEntryPoint
public class DashboardActivity extends BaseCompatActivity<DashboardViewModel> {
    @Inject NBDatabaseConnection databaseConnection;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.dashboardactv_layout);
        initializeServices();
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        switch(item.getItemId()){
            case R.id.dashboard_common_search_menu_id:

                //Open the search view
                break;

            case R.id.dashboard_common_sort_items_menu_id:

                //Open the Sort Menu, which will allow users to sort the items via the recycler view
                break;
        }
        return super.onOptionsItemSelected(item);
    }

    private void initializeServices(){
        this.setViewModel(new ViewModelProvider(this).get(DashboardViewModel.class)); //Register the view model
        Log.i("random_id", "Registered view model " + this.getViewModel());

        this.getViewModel().setDatabaseConnection(databaseConnection);
        Log.i("database_id_connection", this.getViewModel().getDatabaseConnection());
    }
}