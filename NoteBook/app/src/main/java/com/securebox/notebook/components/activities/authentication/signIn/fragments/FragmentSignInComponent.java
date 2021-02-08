package com.securebox.notebook.components.activities.authentication.signIn.fragments;

import android.content.ComponentName;
import android.content.Intent;
import android.gesture.GestureOverlayView;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;

import com.securebox.notebook.R;
import com.securebox.notebook.components.activities.BaseCompatFragment;
import com.securebox.notebook.components.activities.authentication.signIn.SignInActivity;
import com.securebox.notebook.components.activities.authentication.signIn.view_models.fragments.SignInFragmentViewModel;
import com.securebox.notebook.components.activities.dashboard.DashboardActivity;
import com.securebox.notebook.components.dialogs.ResetPasswordDialogFragment;
import com.securebox.notebook.components.dialogs.tags.DialogFragmentTags;
import com.securebox.notebook.components.intents.navigation.NavigationIntents;
import com.securebox.notebook.databinding.FramentSignInComponentBinding;

import dagger.hilt.android.AndroidEntryPoint;

@AndroidEntryPoint
public final class FragmentSignInComponent extends BaseCompatFragment<SignInFragmentViewModel, SignInActivity> {

    private FramentSignInComponentBinding fragmentBinding;

    public FragmentSignInComponent() {
        // Required empty public constructor
    }

    public static FragmentSignInComponent newInstance() {
        return new FragmentSignInComponent();
    }

    private void registerDialogueEvents() {
        fragmentBinding.resetPasswordButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //Open the password reset dialogue fragment
                ResetPasswordDialogFragment.newInstance().show(getChildFragmentManager(), DialogFragmentTags.RESETPASSWORD); //Render the dialog Fragment
            }
        });

        fragmentBinding.registerUserForSignInfragment.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                SignInActivity loginActivity = getParentActivity();
                if (loginActivity.getCurrentTabIndex() == 0) {
                    //Load the registration screen
                    loginActivity.changeFragmentByIndex(1);
                } else {
                    //load the login screen
                    loginActivity.changeFragmentByIndex(0);
                }
            }
        });

        fragmentBinding.loginButtonSignInAuth.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //Begin authenticating the user, and check their credentials againt the local db
                NavigationIntents.navigateToUserDashboard(getParentActivity());
            }
        });
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        registerDialogueEvents();
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        fragmentBinding = FramentSignInComponentBinding.inflate(inflater, container, false);
        return fragmentBinding.getRoot();
    }
}