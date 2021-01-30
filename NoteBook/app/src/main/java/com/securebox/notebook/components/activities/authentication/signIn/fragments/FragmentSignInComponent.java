package com.securebox.notebook.components.activities.authentication.signIn.fragments;

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
import com.securebox.notebook.components.activities.authentication.signIn.view_models.fragments.SignInFragmentViewModel;
import com.securebox.notebook.components.dialogs.ResetPasswordDialogFragment;
import com.securebox.notebook.components.dialogs.tags.DialogFragmentTags;
import com.securebox.notebook.databinding.FramentSignInComponentBinding;

import kotlin._Assertions;

public class FragmentSignInComponent extends BaseCompatFragment<SignInFragmentViewModel> {

    private FramentSignInComponentBinding fragmentBinding;

    public FragmentSignInComponent() {
        // Required empty public constructor
    }

    public static FragmentSignInComponent newInstance() {
        return new FragmentSignInComponent();
    }

    private void registerDialogueEvents(){
        fragmentBinding.resetPasswordButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //Open the password reset dialogue fragment
                ResetPasswordDialogFragment.newInstance().show(getChildFragmentManager(), DialogFragmentTags.RESETPASSWORD); //Render the dialog Fragment
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