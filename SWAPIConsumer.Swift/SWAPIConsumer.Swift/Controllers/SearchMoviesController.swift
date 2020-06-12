//
//  SearchMoviesController.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import UIKit;
import Resolver;

class SearchMoviesController : BaseStdViewController, UISearchBarDelegate {
    
    @IBOutlet var _navigationBar: UINavigationBar!
    @IBOutlet var tableView: UITableView!
    lazy var _searchBar: UISearchBar = UISearchBar.init(frame: CGRect(x: 0,y: 0, width: self.view.ScreenWidth(), height: 50.0));
    
    var ResultsSource : SearchDataSource?;
    @LazyInjected var ViewModel : SearchMoviesViewModel; //When required load the view model into the controller (Resolo
    var Category : SearchCategory?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        setupUIComponents();
        loadItemsFromDashboard();
        configureNavigationItems();
    }
    
    func configureNavigationItems(){
        //self._navigationBar.titleView = _searchBar;
        
        let navItem = UINavigationItem.init(title: "Close");
        navItem.titleView = _searchBar;
        navItem.setLeftBarButton(UIBarButtonItem.init(title: "Close", style: UIBarButtonItem.Style.done, target: self, action: #selector(popPage)), animated: false);
        
        self._navigationBar.setItems([navItem], animated: false);
    }
    
    @objc func popPage(){
        self.dismiss(animated: true, completion: nil);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // self._searchBar.becomeFirstResponder();
    }
    
    func loadItemsFromDashboard(){
        
        ViewModel.getResultsForFilmsFromDashboard(actionResults: { (results: Array<FilmsResultDto>) in
            self.ResultsSource!.FilmsOnDashboard = results.map({$0.title}) as! Array<String>;
        });
        
        self.ViewModel.searchResultsForFilmsRoot(actionResults: { (filmMngr: FilmsDto?) in
            self.ResultsSource!.FilmsRootRef = filmMngr!.results!;
        });
    }
    
    var completionHandler: (() -> Void)?; //When the page disappears, refresh the tab view
    
    override func viewDidDisappear(_ animated: Bool) {
        completionHandler!();
    }
    
    func setupUIComponents(){
        self.ResultsSource = SearchDataSource(category: Category!);
        self.ResultsSource!.ParentController = self;
        self.tableView.dataSource = self.ResultsSource;
        self.tableView.delegate = self.ResultsSource;
        self._searchBar.delegate = self;
    }
    
    
    
    func noSearchResultHandler(){
        DialogueHelper.showDialogWithSimpleMessage(message: "Could not find any search results for query \"\(self._searchBar.text!)\"");
    }
    
    func emptySearchQuery(){
        SnackbarHelper.showSnackBarWithMessageWithCustomAction(message: "Search bar cannot be empty. Please try again") {
            self._searchBar.becomeFirstResponder();
        };
    }
    func runSearchForQuery(){
        if(self._searchBar.text == nil){
            emptySearchQuery();
            
            return;
        }
        
        if(self._searchBar.text!.isEmpty){
            emptySearchQuery();
            
            return;
        }
        
        switch(Category!){
        case .people:
            ViewModel.searchResultsForPeopleQuery(query: self._searchBar.text!, actionResults: { (people : PeopleDto?) in
                
                if(people != nil){
                    if(people?.count == 0)
                    {
                        self.noSearchResultHandler();
                    }
                    else {
                        SnackbarHelper.showSnackBarWithMessage(message: "Found \(people!.results!.count) people");
                        
                        DispatchQueue.main.async {
                           
                            //Write the data to the tables Data Source
                            self.ResultsSource?.PeoplesData = people!.results! as Array<PeopleResultDto>;
                            self.tableView.rowHeight = 150;
                            self.tableView.reloadData();
                        };
                    }
                }
                else {
                    self.noSearchResultHandler();
                }
            });
            break;
            
        case .films:
            ViewModel.searchResultsForFilmsQuery(query: self._searchBar.text!, actionResults: { (films: FilmsDto?) in
                if(films != nil){
                    
                    
                    if(films?.count == 0)
                    {
                        self.noSearchResultHandler();
                    }
                    else {
                        SnackbarHelper.showSnackBarWithMessage(message: "Found \(films!.results!.count) films");
                        
                        //Sort Films by release date
                        self.ResultsSource?.FilmsData = (films?.results!.sorted(by: { (fr: FilmsResultDto, snd: FilmsResultDto) -> Bool in
                            
                            let frFormatted = DateHelper.ConvertToDate(dateString: fr.created);
                            let sndFormatted = DateHelper.ConvertToDate(dateString: snd.created);
                            
                            if(frFormatted != nil && sndFormatted != nil){
                                return frFormatted! <= sndFormatted!;
                            }
                            else {
                                return true;
                            }
                        })) as! Array<FilmsResultDto>;
                        
                        self.tableViewController?.tableView.reloadData();
                    }
                }
                else {
                    self.noSearchResultHandler();
                }
            });
            break;
        case .planets:
            ViewModel.searchResultsForPlanetsQuery(query: self._searchBar.text!, actionResults: { (planets: PlanetsDto?) in
                if(planets != nil){
                    
                    if(planets?.count == 0)
                    {
                        self.noSearchResultHandler();
                    }
                    else {
                        SnackbarHelper.showSnackBarWithMessage(message: "Found \(planets!.results!.count) planets");
                        self.ResultsSource?.PlanetsData = planets?.results as! Array<PlanetsResultDto>;
                        self.tableView.rowHeight = 150;
                        self.tableView.reloadData();
                    }
                }
                else {
                    self.noSearchResultHandler();
                }
            });
            break;
            
        case .species:
            ViewModel.searchResultsForSpeciesQuery(query: self._searchBar.text!, actionResults: { (species: SpeciesDto?) in
                if(species != nil){
                    
                    if(species?.count == 0)
                    {
                        self.noSearchResultHandler();
                    }
                    else {
                        SnackbarHelper.showSnackBarWithMessage(message: "Found \(species!.results!.count) species");
                        self.ResultsSource!.SpeciesData = (species?.results) as! Array<SpeciesResultDto>;
                        self.tableView.rowHeight = 150;
                        self.tableView.reloadData();
                    }
                }
                else {
                    self.noSearchResultHandler();
                }
            });
            break;
            
        case .starships:
            ViewModel.searchResultsForStarShipsQuery(query: self._searchBar.text!, actionResults: { (ships: StarshipsDto?) in
                if(ships != nil){
                    
                    if(ships?.count == 0)
                    {
                        self.noSearchResultHandler();
                    }
                    else {
                        SnackbarHelper.showSnackBarWithMessage(message: "Found \(ships!.results!.count) starships");
                        
                        self.ResultsSource!.StarshipsData = ships?.results as! Array<StarshipsResultDto>;
                        self.tableView.rowHeight = 150;
                        self.tableView.reloadData();
                    }
                }
                else {
                    self.noSearchResultHandler();
                }
            });
            break;
            
        case .vehicles:
            ViewModel.searchResultsForVehiclesQuery(query: self._searchBar.text!, actionResults: { (vehicles: VehiclesDto?) in
                if(vehicles != nil){
                    
                    if(vehicles?.count == 0)
                    {
                        self.noSearchResultHandler();
                    }
                    else {
                        SnackbarHelper.showSnackBarWithMessage(message: "Found \(vehicles!.results!.count) vehicles");
                        self.ResultsSource!.VehiclesData = vehicles?.results as! Array<VehiclesResultDto>;
                        self.tableView.rowHeight = 150;
                        self.tableView.reloadData();
                    }
                }
                else {
                    self.noSearchResultHandler();
                }
            });
            break;
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self._searchBar.resignFirstResponder();
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self._searchBar.resignFirstResponder();
        runSearchForQuery();
    }
}
