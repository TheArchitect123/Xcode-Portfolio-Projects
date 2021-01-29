package com.securebox.notebook.components.activities.authentication.signIn.fragments;

import android.os.Bundle;

import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.securebox.notebook.R;
import com.securebox.notebook.components.activities.BaseCompatFragment;
import com.securebox.notebook.components.activities.authentication.signIn.view_models.fragments.FragmentRegisterViewModel;

public class FragmentRegisterComponent extends BaseCompatFragment<FragmentRegisterViewModel> {

    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    private String mParam1;
    private String mParam2;

    public FragmentRegisterComponent() {
        // Required empty public constructor
    }

    public static FragmentRegisterComponent newInstance(String param1, String param2) {
        FragmentRegisterComponent fragment = new FragmentRegisterComponent();
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
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_register_component, container, false);
    }
}