//
//  DashboardController.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import UIKit;
import CoreGraphics;
import Resolver;

//Material Components
import MaterialComponents;

class DashboardController : BaseViewController{
    
    //Widgets
    var _floatingBtn : MDCFloatingButton?
    @LazyInjected var ViewModel : DashboardViewModel;
    var ResultsSource : DashboardDataSource?;
    var InstructionsView: UILabel?
    var deletionHandler:(() -> Void)?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
      //  welcomeMessage();
        setupUIComponents();
        configureRefresh();
        createDefaultInstructions();
    }
    
    override func viewDidLayoutSubviews() {
        self.InstructionsView?.frame = CGRect.init(x: 10, y: -15, width: self.view.ScreenWidth() - 20, height: self.view.ScreenHeight());
    }
    
    func createDefaultInstructions(){
        self.InstructionsView = UILabel.init(frame: CGRect.init(x: 10, y: -15, width: self.view.ScreenWidth() - 20, height: self.view.ScreenHeight()));
        
        self.InstructionsView!.text = "Add a Star Wars Film on your dashboard by starting a search";
        self.InstructionsView!.font = UIFont.init(name: "Roboto-Light", size: 26.0);
        self.InstructionsView!.numberOfLines = 0;
        self.InstructionsView!.textAlignment = .justified;
        self.view.addSubview(self.InstructionsView!);
        self.view.bringSubviewToFront(self.InstructionsView!);
    }
    
    func setupUIComponents(){
        self.ResultsSource = DashboardDataSource();
        self.ResultsSource!.ParentController = self;
        
        self.ResultsSource!.deletionHandler = {() -> Void in
            self.deletionHandler!();  
        };
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
            
            if(film?.count != 0){
                self.InstructionsView?.isHidden = true;
            }
            else {
                //Show the default text
                self.InstructionsView?.isHidden = false;
            }
        });
    }
}
