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
        switch category {
        case PhraseCategories.GeneralConversation:
             UIApplication.shared.findTopViewController()?.navigationController?.pushViewController(GeneralConversationController.init(), animated: true);
            
        case PhraseCategories.Gardening:
            UIApplication.shared.findTopViewController()?.navigationController?.pushViewController(GardeningController.init(), animated: true);
            
        case PhraseCategories.Dating:
            UIApplication.shared.findTopViewController()?.navigationController?.pushViewController(DatingController.init() as UIViewController, animated: true);
            
        case PhraseCategories.Emergency:
            UIApplication.shared.findTopViewController()?.navigationController?.pushViewController(EmergencyController.init() as UIViewController, animated: true);
            
        case PhraseCategories.Family:
            UIApplication.shared.findTopViewController()?.navigationController?.pushViewController(FamilyController.init() as UIViewController, animated: true);
            
        case PhraseCategories.FirstTimeMeeting:
            UIApplication.shared.findTopViewController()?.navigationController?.pushViewController(FirstMeetingController.init() as UIViewController, animated: true);
            
        case PhraseCategories.Food:
            UIApplication.shared.findTopViewController()?.navigationController?.pushViewController(FoodController.init() as UIViewController, animated: true);
            
        case PhraseCategories.MathNumbers:
            UIApplication.shared.findTopViewController()?.navigationController?.pushViewController(MathNumbersController.init() as UIViewController, animated: true);
            
        case PhraseCategories.School:
            UIApplication.shared.findTopViewController()?.navigationController?.pushViewController(SchoolController.init() as UIViewController, animated: true);
            
        case PhraseCategories.Shopping:
            UIApplication.shared.findTopViewController()?.navigationController?.pushViewController(ShoppingController.init() as UIViewController, animated: true);
            
        case PhraseCategories.Technology:
            UIApplication.shared.findTopViewController()?.navigationController?.pushViewController(TechnologyController.init() as UIViewController, animated: true);
            
        case PhraseCategories.Transport:
            UIApplication.shared.findTopViewController()?.navigationController?.pushViewController(TransportController.init() as UIViewController, animated: true);
            
        case PhraseCategories.Travel:
            UIApplication.shared.findTopViewController()?.navigationController?.pushViewController(TravelController.init() as UIViewController, animated: true);
            
        case PhraseCategories.Work:
            UIApplication.shared.findTopViewController()?.navigationController?.pushViewController(WorkController.init() as UIViewController, animated: true);
        }
    }
    
    internal static func PopPage() {
        UIHelper.ActiveViewController.navigationController?.popViewController(animated: true);
    }
}
