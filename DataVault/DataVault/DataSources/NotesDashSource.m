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

//Dto
#import "NotesDto.h"

//Categories
#import "MusicLibraryTableViewController.h"
#import "NotesTableViewController.h"
#import "DocumentsTableViewController.h"
#import "PDFsTableViewController.h"
#import "PhotosVideosTableViewController.h"
#import "EmailsTableViewController.h"

//Material
#import <MaterialComponents/MaterialRipple.h>

//Helpers
#import "ColorHelper.h"
#import "DialogHelper.h"
#import "SnackBarHelper.h"

@implementation NotesDashSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self._dataArray = [[NSMutableArray alloc] init];
        [self._dataArray addObject:[self notesMapper:@"Sample note" description:@"this is a very long description labeled, write here, amongst the notes"]];
        [self._dataArray addObject:[self notesMapper:@"Broken note" description:@"sample description"]];
        [self._dataArray addObject:[self notesMapper:@"MAHAHAAH!" description:@"this is another sample description"]];
    }
    return self;
}

-(NotesDto *) notesMapper:(NSString *) title  description:(NSString *) descriptionRef{
    NotesDto* item = [[NotesDto alloc] init];
    item.Title = title;
    item.Description = descriptionRef;
    
    return item;
}
         
         

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self._dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *notesItem = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"noteItem"];
    
    [self configureTableCell:indexPath.row tableCell:&notesItem]; //Configure the Table Cell
    return notesItem;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Remove all items from the categories' cache
    UITableViewRowAction* delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                                      title:@"Delete"
                                                                    handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        //Check first if the user would like to clear this cache, because this will delete all items of theirs, from the entity
        [DialogHelper showDialogueWithTopicSimpleMessageAction:@"Remove Note" messageRef:@"This will permanantly delete this item from your local database. Note: This will not affect your data on the cloud" action:(^() {
            
            //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
            
            [SnackBarHelper showSnackBarWithCustomBtnActionedMessage:[NSString stringWithFormat:@"Removing item \"%@\"", @"SAMPLE"] buttonTitle:@"Undo" invokedAction:(^(){
                
                [DialogHelper showDialogueWithSimpleMessage:@"Rolled back Process" controller:self._parentController];
            })];
        }) controller: self._parentController];
        
    }];
    
    
    //Add new content from downloads, or some other options (any other app that allows it)
    UITableViewRowAction* editContent = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                           title:@"Edit"
                                                                         handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self openSpecifiedNote:(uint)indexPath.row tableView:tableView];
    }];
    
    editContent.backgroundColor = [ColorHelper CardDark_ThemBackground];
    
    return @[delete, editContent];
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
    
    (*cell).textLabel.text = self._dataArray[index].Title;
    (*cell).detailTextLabel.text = self._dataArray[index].Description;
    
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
    
    notesPostController.DescriptionText = self._dataArray[index].Description;
    notesPostController._titleView.text = self._dataArray[index].Title;
    
    notesPostController.completionBlock = ^(NSString *s, NSString *e) {
        [self createNewNote:s description:e];
        
        //After adding the item, make sure to refresh the table
        [tableViewRef reloadData];
    };
    
    [self._parentController.navigationController pushViewController:notesPostController animated:true];
}

-(void) createNewNote:(NSString *)title description:(NSString *) descriptionRef {
    [self._dataArray addObject:[self notesMapper:title description:descriptionRef]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self openSpecifiedNote:(uint)indexPath.row tableView:tableView];
}

@end
