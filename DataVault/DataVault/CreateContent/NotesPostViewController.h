//
//  NotesPostViewController.h
//  DataVault
//
//  Created by Assassin on 7/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesPostViewController : UIViewController

@property (strong, nonatomic, readwrite) IBOutlet UITextField *_titleView;
@property (strong, nonatomic, readwrite) IBOutlet UITextView *_descriptionView;
@property(strong, nonatomic, readwrite) NSString* DescriptionText;

@property (nonatomic,copy)void (^completionBlock)(NSString *, NSString *);

@end
