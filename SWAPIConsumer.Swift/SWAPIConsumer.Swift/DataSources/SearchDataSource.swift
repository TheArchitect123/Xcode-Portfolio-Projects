//
//  SearchDataSource.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import UIKit;

//Material
import MaterialComponents.MDCActionSheetAction;

import SwipeCellKit;

class SearchDataSource : NSObject, UITableViewDataSource, UITableViewDelegate, SwipeTableViewCellDelegate {
    
    var Category : SearchCategory?;
    var ParentController : UIViewController?
    
    //Collections
    var PeoplesData: Array<PeopleResultDto>;
    var FilmsData : Array<FilmsResultDto>;
    var PlanetsData : Array<PlanetsResultDto>;
    var SpeciesData : Array<SpeciesResultDto>;
    var VehiclesData : Array<VehiclesResultDto>;
    var StarshipsData : Array<StarshipsResultDto>;
    
    //View Model -- Will be used when selecting a film to add to the dashboard
    lazy var ViewModel: SearchMoviesViewModel = SearchMoviesViewModel.init();
    
    init(category: SearchCategory) {
        Category = category;
        
        //Initialize all the Collections
        PeoplesData = Array<PeopleResultDto>();
        FilmsData = Array<FilmsResultDto>();
        PlanetsData = Array<PlanetsResultDto>();
        SpeciesData = Array<SpeciesResultDto>();
        VehiclesData = Array<VehiclesResultDto>();
        StarshipsData = Array<StarshipsResultDto>();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Category! {
        case .films:
            return FilmsData.count;
        case .people:
            return PeoplesData.count;
        case .planets:
            return PlanetsData.count;
        case .species:
            return SpeciesData.count;
        case .starships:
            return StarshipsData.count;
        case .vehicles:
            return VehiclesData.count;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchCell = SwipeTableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "searchCell");
        searchCell.delegate = self;
        searchCell.detailTextLabel?.numberOfLines = 3;
        
        ConfigureCustomCell(searchCell);
        
        //Bind the data
        switch Category! {
        case .people:
            let extraInfo = RenderAccessoryControl();
            
            searchCell.textLabel!.text = "\(PeoplesData[indexPath.row].name)";
            searchCell.detailTextLabel!.text = """
            Eye Colour - \(PeoplesData[indexPath.row].eye_color)
            Hair Colour - \(PeoplesData[indexPath.row].hair_color))
            """;
            
            searchCell.accessoryView = extraInfo;
            extraInfo.text = "Films: \(PeoplesData[indexPath.row].films!.count)";
            break;
            
        case .films:
            let extraInfo = RenderAccessoryControl();
            
            searchCell.textLabel!.text = "\(FilmsData[indexPath.row].title)";
            searchCell.detailTextLabel!.text = """
            Director - \(FilmsData[indexPath.row].director)
            Producer (s) - \(FilmsData[indexPath.row].producer))
            Release Date - \(FilmsData[indexPath.row].release_date)
            """;
            
            
            searchCell.accessoryView = extraInfo;
            extraInfo.text = "Epis: \(FilmsData[indexPath.row].episode_id)";
            
            break;
            
        case .planets:
            
            searchCell.textLabel!.text = "\(PlanetsData[indexPath.row].name)";
            searchCell.detailTextLabel!.text = """
            Terrain - \(PlanetsData[indexPath.row].terrain)
            Population - \(PlanetsData[indexPath.row].population) people
            """;
            
            break;
            
        case .species:
            let extraInfo = RenderAccessoryControl();
            
            searchCell.textLabel!.text = "\(SpeciesData[indexPath.row].name)";
            searchCell.detailTextLabel!.text = """
            Classification - \(SpeciesData[indexPath.row].classification)
            Language - \(SpeciesData[indexPath.row].language)
            """;
            
            searchCell.accessoryView = extraInfo;
            extraInfo.text = "Life: \(SpeciesData[indexPath.row].average_lifespan) years";
            break;
            
        case .starships:
            let extraInfo = RenderAccessoryControl();
            
            searchCell.textLabel!.text = "\(StarshipsData[indexPath.row].name)";
            searchCell.detailTextLabel!.text = """
            Model - \(StarshipsData[indexPath.row].model)
            Manufacturer - \(StarshipsData[indexPath.row].manufacturer)
            Starship Class - \(StarshipsData[indexPath.row].starship_class)
            """;
            
            searchCell.accessoryView = extraInfo;
            extraInfo.text = "Crew: \(StarshipsData[indexPath.row].crew)";
            
            break;
            
        case .vehicles:
            let extraInfo = RenderAccessoryControl();
            
            searchCell.textLabel!.text = "\(VehiclesData[indexPath.row].name)";
            searchCell.detailTextLabel!.text = """
            Model - \(VehiclesData[indexPath.row].model)
            Manufacturer - \(VehiclesData[indexPath.row].manufacturer)
            Cost in Credits - \(VehiclesData[indexPath.row].cost_in_credits)
            """;
            
            searchCell.accessoryView = extraInfo;
            extraInfo.text = "PAXs: \(VehiclesData[indexPath.row].passengers)";
            break;
        }
        
        return searchCell;
    }
    
