//
//  DashboardCardView.h
//  DataVault
//
//  Created by Assassin on 4/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MaterialComponents/MaterialCards.h>
#import <MaterialComponents/MaterialButtons.h>
#import "Enums.h"

@interface DashboardCardView : MDCCard

@property(nonatomic, readwrite, strong) UILabel* _categoryView;
@property(nonatomic, readwrite, strong) UIImageView* _backgrImageView;
@property(nonatomic, readwrite, strong) UILabel* _categoryItemsCount;

@property(nonatomic, readwrite, strong) UIView* _overlayView;
@property(nonatomic, readwrite, assign) CategoriesOptions* _options;
@property(nonatomic, readwrite, strong) UIViewController* _mstController;

//Constructors
-(instancetype)initWithOptions:(int)options frameOption: (CGRect)frame controllerOption:(UIViewController*)controller;

//Formatters
-(void) setCategoryItems:(int)items;

@end
