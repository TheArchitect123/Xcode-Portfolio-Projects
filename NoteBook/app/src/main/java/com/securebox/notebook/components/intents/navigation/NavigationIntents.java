package com.securebox.notebook.components.intents.navigation;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Intent;
import android.util.Log;

import com.securebox.notebook.components.activities.authentication.signIn.SignInActivity;
import com.securebox.notebook.components.activities.dashboard.DashboardActivity;

import javax.annotation.Nonnull;

public final class NavigationIntents {

    private static <T extends Activity, E extends Activity> Intent initializeCommonNavIntent(Class<T> component, E activity) {
        Intent commonIntent = activity.getIntent();
        commonIntent.setComponent(new ComponentName(activity.getPackageName(), component.getName()));
        commonIntent.setAction(Intent.ACTION_VIEW);

        return commonIntent;
    }

    public static void navigateToUserDashboard(@Nonnull SignInActivity currentActivity) {
        currentActivity.startActivity(initializeCommonNavIntent(DashboardActivity.class, currentActivity));
    }
}
