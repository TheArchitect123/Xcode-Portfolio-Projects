package com.securebox.notebook.components.activities.dashboard;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
import androidx.lifecycle.ViewModelProvider;

import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;

import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.android.material.snackbar.Snackbar;
import com.securebox.notebook.R;
import com.securebox.notebook.components.activities.BaseCompatActivity;
import com.securebox.notebook.components.activities.dashboard.view_models.DashboardViewModel;
import com.securebox.notebook.database.NBDatabaseConnection;

import javax.inject.Inject;
import butterknife.BindViews;
import butterknife.ButterKnife;
import dagger.hilt.android.AndroidEntryPoint;

@AndroidEntryPoint
public class DashboardActivity extends BaseCompatActivity<DashboardViewModel> {

    //Bind all the views directly from the layout files to avoid boilerplate FindViewById methods
    @BindViews(R.id.dashboard_bottom_navigation) BottomNavigationView dashboardBottomBar;
    @BindViews(R.id.dashboard_coordinator_layout) CoordinatorLayout dashboardCoordinatorLayout;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.dashboardactv_layout);
        ButterKnife.bind(this);

        initializeServices();

        //register selectors
        registerAppBarSelectors();
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        switch(item.getItemId()){
            case R.id.dashboard_common_search_menu_id:
                Snackbar.make(this.dashboardCoordinatorLayout, "Hello there, this is a successful search", 3);

                //Open the search view
                break;

            case R.id.dashboard_common_sort_items_menu_id:

                //Open the Sort Menu, which will allow users to sort the items via the recycler view
                break;
        }

        return super.onOptionsItemSelected(item);
    }

    private void registerAppBarSelectors(){
        dashboardBottomBar.setOnNavigationItemSelectedListener(new BottomNavigationView.OnNavigationItemSelectedListener() {
            @Override
            public boolean onNavigationItemSelected(@NonNull MenuItem item) {

                switch(item.getItemId()){
                    case R.id.dashboard_main_page_id:
                        break;
                    case R.id.settings_page_id:
                        //Use a fragment transaction here, to switch between the dashboard and settings
                        break;
                }
                return true;
            }
        });

        dashboardBottomBar.setOnNavigationItemReselectedListener(new BottomNavigationView.OnNavigationItemReselectedListener() {
            @Override
            public void onNavigationItemReselected(@NonNull MenuItem item) {

            }
        });
    }

    private void initializeServices(){
        this.setViewModel(new ViewModelProvider(this).get(DashboardViewModel.class)); //Register the view model
        Log.i("random_id", "Registered view model " + this.getViewModel());

//        this.getViewModel().setDatabaseConnection(databaseConnection);
        //Log.i("database_id_connection", this.getViewModel().getDatabaseConnection());
    }
}