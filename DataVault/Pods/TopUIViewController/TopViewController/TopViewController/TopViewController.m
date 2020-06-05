//
//  TopViewController.m
//  TopViewController
//
//  Created by LeonJing on 21/11/2017.
//  Copyright © 2017 LeonJing. All rights reserved.
//

#import "TopViewController.h"


UIWindow * _KeyWindow()
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow ?: [UIApplication sharedApplication].delegate.window;
    
    NSCAssert(keyWindow, @"AppDelegate 的 window 属性为 nil.");
    
    return keyWindow;
}


UIViewController* _TopVisibleViewController(UIViewController* vc)
{
    if ([vc isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabBarController = (UITabBarController *)vc;
        return _TopVisibleViewController(tabBarController.selectedViewController);
    }
    else if ([vc isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *navigationController = (UINavigationController *)vc;
        return _TopVisibleViewController(navigationController.visibleViewController);
    }
    else if (vc.presentedViewController)
    {
        return _TopVisibleViewController(vc.presentedViewController);
    }
    else if (vc.childViewControllers.count > 0)
    {
        return _TopVisibleViewController(vc.childViewControllers.lastObject);
    }
    
    return vc;
}

UIViewController * TopViewController(void)
{
    UIViewController *rootVC = _KeyWindow().rootViewController;
    return _TopVisibleViewController(rootVC);
}

UIViewController * RootViewController(void)
{
    return _KeyWindow().rootViewController;
}
