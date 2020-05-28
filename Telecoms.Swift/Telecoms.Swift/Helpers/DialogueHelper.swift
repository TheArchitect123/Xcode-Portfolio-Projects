//
//  DialogueHelper.swift
//  Telecoms.Swift
//
//  Created by Assassin on 27/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import Dialog;

class DialogueHelper {
    
    static func OpenSimpleMessageDialog(_ controller: UIViewController, title: String, message: String, _completionHandler: @escaping () -> Void){
        let customAction = Dialog.alert(title: title, message: message)
        customAction.addAction(title: "Done", handler: { (dialog) -> (Void) in
            dialog.dismiss()
            
            if(_completionHandler != nil) {
                _completionHandler();
            }
        })
        customAction.show(in: controller)
    }
    
    static func OpenSimpleMessageImageDialog(_ controller: UIViewController, title: String, message: String, imagePath: String, _completionHandler: @escaping () -> Void){
        
        let imageIcon = "http://openweathermap.org/img/wn/\(imagePath).png"
        let customAction = Dialog.alert(title: title, message: message, image: UIImage.init(contentsOfFile: imageIcon));
        customAction.rightToolStyle = { (button) in
            button.setImage(UIImage.init(contentsOfFile: imageIcon), for: .normal)
            button.tintColor = .lightGray
            return true
        }
        
        customAction.addAction(title: "Add a Button", handler: { (dialog) -> (Void) in
            dialog.addAction(title: "Remove the Last Button", handler: { (dia) -> (Void) in
                dialog.removeAction(at: dia.actions.count - 1)
            })
        })
        
        customAction.show(in: controller);
    }

    
}
