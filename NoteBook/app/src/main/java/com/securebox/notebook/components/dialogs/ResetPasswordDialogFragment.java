package com.securebox.notebook.components.dialogs;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.DialogFragment;

import com.securebox.notebook.R;

public class ResetPasswordDialogFragment extends DialogFragment {

    public static ResetPasswordDialogFragment newInstance(){
        //Initialise any services or properties here...
        return new ResetPasswordDialogFragment();
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        //Any Services are initialised here
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.reset_password_dialog_fragment, container, false);
    }
}
