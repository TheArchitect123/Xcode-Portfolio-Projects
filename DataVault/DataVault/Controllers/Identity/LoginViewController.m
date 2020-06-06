//
//  LoginViewController.m
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "LoginViewController.h"
#import "ScreenHelper.h"
#import "AppInformation.h"


//Helpers
#import "SnackBarHelper.h"
#import "DialogHelper.h"
#import "ColorHelper.h"

//Material Controls
#import <MaterialComponents/MaterialTextFields.h>
#import <MaterialComponents/MaterialTextControls+OutlinedTextFields.h>
#import <MaterialComponents/MaterialButtons.h>
#import <MaterialComponents/MaterialCards.h>

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeBgComponents];
    [self initializeCardControls];
    [self setupUIComponents];
    
    //Notifications
   // [self registerForKeyboardNotifications];
}

-(void)viewDidAppear:(BOOL)animated
{
    //    [SnackBarHelper showSnackBarWithCustomBtnActionedMessage:[NSString stringWithFormat:@"Welcome to %s", "SafetyBox"] buttonTitle:@"Dismiss" invokedAction:^(void) {
    //        NSLog(@"Output something");
    //    }];
    
    //    [DialogHelper showDialogueWithTopicSimpleMessage:@"Alexander the Great" messageRef:@"HAHAA HAMAAMHAH!" controller:self];
    
    // [DialogHelper showActionSheetWithSimpleMessage:@"Alexander the Great" controller:self];
    
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardPopup:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDisappears:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

-(void) keyboardPopup:(NSNotification*)aNotification{
    
    //When keyboard emerges, make sure to adjust the content inset of the keyboard element

    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self._masterScrollView.contentInset = contentInsets;
    self._masterScrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self._usernameField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0,  self._usernameField.frame.origin.y - kbSize.height);
        [self._masterScrollView setContentOffset:scrollPoint animated:YES];
    }
}

-(void) keyboardDisappears:(NSNotification*)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self._masterScrollView.contentInset = contentInsets;
    self._masterScrollView.scrollIndicatorInsets = contentInsets;
}

-(void) setupUIComponents{
    //Draw & Initialize the Controls
    
    //Turn off navigation Bar
    [self.navigationController setNavigationBarHidden:true animated:false];
}

-(void) initializeCardControls {
    
    //Configure the Card
    self._masterScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(40.0f, 40.0f, [ScreenHelper GetScreenWidth] - 80.0f, [ScreenHelper GetScreenHeight] - 80.0f)];
    
    //Configure the Controls on the Card
    ///Username Configuration
    double commonX = (self._masterScrollView.bounds.origin.x + 5.0f);
    self._usernameField = [[MDCTextField alloc] initWithFrame:CGRectMake(self._masterScrollView.bounds.origin.x + 5.0f, self._masterScrollView.bounds.size.height * 0.4, commonX - self._masterScrollView.bounds.size.width - 10.0f, 60.0f)];
    self._usernameField.placeholder = @"Username or Email Address";
    [self._usernameField sizeToFit];
    
    ///Password Configuration
    self._passwordField = [[MDCTextField alloc] initWithFrame:CGRectMake(self._masterScrollView.bounds.origin.x + 5.0f, self._masterScrollView.bounds.size.height * 0.5, commonX - self._masterScrollView.bounds.size.width - 10.0f, 40.0f)];
    
    self._passwordField.placeholder = @"Password";
    self._passwordField.secureTextEntry = true;
    
    //Add Controls to the heirarchy
    //[self._masterScrollView addSubview:self._usernameField];
  //  [self._masterScrollView addSubview:self._passwordField];
    
    [self.view addSubview:self._usernameField];
}

-(void) initializeBgComponents {
    self.view.backgroundColor = [ColorHelper CardDark_ThemBackground];
}

-(void) dismissResponderChains{
    [self._usernameField resignFirstResponder];
    [self._passwordField resignFirstResponder];
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissResponderChains];
}

@end
