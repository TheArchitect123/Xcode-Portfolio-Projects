//
//  NavigationHelper.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 25/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import TopViewControllerDetection;

internal class NavigationHelper {
    internal static func NavigateToCategory(_ category: PhraseCategories) -> Void {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil);
        switch category {
              case PhraseCategories.GeneralConversation:
                
                //Here there needs to be the motion transitions set
                UIApplication.shared.findTopViewController()?.navigationController?.pushViewController(GeneralConversationController.init() as! UIViewController, animated: true);
         
            
            
//              case PhraseCategories.Gardening:
//
//        case PhraseCategories.Dating:
//
//        case PhraseCategories.Emergency:
//
//        case PhraseCategories.Family:
//
//        case PhraseCategories.FirstTimeMeeting:
//
//        case PhraseCategories.Food:
//
//        case PhraseCategories.MathNumbers:
//
//        case PhraseCategories.School:
//
//        case PhraseCategories.Shopping:
//
//        case PhraseCategories.Technology:
//
//        case PhraseCategories.Transport:
//
//        case PhraseCategories.Travel:
//
//        case PhraseCategories.Work:
//
        default:
            break;
        }
    }
    
    internal static func PopPage() {
        UIHelper.ActiveViewController.navigationController?.popViewController(animated: true);
    }
}
