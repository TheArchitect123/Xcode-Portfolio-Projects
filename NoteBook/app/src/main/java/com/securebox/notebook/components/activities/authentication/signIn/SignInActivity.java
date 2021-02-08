package com.securebox.notebook.components.activities.authentication.signIn;

import android.content.Intent;
import android.graphics.drawable.ShapeDrawable;
import android.os.Bundle;

import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.snackbar.Snackbar;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentActivity;
import androidx.fragment.app.FragmentManager;
import androidx.lifecycle.ViewModelProvider;

import android.os.PersistableBundle;
import android.view.MenuItem;
import android.view.View;

import com.securebox.notebook.R;
import com.securebox.notebook.components.activities.BaseCompatActivity;
import com.securebox.notebook.components.activities.authentication.signIn.constants.bundles.SignInActivityBundles;
import com.securebox.notebook.components.activities.authentication.signIn.fragments.FragmentRegisterComponent;
import com.securebox.notebook.components.activities.authentication.signIn.fragments.FragmentSignInComponent;
import com.securebox.notebook.components.activities.authentication.signIn.view_models.SignInViewModel;
import com.securebox.notebook.components.activities.dashboard.view_models.DashboardViewModel;
import com.securebox.notebook.databinding.ActivitySignInBinding;
import com.securebox.notebook.databinding.DashboardactvLayoutBinding;

import java.io.FileNotFoundException;

import dagger.hilt.android.AndroidEntryPoint;

@AndroidEntryPoint
public final class SignInActivity extends BaseCompatActivity<SignInViewModel> {
    private ActivitySignInBinding signInPageBinding;
    private int tabIndex;

    protected void generateViewBinding() {
        setContentView((signInPageBinding = ActivitySignInBinding.inflate(getLayoutInflater())).getRoot());
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        generateViewBinding();
        if (this.getViewModel() == null) {
            initializeViewModel();
        }

        registerFragmentsBasedOnBottomBarSelection();
        if (savedInstanceState != null) {
            if (savedInstanceState.containsKey(SignInActivityBundles.selectedTabIndex)) {
                signInPageBinding.signInBottomNavigation.setSelectedItemId(savedInstanceState.getInt(SignInActivityBundles.currentSelectedTabIndex)); //Set the currently selected Item ID
            }
        } else {
            signInPageBinding.signInBottomNavigation.setSelectedItemId(R.id.sign_in_auth_mode); //Set the currently selected Item ID
        }
    }

    @Override
    public void onSaveInstanceState(@NonNull Bundle outState, @NonNull PersistableBundle outPersistentState) {
        super.onSaveInstanceState(outState, outPersistentState);

        //Currently Selected Tab Index
        outState.putInt(SignInActivityBundles.currentSelectedTabIndex, tabIndex);
    }

    @Override
    protected void onRestoreInstanceState(@NonNull Bundle savedInstanceState) {
        super.onRestoreInstanceState(savedInstanceState);

        if (savedInstanceState != null) {
            if (savedInstanceState.containsKey(SignInActivityBundles.selectedTabIndex)) {
                signInPageBinding.signInBottomNavigation.setSelectedItemId(savedInstanceState.getInt(SignInActivityBundles.currentSelectedTabIndex)); //Set the currently selected Item ID
            }
        } else {
            //Load the default values
            signInPageBinding.signInBottomNavigation.setSelectedItemId(R.id.sign_in_auth_mode); //Set the currently selected Item ID
        }
    }


    private void registerFragmentTouchEvents() {
        FragmentSignInComponent signInFragment = (FragmentSignInComponent) getSupportFragmentManager().findFragmentById(R.id.sign_in_fragment_manager);
        if(signInFragment != null) {
            //Register the events
        }
    }

    private void registerFragmentsBasedOnBottomBarSelection() {
        signInPageBinding.signInBottomNavigation.setOnNavigationItemSelectedListener(new BottomNavigationView.OnNavigationItemSelectedListener() {
            @Override
            public boolean onNavigationItemSelected(@NonNull MenuItem item) {
                return changeFragmentByIndex(tabIndex = item.getItemId());
            }
        });
    }

    public boolean changeFragmentByIndex(int tabId){
        FragmentManager supportingFragment = getSupportFragmentManager();

        //Clear the Current Collection of Fragments from this Page
        for (Fragment fragmentItem : supportingFragment.getFragments()) {
            supportingFragment.beginTransaction().remove(fragmentItem).commit();
        }
        
        if (tabId == R.id.sign_in_auth_mode) {
            signInPageBinding.signInBottomNavigation.setSelectedItemId(1);
            supportingFragment.beginTransaction().add(R.id.sign_in_fragment_manager,  FragmentSignInComponent.newInstance()).commit();
        } else {
            signInPageBinding.signInBottomNavigation.setSelectedItemId(0);
            supportingFragment.beginTransaction().add(R.id.sign_in_fragment_manager, FragmentRegisterComponent.newInstance()).commit();
        }

        return true;
    }

    //Fragment Exposures
    public int getCurrentTabIndex(){
        return tabIndex;
    }

    private void initializeViewModel() {
        this.setViewModel(new ViewModelProvider(this).get(SignInViewModel.class)); //Register the view model
    }
}