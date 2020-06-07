//
//  DashboardDataSource.m
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

//Apple
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

//Custom
#import "DashboardDataSource.h"

//Categories
#import "MusicLibraryTableViewController.h"
#import "PasswordsTableViewController.h"
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

@implementation DashboardDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        //Instantiate the Data Sources with the images required
        self._imageItems = @[@"note.png",@"document.png", @"pdf.png", @"camera.png", @"photosvids.png", @"browserhistory.png", @"emails.png", @"music.png"];
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self._imageItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *dashboardItem = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"dashItem"];
    
    [self configureTableCell:indexPath.row tableCell:&dashboardItem]; //Configure the Table Cell
    return dashboardItem;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Remove all items from the categories' cache
    UITableViewRowAction* delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                                      title:@"Clear Cache"
                                                                    handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        //Check first if the user would like to clear this cache, because this will delete all items of theirs, from the entity
        [DialogHelper showDialogueWithTopicSimpleMessageAction:@"Clear Cache" messageRef:@"This will permanantly delete all items for this category on your local database. Note: This will not affect your data on the cloud" action:(^() {
            
            //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
            
            [SnackBarHelper showSnackBarWithCustomBtnActionedMessage:[NSString stringWithFormat:@"Clearing cache for \"%@\"", [self categoryHelper:indexPath.row]] buttonTitle:@"Undo" invokedAction:(^(){
                
                [DialogHelper showDialogueWithSimpleMessage:@"Rolled back Process" controller:self._parentController];
            })];
        }) controller: self._parentController];
        
    }];
    
    
    //Add new content from downloads, or some other options (any other app that allows it)
    UITableViewRowAction* addContent = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                          title:@"Add"
                                                                        handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //Open up the notes page modally based on the category
        switch (indexPath.row) {
            case 0: //Notes
                //Opens up an action sheet with a set of options, and a small note sample to add content
                
                break;
            case 1: //Documents
                //Allows the user to select an item from the security enclave
                
                break;
            case 2: //PDFs
                break;
            case 3: //Photos
                break;
            case 4: //Videos
                break;
            case 5: //Browser History
                break;
            case 6: //Emails
                break;
            case 7: //Music & Albums
                
                //Invoke the itunes library api to manage this logic
                break;
            default:
                break;
        }
    }];
    
    addContent.backgroundColor = [ColorHelper CardDark_ThemBackground];
    
    //Synchronise items with all other items on the device
    UITableViewRowAction* synchroniseContent = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                                  title:@"Synchronise"
                                                                                handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        //Open up the notes page modally based on the category
        switch (indexPath.row) {
            case 3: //Photos
                [SnackBarHelper showSnackBarWithMessage:@"Synchronising with Photos album"];
                break;
            case 4: //Videos
                [SnackBarHelper showSnackBarWithMessage:@"Synchronising with Videos album"];
                break;
            case 5: //Browser History
                [SnackBarHelper showSnackBarWithMessage:@"Synchronising with your Browser History"];
                break;
            case 6: //Emails
                [SnackBarHelper showSnackBarWithMessage:@"Synchronising Emails"];
                break;
            case 7: //Music & Albums
                [SnackBarHelper showSnackBarWithMessage:@"Synchronising with Music Library"];
                //Invoke the itunes library api to manage this logic
                break;
            default:
                break;
        }
    }];
    
    synchroniseContent.backgroundColor = [ColorHelper DarkOrange];
    
    if(indexPath.row >= 3){
        return @[delete, addContent, synchroniseContent];
    }
    else {
        return @[delete, addContent];
    }
}

-(NSString *) categoryHelper:(uint) category {
    switch (category) {
        case 0: //Notes
            return @"Notes";
        case 1: //Documents
            return @"Documents";
        case 2: //PDFs
            return @"PDFs";
        case 3: //Photos
            return @"Photos";
        case 4: //Videos
            return @"Videos";
        case 5: //Browser History
            return @"Browser History";
        case 6: //Emails
            return @"Emails";
        case 7: //Music & Albums
            return @"Music & Albums";
        default:
            return @"";
    }
}

