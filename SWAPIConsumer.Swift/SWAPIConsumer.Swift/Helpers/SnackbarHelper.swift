//
//  SnackbarHelper.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation

import TopViewControllerDetection;
//Material
import MaterialComponents.MaterialSnackbar;

class SnackbarHelper{

    static func showSnackBarWithMessage(message: String){

        let snackMessage = MDCSnackbarMessage(text: message);
        snackMessage.text = message;
        snackMessage.buttonTextColor = UIColor.green;
        snackMessage.duration = 1;
        
        let messageAction = MDCSnackbarMessageAction();
        messageAction.title = "DISMISS";
        snackMessage.action = messageAction;
        
        let manager = MDCSnackbarManager()
        manager.setButtonTitleColor(UIColor.green, for: UIControl.State.normal);
        manager.setButtonTitleColor(UIColor.green, for: UIControl.State.highlighted);
        manager.setButtonTitleColor(UIColor.green, for: UIControl.State.selected);
        manager.show(snackMessage);
    }
    
    
    static func showSnackBarWithMessageWithCustomAction(message: String, actionHandler: @escaping () -> Void){

        let snackMessage = MDCSnackbarMessage(text: message);
        snackMessage.text = message;
        snackMessage.duration = 1;
        
        let messageAction = MDCSnackbarMessageAction();
        messageAction.title = "DISMISS";
        messageAction.handler =  (() -> Void)?{
            actionHandler();
        };
        
        snackMessage.action = messageAction;
        
        let manager = MDCSnackbarManager()
        manager.setButtonTitleColor(UIColor.green, for: UIControl.State.normal);
        manager.setButtonTitleColor(UIColor.green, for: UIControl.State.highlighted);
        manager.setButtonTitleColor(UIColor.green, for: UIControl.State.selected);
        manager.show(snackMessage);
    }
}
