//
//  BaseViewController.m
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "BaseViewController.h"
#import "RootDashboardController.h"

#import <UIKit/UIKit.h>

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addGestureRecognizer:[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popPage)]];
}

-(void) popPage{
    if(![self isMemberOfClass:[RootDashboardController class]]) {
        [self.navigationController popViewControllerAnimated:true];
    }
}

@end
