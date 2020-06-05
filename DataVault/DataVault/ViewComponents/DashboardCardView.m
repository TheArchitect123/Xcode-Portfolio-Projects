//
//  DashboardCardView.m
//  DataVault
//
//  Created by Assassin on 4/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "DashboardCardView.h"
#import <UIKit/UIKit.h>
#import "FriendlyNames.h"

@implementation DashboardCardView

@synthesize _categoryView;
@synthesize _categoryItemsCount;
@synthesize _backgrImageView;
@synthesize _options;

-(instancetype)initWithOptions:(int)options frameOption: (CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeComponents];
        [self configureCard];
        [self configureInitialValues:options];
        [self configureComponents];
    }
    return self;
}

-(void) initializeComponents {
    self._categoryView = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.origin.x + 10.0f, self.bounds.size.height - 50.0f, self.bounds.size.width - 20.0f, 40.0f)];
    self._categoryItemsCount = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 60.0f, self.bounds.origin.y + 10.0f, 60.0f, 60.0f)];

    self._backgrImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height)];
    self._overlayView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height)];
    
    [self addSubview:self._backgrImageView];
    [self addSubview:self._overlayView];
    [self addSubview:self._categoryView];
    [self addSubview:self._categoryItemsCount];
}

-(void) configureInitialValues:(int)catOptions {
    self._categoryView.text = [FriendlyNames getCategoryNameForOption:(CategoriesOptions)catOptions];

    //Background Image
    self._backgrImageView.image = [UIImage imageNamed:[FriendlyNames getCategoryBackgroundForOption:(CategoriesOptions)catOptions] inBundle:NULL compatibleWithTraitCollection:NULL];
    self._backgrImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //Overlay
    self._overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];
}

-(void) setCategoryItems:(int)items{
    self._categoryItemsCount.text = [NSString stringWithFormat:@"(%i) >", items];
}

-(void) configureComponents{
    self.rippleView.activeRippleColor = UIColor.orangeColor;
    self.clipsToBounds = true;
    
    self._categoryItemsCount.textColor = UIColor.whiteColor;
    self._categoryItemsCount.font = [UIFont fontWithName:@"Roboto-Light" size:20.0f];
    
    self._categoryView.textColor = UIColor.whiteColor;
    self._categoryView.font = [UIFont fontWithName:@"Roboto-Light" size:26.0f];
}

-(void) configureCard {
    self.cornerRadius = 10;
}

@end
