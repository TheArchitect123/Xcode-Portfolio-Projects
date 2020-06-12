//
//  DashboardController.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import UIKit;
import Resolver;

//Material Components
import MaterialComponents;

class DashboardController : BaseViewController{
    
    //Widgets
    var _floatingBtn : MDCFloatingButton?
    @LazyInjected var ViewModel : DashboardViewModel;
    var ResultsSource : DashboardDataSource?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
      //  welcomeMessage();
        setupUIComponents();
        configureRefresh();
    }
    
    func setupUIComponents(){
        self.ResultsSource = DashboardDataSource();
        self.ResultsSource!.ParentController = self;
        self.tableView.dataSource = self.ResultsSource;
        self.tableView.delegate = self.ResultsSource;
        self.tableView.rowHeight = 150.0;
    }
    
    func welcomeMessage(){
        DialogueHelper.showDialogWithSimpleMessage(message: "Welcome to \(AppInformation.ApplicationName). Created by \(AppInformation.AuthorName)");
    }
    
    func configureRefresh(){
        let refreshMngr = UIRefreshControl.init(frame: CGRect(x: 0, y: 0, width: self.view.ScreenWidth(), height: self.view.ScreenHeight()));
        refreshMngr.addTarget(self, action: #selector(updateTableViewWithFilms), for: UIControl.Event.valueChanged);
        
        self.tableView.refreshControl = refreshMngr;
    }
    
    @objc func updateTableViewWithFilms(){
        self.ViewModel.getResultsForFilmsFromDb(actionResults: { (film: Array<FilmsResultDto>?) in
            self.ResultsSource?.FilmsData = film as! Array<FilmsResultDto>;
            self.tableView.refreshControl?.endRefreshing();
            self.tableView.reloadData();
        });
    }
}
