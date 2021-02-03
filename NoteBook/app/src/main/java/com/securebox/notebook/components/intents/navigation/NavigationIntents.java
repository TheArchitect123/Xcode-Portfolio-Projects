package com.securebox.notebook.components.intents.navigation;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Intent;
import com.securebox.notebook.components.activities.authentication.signIn.SignInActivity;
import com.securebox.notebook.components.activities.dashboard.DashboardActivity;

import javax.annotation.Nonnull;

public final class NavigationIntents {

    private static <T extends Activity, E extends Activity> Intent initializeCommonNavIntent(Class<T> component, E activity){
        Intent commonIntent = new Intent(activity, component.getClass());
        commonIntent.setComponent(new ComponentName(component.getPackage().getName(), component.getName()));
        commonIntent.setAction(Intent.ACTION_VIEW);

        return commonIntent;
    }

    public static void navigateToUserDashboard(@Nonnull SignInActivity currentActivity){
        currentActivity.startActivity(initializeCommonNavIntent(DashboardActivity.class, currentActivity));
    }
}
