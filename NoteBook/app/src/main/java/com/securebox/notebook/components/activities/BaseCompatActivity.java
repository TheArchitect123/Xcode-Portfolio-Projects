package com.securebox.notebook.components.activities;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;

public class BaseCompatActivity<T> extends AppCompatActivity {
    private T viewModel;

    protected T getViewModel(){
        return viewModel;
    }

    protected void setViewModel(T lclViewModel) {
         viewModel = lclViewModel;
    }

    //Any Base Logic Gets written here...

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        //Register the log cat results here...
    }
}
