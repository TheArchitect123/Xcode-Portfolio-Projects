package view_models.pages;

import ui.view_bindings.DashboardBindings;

public class DashboardViewModel {
    private final DashboardBindings _bindings;
    public DashboardViewModel(DashboardBindings bindings){
        _bindings = bindings;
    }

    public DashboardBindings getBindings(){
        return _bindings;
    }
}
