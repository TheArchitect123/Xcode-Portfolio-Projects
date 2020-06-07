//
//  DashboardCardView.m
//  DataVault
//
//  Created by Assassin on 4/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "DashboardCardView.h"
#import "FriendlyNames.h"
#import "AppInformation.h"

//Categories
#import "MusicLibraryTableViewController.h"
#import "NotesTableViewController.h"
#import "DocumentsTableViewController.h"
#import "PDFsTableViewController.h"
#import "PhotosViewController.h"
#import "EmailsTableViewController.h"

//External Frameworks
#import <UIKit/UIKit.h>
#import <TopViewController.h>

@implementation DashboardCardView

@synthesize _categoryView;
@synthesize _categoryItemsCount;
@synthesize _backgrImageView;
@synthesize _overlayView;
@synthesize _options;

-(instancetype)initWithOptions:(int)options frameOption: (CGRect)frame controllerOption:(UIViewController*)controller
{
    self._mstController = controller;
    self._options = (CategoriesOptions*)options;
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
    
    //Common Targets
    [self addTarget:self action:@selector(runNavigation) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:self._backgrImageView];
    [self addSubview:self._overlayView];
    [self addSubview:self._categoryView];
    [self addSubview:self._categoryItemsCount];
}

///Manage navigations to the category pages, based on the options passed from the card views
-(void) runNavigation {
    
    UIStoryboard* storyRef = [UIStoryboard storyboardWithName:@"SafetyBoxStory" bundle:nil];
    switch((int)self._options){
        case Passwords:
            [self._mstController.navigationController pushViewController:[storyRef instantiateViewControllerWithIdentifier:@"PasswordsTableViewController"] animated:true];
            break;
            
        case Notes:
            [self._mstController.navigationController pushViewController:[storyRef instantiateViewControllerWithIdentifier:@"NotesTableViewController"] animated:true];
            break;
            
        case Documents:
            [self._mstController.navigationController pushViewController:[storyRef instantiateViewControllerWithIdentifier:@"DocumentsTableViewController"] animated:true];
            break;
            
        case PDFs:
            [self._mstController.navigationController pushViewController:[storyRef instantiateViewControllerWithIdentifier:@"PDFsTableViewController"] animated:true];
            break;
            
        case Emails:
            [self._mstController.navigationController pushViewController:[storyRef instantiateViewControllerWithIdentifier:@"EmailsTableViewController"] animated:true];
            break;
            
        case Photos:
            [self._mstController.navigationController pushViewController:[storyRef instantiateViewControllerWithIdentifier:@"PhotosVideosTableViewController"] animated:true];
            break;
            
        case Music:
            [self._mstController.navigationController pushViewController:[storyRef instantiateViewControllerWithIdentifier:@"MusicLibraryTableViewController"] animated:true];
            break;
    }
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
    self.enableRippleBehavior = true;
    self.rippleView.rippleColor = UIColor.orangeColor;
    
    self.clipsToBounds = true;
    self._categoryItemsCount.textColor = UIColor.whiteColor;
    self._categoryItemsCount.font = [UIFont fontWithName:@"Roboto-Light" size:20.0f];
    
    self._categoryView.textColor = UIColor.whiteColor;
    self._categoryView.font = [UIFont fontWithName:@"Roboto-Light" size:26.0f];
    
    //Configure the Responder chain
    self._categoryView.userInteractionEnabled = false;
    self._categoryItemsCount.userInteractionEnabled = false;
    self._backgrImageView.userInteractionEnabled = false;
    self._overlayView.userInteractionEnabled = false;
    
}

-(void) configureCard {
    self.cornerRadius = 10;
}

@end
