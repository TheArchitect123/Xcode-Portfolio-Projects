//
//  DashboardDataSource.swift
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

class DashboardDataSource : NSObject, UITableViewDataSource, UITableViewDelegate, SwipeTableViewCellDelegate {
    
    var ParentController : UIViewController?
    
    //Collections
    var FilmsData: Array<FilmsResultDto>;
    
    //View Model -- Will be used when selecting a film to view details
    lazy var ViewModel: DashboardViewModel = DashboardViewModel.init();
    
    override init() {
        FilmsData = Array<FilmsResultDto>();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FilmsData.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dashboardCell = SwipeTableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "dashboardCell");
        dashboardCell.delegate = self;
        dashboardCell.detailTextLabel?.numberOfLines = 3;
        ConfigureCustomCell(dashboardCell);
        
        // let extraInfo = RenderAccessoryControl();
        
        dashboardCell.textLabel!.text = "\(FilmsData[indexPath.row].title)";
        dashboardCell.detailTextLabel!.text = """
        Director - \(FilmsData[indexPath.row].director)
        Release Date - \(FilmsData[indexPath.row].release_date))
        """;
        
        // dashboardCell.accessoryView = extraInfo;
        //extraInfo.text = "Films: \(FilmsData![indexPath.row].films!.count)";
        
        return dashboardCell;
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
        showDetailInformationAboutItem(indexPath.row);
    }
    
    //Swipe Management
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        let deleteDashboard = SwipeAction.init(style: .default, title: "Delete") { (action: SwipeAction, index: IndexPath) in
            
            //Saves the item to the database
            self.removeSpecifiedFilmFromDb(index.row, tableView: tableView);
        };
        
        deleteDashboard.backgroundColor = UIColor.red;
        
        let moreDetails = SwipeAction.init(style: .default, title: "Details") { (action: SwipeAction, index: IndexPath) in
            self.showDetailInformationAboutItem(indexPath.row);
        };
        
        moreDetails.backgroundColor = ColorHelper.ForestGreen();
        
        return [deleteDashboard, moreDetails];
    }
    
    func removeSpecifiedFilmFromDb(_ index: Int, tableView: UITableView){
        
        //Invoke the view model to remove the film from the db
        LoaderHelper.ShowLoaderWithMessage("Removing \"\(self.FilmsData[index].title)\" from dashboard");
        DispatchQueue.global(qos: .background).async {
            self.ViewModel.deleteItemFromDashboard(movieTitle: self.FilmsData[index].title);
            
            DispatchQueue.main.async {
                self.FilmsData.remove(at: index);
                tableView.reloadData();
                
                LoaderHelper.DismissLoaderWithDefault();
            }
        }
    }
    
    
    func showDetailInformationAboutItem(_ index: Int){
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
    }
}
