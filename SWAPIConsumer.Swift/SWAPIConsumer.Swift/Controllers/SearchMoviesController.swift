//
//  SearchMoviesController.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import UIKit;

class SearchMoviesController : UIViewController, UISearchBarDelegate {
    
    @IBOutlet var _searchResultsTable: UITableView!
    @IBOutlet var _searchBar: UISearchBar!
    
    var ResultsSource : SearchDataSource?;
    lazy var ViewModel : SearchMoviesViewModel? = SearchMoviesViewModel.init(); //When required load the view model into the controller (Resolo
    var Category : SearchCategory?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        setupNavigationBarComponents();
        setupUIComponents();
    }
    
    func setupUIComponents(){
        self.ResultsSource = SearchDataSource(category: Category!);
        self.ResultsSource!.ParentController = self;
        self._searchResultsTable.dataSource = self.ResultsSource;
        self._searchResultsTable.delegate = self.ResultsSource;
        self._searchBar!.delegate = self;
    }
    
    func noSearchResultHandler(){
        DialogueHelper.showDialogWithSimpleMessage(message: "Could not find any search results for query \"\(self._searchBar!.text!)\"");
    }
    
    func emptySearchQuery(){
        SnackbarHelper.showSnackBarWithMessageWithCustomAction(message: "Search bar cannot be empty. Please try again") {
            self._searchBar.becomeFirstResponder();
        };
    }
    func runSearchForQuery(){
        if(self._searchBar!.text == nil){
            emptySearchQuery();
            
            return;
        }
        
        if(self._searchBar!.text!.isEmpty){
            emptySearchQuery();
            
            return;
        }
        
        switch(Category!){
        case .people:
            ViewModel?.searchResultsForPeopleQuery(query: self._searchBar!.text!, actionResults: { (people : PeopleDto?) in
                
                if(people != nil){
                    SnackbarHelper.showSnackBarWithMessage(message: "Found \(people!.results!.count) people");
                    if(people?.count == 0)
                    {
                        self.noSearchResultHandler();
                    }
                    else {
                        //Write the data to the tables Data Source
                        self.ResultsSource?.PeoplesData = people!.results! as Array<PeopleResultDto>;
                        self._searchResultsTable.rowHeight = 150;
                        self._searchResultsTable.reloadData();
                    }
                }
                else {
                    self.noSearchResultHandler();
                }
            });
            break;
            
        case .films:
            ViewModel?.searchResultsForFilmsQuery(query: self._searchBar!.text!, actionResults: { (films: FilmsDto?) in
                if(films != nil){
                    
                    SnackbarHelper.showSnackBarWithMessage(message: "Found \(films!.results!.count) films");
                    if(films?.count == 0)
                    {
                        self.noSearchResultHandler();
                    }
                    else {
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
                        
                        self._searchResultsTable.reloadData();
                    }
                }
                else {
                    self.noSearchResultHandler();
                }
            });
            break;
        case .planets:
            ViewModel?.searchResultsForPlanetsQuery(query: self._searchBar!.text!, actionResults: { (planets: PlanetsDto?) in
                if(planets != nil){
                    SnackbarHelper.showSnackBarWithMessage(message: "Found \(planets!.results!.count) planets");
                    if(planets?.count == 0)
                    {
                        self.noSearchResultHandler();
                    }
                    else {
                        self.ResultsSource?.PlanetsData = planets?.results as! Array<PlanetsResultDto>;
                        self._searchResultsTable.rowHeight = 150;
                        self._searchResultsTable.reloadData();
                    }
                }
                else {
                    self.noSearchResultHandler();
                }
            });
            break;
            
        case .species:
            ViewModel?.searchResultsForSpeciesQuery(query: self._searchBar!.text!, actionResults: { (species: SpeciesDto?) in
                if(species != nil){
                    
                    SnackbarHelper.showSnackBarWithMessage(message: "Found \(species!.results!.count) species");
                    if(species?.count == 0)
                    {
                        self.noSearchResultHandler();
                    }
                    else {
                        self.ResultsSource!.SpeciesData = (species?.results) as! Array<SpeciesResultDto>;
                        self._searchResultsTable.rowHeight = 150;
                        self._searchResultsTable.reloadData();
                    }
                }
                else {
                    self.noSearchResultHandler();
                }
            });
            break;
            
        case .starships:
            ViewModel?.searchResultsForStarShipsQuery(query: self._searchBar!.text!, actionResults: { (ships: StarshipsDto?) in
                if(ships != nil){
                    
                    SnackbarHelper.showSnackBarWithMessage(message: "Found \(ships!.results!.count) starships");
                    if(ships?.count == 0)
                    {
                        self.noSearchResultHandler();
                    }
                    else {
                        self.ResultsSource!.StarshipsData = ships?.results as! Array<StarshipsResultDto>;
                        self._searchResultsTable.rowHeight = 150;
                        self._searchResultsTable.reloadData();
                    }
                }
                else {
                    self.noSearchResultHandler();
                }
            });
            break;
            
        case .vehicles:
            ViewModel?.searchResultsForVehiclesQuery(query: self._searchBar!.text!, actionResults: { (vehicles: VehiclesDto?) in
                if(vehicles != nil){
                    SnackbarHelper.showSnackBarWithMessage(message: "Found \(vehicles!.results!.count) vehicles");
                    if(vehicles?.count == 0)
                    {
                        self.noSearchResultHandler();
                    }
                    else {
                        self.ResultsSource!.VehiclesData = vehicles?.results as! Array<VehiclesResultDto>;
                        self._searchResultsTable.rowHeight = 150;
                        self._searchResultsTable.reloadData();
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
    
    func setupNavigationBarComponents(){
        self.navigationController?.setNavigationBarHidden(true, animated: false);
    }
}
