//
//  LoginViewController.h
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <UIKit/UIKit.h>

//Material Controls
#import <MaterialComponents/MaterialTextFields.h>
#import <MaterialComponents/MaterialButtons.h>
#import <MaterialComponents/MaterialCards.h>

@interface LoginViewController : UIViewController

@property(nonatomic, strong, readwrite) UIScrollView* _masterScrollView;
@property(nonatomic, strong, readwrite) MDCCard* _masterCardView;

//Widgets
@property(nonatomic, strong, readwrite) MDCTextField* _usernameField;
@property(nonatomic, strong, readwrite) MDCTextField* _passwordField;
@property(nonatomic, strong, readwrite) MDCButton* _confirmedLoginBtn;

//Scenery
@property(nonatomic, strong, readwrite) UIView* _overlayView;
@property(nonatomic, readwrite, strong) UIImageView* _backgrImageView;

@end

