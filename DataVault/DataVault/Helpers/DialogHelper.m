//
//  DialogHelper.m
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

//iOS
#import <Foundation/Foundation.h>

//Custom
#import "DialogHelper.h"

//Material Components
#import <MaterialComponents/MaterialDialogs.h>
#import <MaterialComponents/MaterialDialogs+Theming.h>
#import <MaterialComponents/MaterialActionSheet.h>

@implementation DialogHelper

+(void) showDialogueWithSimpleMessage:(NSString *)message controller: (UIViewController *) controllerRef{
    // Present a modal alert
    MDCAlertController *alertController =
    [MDCAlertController alertControllerWithTitle:@"Test"
                                         message:message];
    
    MDCAlertAction *alertAction =
    [MDCAlertAction actionWithTitle:@"OK"
                            handler:^(MDCAlertAction *action) {
        NSLog(@"OK");
    }];
    
    [alertController addAction:alertAction];
    [controllerRef presentViewController:alertController animated:YES completion:nil];
}

+(void) showDialogueWithTopicSimpleMessage:(NSString *)title messageRef:(NSString *)message controller: (UIViewController *) controllerRef{
    
    // Present a modal alert
    MDCAlertController *alertController =
    [MDCAlertController alertControllerWithTitle:title
                                         message:message];
    
    MDCAlertAction *alertAction =
    [MDCAlertAction actionWithTitle:@"OK"
                            handler:^(MDCAlertAction *action) {
        NSLog(@"OK");
    }];
    
    [alertController addAction:alertAction];
    [controllerRef presentViewController:alertController animated:YES completion:nil];
}

+(void) showActionSheetWithSimpleMessage:(NSString *)message dialogues:(NSMutableArray*) dialogueOptions controller:(UIViewController *)controllerRef {
    MDCActionSheetController *actionSheet =
        [MDCActionSheetController actionSheetControllerWithTitle:@"SafetyBox"
                                                         message:message];
    for(MDCActionSheetAction *action in dialogueOptions){
        [actionSheet addAction:action];
    }
    
    //On Completion, output some sound
    [controllerRef presentViewController:actionSheet animated:YES completion:nil];
}

+(MDCActionSheetAction *) actionSheetCreator: (NSString *) name action:(void (^)())actionOption{
    
    return [MDCActionSheetAction actionWithTitle:name
                                    image:[UIImage imageNamed:@"ic_home"]
                                  handler:actionOption];
}

+(MDCActionSheetAction *) actionSheetCreatorWithImage: (NSString *) name image:(NSString *)imagePath action:(void (^)())actionOption {
    
    return [MDCActionSheetAction actionWithTitle:name
                                    image:[UIImage imageNamed:imagePath]
                                  handler:actionOption];
}

//+(void) showActionSheetWithActionSimpleMessage:(NSString *)message action:(void (^)()) actionMngr controller:(UIViewController *)controllerRef{
//
//    MDCActionSheetController *actionSheet =
//        [MDCActionSheetController actionSheetControllerWithTitle:@"Action sheet"
//                                                         message:@"Secondary line text"];
//    MDCActionSheetAction *homeAction =
//        [MDCActionSheetAction actionWithTitle:@"Home"
//                                        image:[UIImage imageNamed:@"ic_home"]
//                                      handler:nil];
//    MDCActionSheetAction *favoriteAction =
//        [MDCActionSheetAction actionWithTitle:@"Favorite"
//                                        image:[UIImage imageNamed:@"ic_favorite"]
//                                      handler:nil];
//    [actionSheet addAction:homeAction];
//    [actionSheet addAction:favoriteAction];
//    [controllerRef presentViewController:actionSheet animated:YES completion:nil];
//}
@end