-(UIImage *) configureCategoryImage:(UIImage *) image{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(60.0f, 60.0f), false, 1.0f);
    [image drawInRect:CGRectMake(0, 0, 60.0f, 60.0f)];
    
    UIImage* imageFromContext = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageFromContext;
}

-(void) configureTableCell:(uint)category tableCell:(UITableViewCell**)cell{
    
    (*cell).textLabel.textColor = UIColor.blackColor;
    (*cell).detailTextLabel.textColor = UIColor.blackColor;
    
    (*cell).textLabel.font = [UIFont fontWithName:@"Roboto-Light" size:25.0f];
    (*cell).detailTextLabel.font = [UIFont fontWithName:@"Roboto-Light" size:20.0f];
    (*cell).backgroundColor = UIColor.whiteColor;
    
    //Configure Leading Icon
    (*cell).imageView.image = [self configureCategoryImage:[UIImage imageNamed:self._imageItems[category] inBundle:nil withConfiguration:nil]];
    (*cell).imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //Accessory Item
    (*cell).accessoryType = UITableViewCellAccessoryNone;
    (*cell).accessoryView = [self configureAccessoryView:@"(0)" tableCell:(*cell)]; //The Count of the Items must be passed from the controller
    
    //Ripple Effects
    //    MDCRippleTouchController *inkTouchController = [[MDCRippleTouchController alloc] initWithView:dashboardItem];
    //    [inkTouchController addRippleToView:dashboardItem];
    
    
    switch (category) {
        case 0: //Notes
            (*cell).textLabel.text = [[NSString alloc] initWithFormat:@"Notes"];
            break;
        case 1: //Documents
            (*cell).textLabel.text = [[NSString alloc] initWithFormat:@"Documents"];
            break;
        case 2: //PDFs
            (*cell).textLabel.text = [[NSString alloc] initWithFormat:@"PDFs"];
            break;
        case 3: //Photos
            (*cell).textLabel.text = [[NSString alloc] initWithFormat:@"Photos"];
            break;
        case 4: //Videos
            (*cell).textLabel.text = [[NSString alloc] initWithFormat:@"Videos"];
            break;
        case 5: //Browser History
            (*cell).textLabel.text = [[NSString alloc] initWithFormat:@"Browser History"];
            break;
        case 6: //Emails
            (*cell).textLabel.text = [[NSString alloc] initWithFormat:@"Emails"];
            break;
        case 7: //Music & Albums
            (*cell).textLabel.text = [[NSString alloc] initWithFormat:@"Music & Albums"];
            break;
        default:
            break;
    }
    
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

-(void) runNavigation:(uint)index {
    
    UIStoryboard* storyRef = [UIStoryboard storyboardWithName:@"SafetyBoxStory" bundle:nil];
    switch (index) {
        case 0: //Notes
            [self._parentController.navigationController pushViewController:[storyRef instantiateViewControllerWithIdentifier:@"NotesTableViewController"] animated:true];
            break;
        case 1: //Documents
            [self._parentController.navigationController pushViewController:[storyRef instantiateViewControllerWithIdentifier:@"DocumentsTableViewController"] animated:true];
            break;
        case 2: //PDFs
            [self._parentController.navigationController pushViewController:[storyRef instantiateViewControllerWithIdentifier:@"PDFsTableViewController"] animated:true];
            break;
        case 3: //Photos
            [self._parentController.navigationController pushViewController:[storyRef instantiateViewControllerWithIdentifier:@"PhotosVideosTableViewController"] animated:true];
            break;
        case 4: //Videos
            [self._parentController.navigationController pushViewController:[storyRef instantiateViewControllerWithIdentifier:@"PhotosVideosTableViewController"] animated:true];
            break;
        case 5: //Browser History
             [self._parentController.navigationController pushViewController:[storyRef instantiateViewControllerWithIdentifier:@"BrowserHistoryViewController"] animated:true];
            break;
        case 6: //Emails
            [self._parentController.navigationController pushViewController:[storyRef instantiateViewControllerWithIdentifier:@"EmailsTableViewController"] animated:true];
            break;
        case 7: //Music & Albums
            [self._parentController.navigationController pushViewController:[storyRef instantiateViewControllerWithIdentifier:@"MusicLibraryTableViewController"] animated:true];
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self runNavigation:(uint)indexPath.row];
}

@end
