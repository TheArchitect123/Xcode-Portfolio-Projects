package com.securebox.notebook.components.activities;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

public abstract class BaseCompatFragment<T, CurActivity> extends Fragment {
    private T viewModel;
    protected T getViewModel(){
        return viewModel != null ? viewModel : null; //Prevent Null Access Exception
    }
    protected void setViewModel(T lclViewModel) {
        viewModel = lclViewModel;
    }


    protected CurActivity getParentActivity(){
        return (CurActivity)this.requireActivity();
    }

    //Add some base logic here
    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return super.onCreateView(inflater, container, savedInstanceState);
    }
}
