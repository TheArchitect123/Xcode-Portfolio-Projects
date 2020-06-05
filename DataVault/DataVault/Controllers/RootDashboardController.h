//
//  RootDashboardController.h
//  DataVault
//
//  Created by Assassin on 4/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashboardCardView.h"
#import <MaterialComponents/MaterialNavigationDrawer.h>

@interface RootDashboardController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *_dashScrollView;

//Cards
@property(nonatomic, strong, readwrite) DashboardCardView* _notesCard;
@property(nonatomic, strong, readwrite) DashboardCardView* _pdfsCard;
@property(nonatomic, strong, readwrite) DashboardCardView* _passwordsCard;
@property(nonatomic, strong, readwrite) DashboardCardView* _photosCard;
@property(nonatomic, strong, readwrite) DashboardCardView* _documentsCard;
@property(nonatomic, strong, readwrite) DashboardCardView* _musicCard;
@property(nonatomic, strong, readwrite) DashboardCardView* _emailsCard;


//Material Components
@property(nonatomic, strong, readwrite) MDCBottomDrawerViewController* _bottomDrawer;


@end
