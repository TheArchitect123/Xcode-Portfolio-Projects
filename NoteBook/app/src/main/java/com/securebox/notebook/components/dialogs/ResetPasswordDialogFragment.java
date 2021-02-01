package com.securebox.notebook.components.dialogs;

import android.os.Bundle;
import android.text.Layout;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.DialogFragment;

import com.securebox.notebook.R;

import java.lang.annotation.Documented;

import kotlin.reflect.KVariance;

public class ResetPasswordDialogFragment extends DialogFragment {

    public static ResetPasswordDialogFragment newInstance(){
        //Initialise any services or properties here...
        return new ResetPasswordDialogFragment();
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public void onResume() {
        super.onResume();

        getDialog().getWindow().setAttributes((android.view.WindowManager.LayoutParams) getLayoutParameters());
    }


    private final ViewGroup.LayoutParams getLayoutParameters(){
        ViewGroup.LayoutParams layoutParams = getDialog().getWindow().getAttributes();
        layoutParams.width = ViewGroup.LayoutParams.MATCH_PARENT;
        layoutParams.height = ViewGroup.LayoutParams.MATCH_PARENT;

        return layoutParams;
    }


    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.reset_password_dialog_fragment, container, false);
    }
}
