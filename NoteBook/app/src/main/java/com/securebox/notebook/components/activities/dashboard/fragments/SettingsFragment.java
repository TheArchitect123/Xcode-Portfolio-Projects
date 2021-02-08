package com.securebox.notebook.components.activities.dashboard.fragments;

import android.os.Bundle;
import androidx.preference.PreferenceFragmentCompat;
import com.securebox.notebook.R;

public class SettingsFragment extends PreferenceFragmentCompat {

    @Override
    public void onCreatePreferences(Bundle savedInstanceState, String rootKey) {
        setPreferencesFromResource(R.xml.root_preferences, rootKey);
    }
}