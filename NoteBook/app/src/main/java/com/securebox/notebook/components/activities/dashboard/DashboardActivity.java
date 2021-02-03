package com.securebox.notebook.components.activities.dashboard;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
import androidx.lifecycle.ViewModelProvider;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;
import androidx.navigation.ui.AppBarConfiguration;

import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.SearchView;

import com.google.android.material.appbar.MaterialToolbar;
import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.android.material.snackbar.Snackbar;
import com.securebox.notebook.R;
import com.securebox.notebook.components.activities.BaseCompatActivity;
import com.securebox.notebook.components.activities.dashboard.view_models.DashboardViewModel;
import com.securebox.notebook.databinding.DashboardactvLayoutBinding;

import dagger.hilt.android.AndroidEntryPoint;

@AndroidEntryPoint
public final class DashboardActivity extends BaseCompatActivity<DashboardViewModel> {
    private DashboardactvLayoutBinding dashboardBinding;
    protected void generateViewBinding(){
        setContentView((dashboardBinding = DashboardactvLayoutBinding.inflate(getLayoutInflater())).getRoot());
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        generateViewBinding();

        //View Model -- Services
        initializeServices();

        //register selectors
        registerAppBarSelectors();
        configureFloatingActionButton();

        //Toolbar Configuration
        setSupportActionBar(dashboardBinding.dashboardMenuBar);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.dashboard_menu_items, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        switch(item.getItemId()){
            case R.id.dashboard_common_search_menu_id:

                //Opens up a search view, which will allow a user, to search through results
                return true;

            case R.id.dashboard_common_sort_items_menu_id:

                //Open up a bottom navigation drawer, where the user can select their filter type
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
        dashboardBinding.dashboardFloatingButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, "Here's a Snackbar", Snackbar.LENGTH_LONG)
                        .setAction("Action", null).show();
            }
        });
    }

    private void initializeServices(){
        this.setViewModel(new ViewModelProvider(this).get(DashboardViewModel.class)); //Register the view model
    }
}