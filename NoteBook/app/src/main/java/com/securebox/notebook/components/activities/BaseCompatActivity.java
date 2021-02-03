package com.securebox.notebook.components.activities;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;

public abstract class BaseCompatActivity<T> extends AppCompatActivity {
    private T viewModel;
    protected T getViewModel(){
        return viewModel != null ? viewModel : null; //Prevent Null Access Exception
    }

    protected void setViewModel(T lclViewModel) {
         viewModel = lclViewModel;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        //Register the log cat results here...
    }
}
