//
//  DashboardCardView.h
//  DataVault
//
//  Created by Assassin on 4/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MaterialComponents/MaterialCards.h>
#import "Enums.h"

@interface DashboardCardView : MDCCard

@property(nonatomic, strong) UILabel* _categoryView;
@property(nonatomic, strong) UIImageView* _backgrImageView;
@property(nonatomic, strong) UILabel* _categoryItemsCount;

@property(nonatomic, strong) UIView* _overlayView;
@property(nonatomic, readwrite) CategoriesOptions* _options;

//Constructors
-(instancetype)initWithOptions:(int)options frameOption: (CGRect)frame;

//Formatters
-(void) setCategoryItems:(int)items;

@end
