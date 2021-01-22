package com.securebox.notebook.components.activities.authentication.signIn;

import android.graphics.drawable.ShapeDrawable;
import android.os.Bundle;

import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.snackbar.Snackbar;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.lifecycle.ViewModelProvider;

import android.view.View;

import com.securebox.notebook.R;
import com.securebox.notebook.components.activities.BaseCompatActivity;
import com.securebox.notebook.components.activities.authentication.signIn.view_models.SignInViewModel;
import com.securebox.notebook.components.activities.dashboard.view_models.DashboardViewModel;
import com.securebox.notebook.databinding.ActivitySignInBinding;
import com.securebox.notebook.databinding.DashboardactvLayoutBinding;

import dagger.hilt.android.AndroidEntryPoint;

@AndroidEntryPoint
public class SignInActivity extends BaseCompatActivity<SignInViewModel> {

    private ActivitySignInBinding signInPageBinding;
    protected void generateViewBinding(){
        signInPageBinding = ActivitySignInBinding.inflate(getLayoutInflater());
        setContentView(signInPageBinding.getRoot());
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        generateViewBinding();
        initializeServices();

        //Replace the Action Bar, with the default Toolbar
        setSupportActionBar(signInPageBinding.dashboardMenuBar);
    }


    private void initializeServices(){
        this.setViewModel(new ViewModelProvider(this).get(SignInViewModel.class)); //Register the view model
    }

    //
//    protected void generateViewBinding(){
//        dashboardBinding = DashboardactvLayoutBinding.inflate(getLayoutInflater());
//        setContentView(dashboardBinding.getRoot());
//    }
//
//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        setContentView(R.layout.activity_sign_in);
//    }
}