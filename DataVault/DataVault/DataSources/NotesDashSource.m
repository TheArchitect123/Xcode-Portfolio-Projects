//
//  NotesDashSource.m
//  DataVault
//
//  Created by Assassin on 5/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

//Apple
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

//Custom
#import "NotesDashSource.h"
#import "NotesPostViewController.h"
#import "NotesDataArray.h"
#import "DatabaseHelper.h"

//Material
#import <MGSwipeTableCell/MGSwipeTableCell.h>
#import <MGSwipeTableCell/MGSwipeButton.h>

//Dto
#import "NotesDto.h"

//Categories
#import "MusicLibraryTableViewController.h"
#import "NotesTableViewController.h"
#import "DocumentsTableViewController.h"
#import "PDFsTableViewController.h"
#import "PhotosViewController.h"
#import "EmailsTableViewController.h"

//Material
#import <MaterialComponents/MaterialRipple.h>

//Helpers
#import "ColorHelper.h"
#import "DialogHelper.h"
#import "SnackBarHelper.h"
#import "DatabaseHelper.h"

@implementation NotesDashSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self._dataArray = [[NSMutableArray alloc] init];
        self._dbHelper = [[DatabaseHelper alloc] init];
    }
    return self;
}

-(NotesDto *) notesMapper:(NSString *) title  description:(NSString *) descriptionRef{
    NotesDto* item = [[NotesDto alloc] init];
    item.title = title;
    item.notesDescription = descriptionRef;
    
    return item;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self._dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MGSwipeTableCell *notesItem = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"notesItem"];
       
       [self configureTableCell:indexPath.row tableCell:&notesItem]; //Configure the Table Cell
       
       //Configure Right Buttons
    //   notesItem.rightSwipeSettings.allowsButtonsWithDifferentWidth = true;
       notesItem.rightSwipeSettings.enableSwipeBounces = true;
       notesItem.rightSwipeSettings.transition = MGSwipeTransition3D;
       notesItem.rightButtons = [self defaultRightButtons:indexPath.row tableView:tableView];
       
       return notesItem;
}

-(NSArray *) defaultRightButtons:(uint) index tableView:(UITableView *) tableViewRef{
    return @[[MGSwipeButton buttonWithTitle:@"View" backgroundColor:[ColorHelper CardDark_ThemBackground] callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
        
        [self openSpecifiedNote:(uint)index tableView:tableViewRef];
        return true;
    }]];
    
//    , [MGSwipeButton buttonWithTitle:@"Delete" backgroundColor:UIColor.redColor callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
//
//        //Check first if the user would like to clear this cache, because this will delete all items of theirs, from the entity
//               [DialogHelper showDialogueWithTopicSimpleMessageAction:@"Remove Document" messageRef:@"This will permanantly delete this item from your local database. Note: This will not affect your data on the cloud" action:(^() {
//
//                   //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
//
//                   [SnackBarHelper showSnackBarWithCustomBtnActionedMessage:[NSString stringWithFormat:@"Removing item \"%@\"", self._dataArray[index].name] buttonTitle:@"Undo" invokedAction:(^(){
//
//                       [DialogHelper showDialogueWithSimpleMessage:@"Rolled back Process" controller:self._parentController];
//                   })];
//               }) controller: self._parentController];
//        return true;
//    }]
}

-(UIImage *) configureCategoryImage:(UIImage *) image{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(60.0f, 60.0f), false, 1.0f);
    [image drawInRect:CGRectMake(0, 0, 60.0f, 60.0f)];
    
    UIImage* imageFromContext = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageFromContext;
}

-(void) configureTableCell:(uint)index tableCell:(UITableViewCell**)cell{
    
    (*cell).textLabel.textColor = UIColor.blackColor;
    (*cell).detailTextLabel.textColor = UIColor.blackColor;
    
    (*cell).textLabel.font = [UIFont fontWithName:@"Roboto-Light" size:25.0f];
    (*cell).detailTextLabel.font = [UIFont fontWithName:@"Roboto-Light" size:20.0f];
    (*cell).backgroundColor = UIColor.whiteColor;
    
    //Accessory Item
    (*cell).accessoryType = UITableViewCellAccessoryNone;
    // (*cell).accessoryView = [self configureAccessoryView:@"(0)" tableCell:(*cell)]; //The Count of the Items must be passed from the controller
    
    (*cell).textLabel.text = self._dataArray[index].title;
    (*cell).detailTextLabel.text = self._dataArray[index].notesDescription;
    
    //Ripple Effects
    //    MDCRippleTouchController *inkTouchController = [[MDCRippleTouchController alloc] initWithView:dashboardItem];
    //    [inkTouchController addRippleToView:dashboardItem];
    
}

-(UILabel *) configureAccessoryView:(NSString *)count tableCell:(UITableViewCell *)cell {
    
    UILabel* accessory = [[UILabel alloc] init];
    accessory.frame = CGRectMake(cell.bounds.size.width + 80.0f, cell.bounds.origin.y + 40.0f, 100.0f, 30.0f);
    accessory.textAlignment = NSTextAlignmentCenter;
    
    accessory.textColor = UIColor.blackColor;
    accessory.font = [UIFont fontWithName:@"Roboto-Light" size:24.0f];
    accessory.text = count;
    
    return accessory;
}

-(void) openSpecifiedNote:(uint)index tableView:(UITableView *)tableViewRef {
    
    //Opens up the modal dialogue of the note, allowing the user to edit it.
    //This will make an upload to the cloud, while also updating the items on the local database
    UIStoryboard* storyRef = [UIStoryboard storyboardWithName:@"SafetyBoxStory" bundle:nil];
    NotesPostViewController *notesPostController = [storyRef instantiateViewControllerWithIdentifier:@"NotesPostViewController"];
    
    notesPostController.DescriptionText = self._dataArray[index].notesDescription;
    notesPostController._titleView.text = self._dataArray[index].title;
    
    notesPostController.completionBlock = ^(NSString *s, NSString *e) {
        [self createNewNote:s description:e];
        
        //After adding the item, make sure to refresh the table
        [tableViewRef reloadData];
    };
    
    [self._parentController.navigationController pushViewController:notesPostController animated:true];
}

-(void) createNewNote:(NSString *)title description:(NSString *) descriptionRef {
    NotesDto* itemDto = [self notesMapper:title description:descriptionRef];
    
    [self._dataArray addObject:itemDto];
    [self._dbHelper createNote:itemDto];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self openSpecifiedNote:(uint)indexPath.row tableView:tableView];
}

@end
