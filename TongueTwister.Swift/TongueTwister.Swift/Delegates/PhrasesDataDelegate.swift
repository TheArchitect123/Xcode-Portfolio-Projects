//
//  PhrasesDataDelegate.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 26/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;

internal class PhrasesDataDelegate : NSObject, UITableViewDelegate{
    
    let Items : Array<String> = ["je suis"];
    
    
    //    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //
    //        let action = UIContextualAction(style: .normal, title: "Unfavorite",
    //          handler: { (action, view, completionHandler) in
    //          // Update data source when user taps action
    //
    //          completionHandler(true)
    //        });
    //
    //        action.image = UIImage(named: "MenuIcon")
    //        action.backgroundColor = .red;
    //
    //        return UISwipeActionsConfiguration(actions: [action]);
    //
    //    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SpeechHelper.OutputFrenchText(Items[indexPath.row]);
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: "Unfavorite",
                                        handler: { (action, view, completionHandler) in
                                            // Update data source when user taps action
                                            
                                            completionHandler(true)
        });
        
        action.image = UIImage(named: "MenuIcon")
        action.backgroundColor = .green;
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
}


