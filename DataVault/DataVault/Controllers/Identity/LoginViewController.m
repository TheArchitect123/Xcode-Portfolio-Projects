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

//Material Controls
#import <MaterialComponents/MaterialTextFields.h>
#import <MaterialComponents/MaterialButtons.h>
#import <MaterialComponents/MaterialCards.h>

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initializeBgComponents];
    [self configureInitialValues];
    [self initializeCardControls];
    [self setupUIComponents];
}

-(void)viewDidAppear:(BOOL)animated
{
//    [SnackBarHelper showSnackBarWithCustomBtnActionedMessage:[NSString stringWithFormat:@"Welcome to %s", "SafetyBox"] buttonTitle:@"Dismiss" invokedAction:^(void) {
//        NSLog(@"Output something");
//    }];
    
    [DialogHelper showDialogueWithTopicSimpleMessage:@"Alexander the Great" messageRef:@"HAHAA HAMAAMHAH!" controller:self];
    
}

-(void) setupUIComponents{
    //Draw & Initialize the Controls
    
    //Turn off navigation Bar
    [self.navigationController setNavigationBarHidden:true animated:false];
}

-(void) configureInitialValues {
    
    //Background Image
    self._backgrImageView.image = [UIImage imageNamed:@"mt_bg_14.jpg" inBundle:nil compatibleWithTraitCollection:nil];
    self._backgrImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //Overlay
    self._overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];
}

-(void) initializeCardControls {
    
    //Configure the Card
    self._masterScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(40.0f, 40.0f, [ScreenHelper GetScreenWidth] - 80.0f, [ScreenHelper GetScreenHeight] - 80.0f)];
    
    self._masterCardView = [[MDCCard alloc] initWithFrame:CGRectMake(40.0f, 40.0f, [ScreenHelper GetScreenWidth] - 80.0f, [ScreenHelper GetScreenHeight] - 80.0f)];
                                                                     
    self._masterCardView.cornerRadius = 10.0f;
    self._masterCardView.backgroundColor = UIColor.whiteColor;
    self._masterCardView.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self._masterCardView.layer.borderWidth = 0.4f;
    
    //Configure the Controls on the Card
    ///Username Configuration
    self._usernameField = [[MDCTextField alloc] initWithFrame:CGRectMake(self._masterCardView.bounds.origin.x + 5.0f, self._masterCardView.bounds.size.height * 0.7, (self._masterCardView.bounds.origin.x + self._masterCardView.bounds.size.width - 10.0f), 40.0f)];
    self._usernameField.placeholder = @"Username or Email Address";
    
    ///Password Configuration
    self._passwordField = [[MDCTextField alloc] initWithFrame:CGRectMake(self._masterCardView.bounds.origin.x + 5.0f, self._masterCardView.bounds.size.height * 0.8,(self._masterCardView.bounds.origin.x + self._masterCardView.bounds.size.width - 10.0f), 40.0f)];
    
    self._passwordField.placeholder = @"Password";
    self._passwordField.secureTextEntry = true;
    
    //Add Controls to the heirarchy
    [self._masterScrollView addSubview:self._usernameField];
    [self._masterScrollView addSubview:self._passwordField];
    [self._masterCardView addSubview:self._masterScrollView];
    
    [self.view addSubview:self._masterCardView];
}

-(void) initializeBgComponents {
    self._backgrImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [ScreenHelper GetScreenWidth], [ScreenHelper GetScreenHeight])];
    self._overlayView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [ScreenHelper GetScreenWidth], [ScreenHelper GetScreenHeight])];
    
    [self.view addSubview:self._backgrImageView];
    [self.view addSubview:self._overlayView];
}

-(void) dismissResponderChains{
    [self._usernameField resignFirstResponder];
    [self._passwordField resignFirstResponder];
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissResponderChains];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
