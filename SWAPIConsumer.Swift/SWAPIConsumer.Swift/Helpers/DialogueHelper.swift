//
//  DialogueHelper.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import TopViewControllerDetection;

//Material
import MaterialComponents.MaterialDialogs;

class DialogueHelper{
    static func showDialogWithSimpleMessage(message: String){
        // Present a modal alert
        let matDialogue = MDCAlertController(title: AppInformation.ApplicationName, message: message)
        let matAction = MDCAlertAction(title:"OK");
        matDialogue.addAction(matAction)

        UIApplication.shared.findTopViewController()!.present(matDialogue, animated:true, completion:nil);
    }
    
    static func showDialogWithTitleSimpleMessage(title: String, message: String){
          // Present a modal alert
          let matDialogue = MDCAlertController(title: title, message: message)
          let matAction = MDCAlertAction(title:"OK");
          matDialogue.addAction(matAction)

          UIApplication.shared.findTopViewController()!.present(matDialogue, animated:true, completion:nil);
      }
    
    static func showDialogWithSimpleMessageCustomAction(message: String, actionBtn: String, actionHandler:@escaping () -> Void){
        // Present a modal alert
        let matDialogue = MDCAlertController(title: AppInformation.ApplicationName, message: message)
        let matAction = MDCAlertAction.init(title: actionBtn, handler: { (e) in
            actionHandler();
        });
        
        matDialogue.addAction(matAction)
        UIApplication.shared.findTopViewController()!.present(matDialogue, animated:true, completion:nil);
    }
    
    static func showDialogWithSimpleTitleMessageCustomAction(title: String, message: String, actionBtn: String, actionHandler:@escaping () -> Void){
          // Present a modal alert
          let matDialogue = MDCAlertController(title: title, message: message)
          let matAction = MDCAlertAction.init(title: actionBtn, handler: { (e) in
              actionHandler();
          });
          
          matDialogue.addAction(matAction)
          UIApplication.shared.findTopViewController()!.present(matDialogue, animated:true, completion:nil);
      }
    
    static func showActionSheetWithSimpleMessage(message: String, actionBtns: Array<MDCActionSheetAction>) {
        let actionSheet = MDCActionSheetController.init(title: AppInformation.ApplicationName, message: message);
        
        for action in actionBtns {
            actionSheet.addAction(action);
        }
        
        UIApplication.shared.findTopViewController()!.present(actionSheet, animated: true, completion: nil);
    }
    
    static func showActionSheetTitleWithSimpleMessage(title: String, message: String, actionBtns: Array<MDCActionSheetAction>) {
        let actionSheet = MDCActionSheetController.init(title: title, message: message);
        
        for action in actionBtns {
            actionSheet.addAction(action);
        }
        
        UIApplication.shared.findTopViewController()!.present(actionSheet, animated: true, completion: nil);
    }
}
