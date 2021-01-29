package com.securebox.notebook.components.activities.authentication.signIn.fragments;

import android.os.Bundle;

import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.securebox.notebook.R;
import com.securebox.notebook.components.activities.BaseCompatFragment;
import com.securebox.notebook.components.activities.authentication.signIn.view_models.fragments.SignInFragmentViewModel;

public class FragmentSignInComponent extends BaseCompatFragment<SignInFragmentViewModel> {

    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    private String mParam1;
    private String mParam2;

    public FragmentSignInComponent() {
        // Required empty public constructor
    }

    public static FragmentSignInComponent newInstance(String param1, String param2) {
        FragmentSignInComponent fragment = new FragmentSignInComponent();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            //Get the results passed from the sign InActivity
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        return inflater.inflate(R.layout.frament_sign_in_component, container, false);
    }
}