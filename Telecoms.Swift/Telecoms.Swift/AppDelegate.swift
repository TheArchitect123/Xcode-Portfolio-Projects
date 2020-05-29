//
//  AppDelegate.swift
//  Telecoms.Swift
//
//  Created by Assassin on 27/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import UIKit;
import UserNotifications;
import DropDown;

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    static var standard: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var orientationLock = UIInterfaceOrientationMask.all
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return self.orientationLock
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AlarmClockHelper.StartWeatherPeriodicService();
        LoaderHelper.ConfigureLoaderDefaults();
        RegisterForNotifications();
        DropDown.startListeningToKeyboard();
        
        return true
    }
    
//    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//
//        let windowCheck = self.window?.rootViewController?.presentedViewController is CityDetailViewController || self.window?.rootViewController?.presentedViewController is CityDetailsBottomDrawerController;
//
//        if(windowCheck) {
//            return UIInterfaceOrientationMask.portrait
//        } else {
//            return UIInterfaceOrientationMask.all
//        }
//    }
    
    // MARK: On Application Lifecycle Changes, such as background or foreground state changes, the periodic service responsible for retrieving and updating the app's database, of weather information will be started or stopped. This will help to be more efficient with the api calls.
    func applicationWillTerminate(_ application: UIApplication) {
        AlarmClockHelper.StopWeatherPeriodicService();
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        AlarmClockHelper.StopWeatherPeriodicService();
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        AlarmClockHelper.StartWeatherPeriodicService();
    }
    
    func RegisterForNotifications() {
        let notificationOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: notificationOptions) {
            (enabled, error) in
            if(!enabled){
                //Write a log entry here on the Data Model
            }
        }
    }
}

