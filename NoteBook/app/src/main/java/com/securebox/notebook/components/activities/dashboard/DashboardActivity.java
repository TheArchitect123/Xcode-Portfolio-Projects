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
import com.securebox.notebook.databinding.DashboardactvLayoutBinding;

import dagger.hilt.android.AndroidEntryPoint;

@AndroidEntryPoint
public class DashboardActivity extends BaseCompatActivity<DashboardViewModel> {

    //Bind all the views directly from the layout files to avoid boilerplate FindViewById methods
//    @BindView(R.id.dashboard_bottom_navigation) BottomNavigationView dashboardBottomBar;
//    @BindView(R.id.dashboard_coordinator_layout) CoordinatorLayout dashboardCoordinatorLayout;
    private DashboardactvLayoutBinding dashboardBinding;
    protected void generateViewBinding(){
        dashboardBinding = DashboardactvLayoutBinding.inflate(getLayoutInflater());
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.dashboardactv_layout);
        generateViewBinding();

        //View Model -- Services
        initializeServices();

        //register selectors
        registerAppBarSelectors();

        //Replace the default action bar
        setSupportActionBar(dashboardBinding.dashboardMenuBar);
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {

        //I've already inflated the menu items on the layout xml file.
        //There should be any need to inflate it again, at runtime

        Log.i("menu_item: ", "" + item);
        switch(item.getItemId()){
            case R.id.dashboard_common_search_menu_id:
                Snackbar.make(dashboardBinding.dashboardCoordinatorLayout, "Hello there, this is a successful search", 3).show();

                return true;

            case R.id.dashboard_common_sort_items_menu_id:

                Snackbar.make(dashboardBinding.dashboardCoordinatorLayout, "Hello there, this is a successful sort", 3).show();

                Log.i("logged_search", "Successfully selected the search menu item");
                return true;
        }

        return super.onOptionsItemSelected(item);
    }

    private void registerAppBarSelectors(){
        dashboardBinding.dashboardBottomNavigation.setOnNavigationItemSelectedListener(new BottomNavigationView.OnNavigationItemSelectedListener() {
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

        dashboardBinding.dashboardBottomNavigation.setOnNavigationItemReselectedListener(new BottomNavigationView.OnNavigationItemReselectedListener() {
            @Override
            public void onNavigationItemReselected(@NonNull MenuItem item) {

            }
        });
    }

    void configureFloatingActionButton(){

    }

    private void initializeServices(){
        this.setViewModel(new ViewModelProvider(this).get(DashboardViewModel.class)); //Register the view model
    }
}