    func ConfigureCustomCell(_ cell: UITableViewCell){
        cell.textLabel?.font = UIFont.init(name: "Roboto-Light", size: 20.0);
        cell.detailTextLabel?.font = UIFont.init(name: "Roboto-Light", size: 26.0);
        cell.accessoryType = .none;
    }
    
    fileprivate func RenderAccessoryControl() -> UILabel {
        
        let details = UILabel.init();
        details.font = UIFont.init(name: "Roboto-Light", size: 24.0);
        details.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: 100, height: 40));
        
        return details;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        SelectCellLogic(indexPath.row);
    }
    
    //Swipe Management
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        let addOptionTitle = Category! != SearchCategory.films ? "Choose Films" : "Select Film";
        let addToDashboard = SwipeAction.init(style: .default, title: addOptionTitle) { (action: SwipeAction, index: IndexPath) in
            
            //Saves the item to the database
            self.SelectCellLogic(index.row);
        };
        
        addToDashboard.backgroundColor = ColorHelper.DarkThemeBackground();
        
        let moreDetails = SwipeAction.init(style: .default, title: "Details") { (action: SwipeAction, index: IndexPath) in
            self.showDetailInformationAboutItem(indexPath.row);
        };
        
        moreDetails.backgroundColor = ColorHelper.ForestGreen();
        
        return [addToDashboard, moreDetails];
    }
    
    func renderAllFilmsByRoot(){
        //Call all the films (Maximum of 6 records exist on the backend, but there is no api that supports, a different solution (Normally, I would just modify the Api on the backend, to allow for bulk reading & transactions)
        ViewModel.searchResultsForFilmsRoot(actionResults: { (films: FilmsDto?) in
            if(films != nil){
                //Process the results here
                
                //In each of these actions, make sure to check whether the film already exists on the database, and if it does, simply present a dialogue
                let filmActions = NSMutableArray(capacity: 6);
                filmActions.add(MDCActionSheetAction.init(title: films!.results![0].title, image: UIImage.init(named: "Films"), handler: { (e) in
                    
                    //Add the film to the database
                    //This will require this function to be added to the GCD as a background process
                    
                }));
                
                filmActions.add(MDCActionSheetAction.init(title: films!.results![1].title, image: UIImage.init(named: "Films"), handler: { (e) in
                    
                    //Add the film to the database
                    //This will require this function to be added to the GCD as a background process
                }));
                
                filmActions.add(MDCActionSheetAction.init(title: films!.results![2].title, image: UIImage.init(named: "Films"), handler: { (e) in
                    
                    //Add the film to the database
                    //This will require this function to be added to the GCD as a background process
                }));
                
                filmActions.add(MDCActionSheetAction.init(title: films!.results![3].title, image: UIImage.init(named: "Films"), handler: { (e) in
                    
                    //Add the film to the database
                    //This will require this function to be added to the GCD as a background process
                }));
                
                filmActions.add(MDCActionSheetAction.init(title: films!.results![4].title, image: UIImage.init(named: "Films"), handler: { (e) in
                    
                    //Add the film to the database
                    //This will require this function to be added to the GCD as a background process
                }));
                
                filmActions.add(MDCActionSheetAction.init(title: films!.results![5].title, image: UIImage.init(named: "Films"), handler: { (e) in
                    
                    //Add the film to the database
                    //This will require this function to be added to the GCD as a background process
                }));
                
                DialogueHelper.showActionSheetWithSimpleMessage(message: "Choose a film to add to your dashboard", actionBtns: filmActions as! Array<MDCActionSheetAction>);
                LoaderHelper.DismissLoaderWithDefault();
            }
        });
    }
    
    func showDetailInformationAboutItem(_ index: Int){
        switch self.Category! {
        case .people:
            DialogueHelper.showDialogWithTitleSimpleMessage(title: "\(self.PeoplesData[index].name)'s Details", message:
                """
                Actor Details:
                Name - \(self.PeoplesData[index].name)
                Height - \(self.PeoplesData[index].height)
                Mass - \(self.PeoplesData[index].mass)
                Hair Colour - \(self.PeoplesData[index].hair_color)
                Skin Colour - \(self.PeoplesData[index].skin_color)
                Eye Colour - \(self.PeoplesData[index].eye_color)
                Birth Year - \(self.PeoplesData[index].birth_year)
                Gender - \(self.PeoplesData[index].gender)
                """);
            break;
            
        case .films:
            DialogueHelper.showDialogWithSimpleTitleMessageCustomAction(title: "\(self.FilmsData[index].title)'s Details", message:  """
                Film Details:
                Name of Film - \(self.FilmsData[index].title)
                Episode Number - \(self.FilmsData[index].episode_id)
                ------------------------------------------
                Opening Crawl - \"\(self.FilmsData[index].opening_crawl)\"
                
                ------------------------------------------
                Director - \(self.FilmsData[index].director)
                Productor - \(self.FilmsData[index].producer)
                Release Date \(self.FilmsData[index].release_date)
                Actors in film - \(self.FilmsData[index].characters?.count ?? 0)
                """, actionBtn: "Add to Dashboard", actionHandler:{() -> Void in
                    //Invoke the database function on the view model to add the film into the database
                    
            });
            break;
            
        case .planets:
            DialogueHelper.showDialogWithTitleSimpleMessage(title: "\(self.PlanetsData[index].name)'s Details", message:
                """
                Planet Details:
                Planet Name - \(self.PlanetsData[index].name)
                Rotational Period - \(self.PlanetsData[index].rotation_period) hours
                Orbital Period - \(self.PlanetsData[index].orbital_period) days
                Gravity - \(self.PlanetsData[index].gravity)Gs
                Population - \(self.PlanetsData[index].population) people
                Climate - \(self.PlanetsData[index].climate)
                Terrain - \(self.PlanetsData[index].terrain)
                Surface Water - \(self.PlanetsData[index].surface_water)
                Residents - \(self.PlanetsData[index].residents?.count ?? 0)
                Films Played - \(self.PlanetsData[index].films?.count ?? 0)
                """);
            break;
            
        case .species:
            
            DialogueHelper.showDialogWithTitleSimpleMessage(title: "\(self.SpeciesData[index].name)'s Details", message:
                """
                Species Details:
                Species Name - \(self.SpeciesData[index].name)
                Classification - \(self.SpeciesData[index].classification)
                Designation - \(self.SpeciesData[index].designation)
                Average Height - \(self.SpeciesData[index].average_height)cm
                Skin Colours - \(self.SpeciesData[index].skin_colors)
                Hair Colours - \(self.SpeciesData[index].hair_colors)
                Eye Colours - \(self.SpeciesData[index].eye_colors)
                Average Lifespan - \(self.SpeciesData[index].average_lifespan) years
                Language - \(self.SpeciesData[index].language)
                """);
            
            break;
        case .starships:
            DialogueHelper.showDialogWithTitleSimpleMessage(title: "\(self.StarshipsData[index].name)'s Details", message:
                """
                Starship Details:
                Name of Starship - \(self.StarshipsData[index].name)
                Model - \(self.StarshipsData[index].model)
                Manufacturer - \(self.StarshipsData[index].manufacturer)
                Cost - \(self.StarshipsData[index].cost_in_credits) Galactic Credits
                Length - \(self.StarshipsData[index].length)m
                Max Atmospheric Speed - \(self.StarshipsData[index].max_atmosphering_speed)
                Number of Crew - \(self.StarshipsData[index].crew) people
                Passengers - \(self.StarshipsData[index].passengers) people
                Cargo Capacity - \(self.StarshipsData[index].cargo_capacity)kg
                Consumables - \(self.StarshipsData[index].consumables)
                Hyperdrive Rating - \(self.StarshipsData[index].hyperdrive_rating)
                MGLT - \(self.StarshipsData[index].MGLT)
                Starship Class - \(self.StarshipsData[index].starship_class)
                Pilots - \(self.StarshipsData[index].pilots?.count ?? 0)
                Films Starred in - \(self.StarshipsData[index].films?.count ?? 0)
                """);
            break;
            
        case .vehicles:
            
            DialogueHelper.showDialogWithTitleSimpleMessage(title: "\(self.VehiclesData[index].name)'s Details", message:
                """
                Vehicle Details:
                Name of Vehicle - \(self.VehiclesData[index].name)
                Model - \(self.VehiclesData[index].model)
                Manufacturer - \(self.VehiclesData[index].manufacturer)
                Cost - \(self.VehiclesData[index].cost_in_credits) Galactic Credits
                Length - \(self.VehiclesData[index].length)m
                Max Atmospheric Speed - \(self.VehiclesData[index].max_atmosphering_speed)
                Number of Crew - \(self.VehiclesData[index].crew) people
                Passengers - \(self.VehiclesData[index].passengers) people
                Cargo Capacity - \(self.VehiclesData[index].cargo_capacity)kg
                Consumables - \(self.VehiclesData[index].consumables)
                Pilots - \(self.VehiclesData[index].pilots?.count ?? 0)
                Films Starred in - \(self.VehiclesData[index].films?.count ?? 0)
                """);
            break;
        }
    }
    
    //Add a movie from the search list
    
    func SelectCellLogic(_ index: Int){
        if(Category! == SearchCategory.films){
            self.ParentController?.dismiss(animated: true, completion: nil);
        }
        else {
            renderAllFilmsByRoot();
        }
    }
}
