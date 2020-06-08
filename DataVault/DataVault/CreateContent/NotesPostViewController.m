//
//  NotesPostViewController.m
//  DataVault
//
//  Created by Assassin on 7/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "NotesPostViewController.h"

//Helpers
#import "ScreenHelper.h"
#import "SnackBarHelper.h"

@interface NotesPostViewController ()

@end

@implementation NotesPostViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupUIComponents];
    [self setNavigationBarComponents];
    
    [self.view addGestureRecognizer:[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popPage)]];
}

-(void) popPage{
    [self.navigationController popViewControllerAnimated:true];
}

-(void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    [self popPage];
}

-(void) recreateViewsRequiredForConstraints{
    
    //[self setupConstraints];
}

-(void) commitNoteToDB{
    //Check if the textfield is empty or not
    if(self._descriptionView.text != @"" && self._titleView.text != @""){
        //If the text is not empty, make sure to invoke the view model helper class, to add
        //Invoke a handler here
        [self.navigationController popViewControllerAnimated:true];
        [SnackBarHelper showSnackBarWithMessage:@"Creating note"];
        
        self.completionBlock(self._titleView.text, self._descriptionView.text);
    }
    else {
        [SnackBarHelper showSnackBarWithMessage:@"Error: Missing description and/or title"];
    }
}

//-(void) enableUINotifications{
//    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(recreateViewsRequiredForConstraints) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
//}
//
//-(void) disposeUINotifications{
//    [NSNotificationCenter.defaultCenter removeObserver:self name:UIKeyboardDidHideNotification object:nil];
//    [NSNotificationCenter.defaultCenter removeObserver:nil name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
//}
//
//-(void) viewWillAppear:(BOOL)animated{
//    [self enableUINotifications];
//}
//
//-(void) viewWillDisappear:(BOOL)animated{
//
//    [self disposeUINotifications];
//}

//-(void) setupConstraints{
//    self._descriptionView.frame = CGRectMake(self.view.bounds.origin.x, self.navigationController.navigationBar.bounds.size.height, self.view.bounds.size.width, [ScreenHelper GetScreenHeight] - self.navigationController.navigationBar.bounds.size.height);
//}

-(void) setupUIComponents {
    
    NSLog([NSString stringWithFormat:@"Test String: %@", self._titleView.text]);
    NSLog([NSString stringWithFormat:@"Address: %@", self._descriptionView]);
    self._descriptionView.returnKeyType = UIReturnKeyDefault;
    self._descriptionView.textColor = UIColor.blackColor;
    self._descriptionView.backgroundColor = UIColor.whiteColor;
    self._descriptionView.font = [UIFont fontWithName:@"Roboto-Light" size:20.0f];
    
    if(self.DescriptionText != nil) {
        self._descriptionView.text = self.DescriptionText;
    }
    else {
        self._descriptionView.text = @"My note goes here...";
    }
    [self._descriptionView becomeFirstResponder];
}

-(void) setNavigationBarComponents{
    self.navigationController.navigationBar.backgroundColor = UIColor.lightGrayColor;
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(commitNoteToDB)]];
}

@end
