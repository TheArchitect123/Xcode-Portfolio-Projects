//
//  AppDelegate.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import UIKit;
import CoreData;
import UserNotifications;
import TopViewControllerDetection;

import Toast_Swift;

//Dependency injection
import Resolver;

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?;
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Configure any Default settings
        registerForPushNotifications();
        LoaderHelper.ConfigureLoaderDefaults();
        
        registerServices();
        return true
    }
    
    
    //Output notifications
    func registerForPushNotifications() {
        let notificationOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: notificationOptions) {
            (enabled, error) in
            if(!enabled){
                //Write a log entry here on the Data Model
            }
        }
    }
    
    //Register for Dependency injection
    func registerServices(){
        
//        Resolver.main.register(DatabaseService.Type, name: "DatabaseService") { () -> DatabaseService.Type? in
//            return DatabaseService.init();
//        };
        
    }
    
    
    // MARK: - Notifications Support
    ///Any local notifications received must be flushed as toast message, while the application is in the foreground. There are no background services required in this application
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        ToasterHelper.OpenSimpleToast(UIApplication.shared.findTopViewController()!, "\(notification.alertBody ?? "Received notification from Subsystem")");
    }
}

