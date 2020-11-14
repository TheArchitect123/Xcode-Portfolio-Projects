package ui.activities;

import android.content.ComponentName;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import com.dg.swapiconsumer.R;
import ui.view_bindings.DashboardBindings;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.snackbar.Snackbar;

import butterknife.BindView;
import view_models.pages.DashboardViewModel;

public class DashboardActivity extends AppCompatActivity {
    //The view model will contain a reference to the view model, on initialization
    DashboardViewModel viewModel;

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {

        switch(item.getItemId()){
            case 0: //Dashboard Items

                //Render the dashboard elements, and refresh the items from the database
                break;
            default: //Settings Items
                break;
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    protected void onPause() {
        super.onPause();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        this.setSupportActionBar(viewModel.getBindings().getDashboardToolbar());
    }
}