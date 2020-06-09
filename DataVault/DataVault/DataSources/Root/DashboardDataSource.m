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
#import <MGSwipeTableCell/MGSwipeTableCell.h>
#import <MGSwipeTableCell/MGSwipeButton.h>
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

//Roots
#import "RootTabViewController.h"
#import "RootDashboardController.h"
#import "RootSearchViewController.h"
#import "RootSettingsViewController.h"
#import "NotesPostViewController.h"

//Custom
#import "DashboardDataSource.h"

//GCD
#import <GCDObjC/GCDObjC.h>


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
#import "MediaHelpers.h"
#import "DatabaseHelper.h"

@implementation DashboardDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        //Instantiate the Data Sources with the images required
        self._imageItems = @[@"note.png",@"document.png", @"pdf.png", @"camera.png", @"photosvids.png", @"browserhistory.png", @"emails.png",  @"music.png"];
        self._dataArray = [[NSMutableArray alloc] init];
        self._dbHelper = [[DatabaseHelper alloc] init];
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self._imageItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MGSwipeTableCell *dashboardItem = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"dashItem"];
    
    [self configureTableCell:indexPath.row tableCell:&dashboardItem]; //Configure the Table Cell
    
    //Configure Right Buttons
    //dashboardItem.rightSwipeSettings.allowsButtonsWithDifferentWidth = true;
    dashboardItem.rightSwipeSettings.enableSwipeBounces = true;
    dashboardItem.rightSwipeSettings.transition = MGSwipeTransition3D;
    
    return dashboardItem;
}

#pragma mark -- POST FUNCTIONS
-(void) beginCreateNote{
    UIStoryboard* storyRef = [UIStoryboard storyboardWithName:@"SafetyBoxStory" bundle:nil];
    
    //Controllers
    NotesPostViewController *notesPostController = [storyRef instantiateViewControllerWithIdentifier:@"NotesPostViewController"];
    
    //Opens up an action sheet with a set of options, and a small note sample to add content
    notesPostController.completionBlock = ^(NSString *s, NSString *e) {
        //Take the strings from the post page, and add it to the database
        NotesDto* item = [[NotesDto alloc] init];
        item.title = s;
        item.notesDescription = e;
        
        [self._dbHelper createNote:item];
    };
    
    [self._parentController.navigationController pushViewController:notesPostController animated:true];
    
}

#pragma mark -- END OF POST FUNCTIONS

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

-(NSArray *) mediaRightButtons:(uint) category isVideo:(BOOL) isVideoRef{
    return @[[MGSwipeButton buttonWithTitle:@"Camera" backgroundColor:[ColorHelper CardDark_ThemBackground] callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
        if(isVideoRef){
            //Open up the video logic
            [MediaHelpers takeVideoFromCamera:self._parentController];
        }
        else {
            //Open up the photos logic
            [MediaHelpers takePhotoFromCamera:self._parentController];
        }
        
        return true;
    }], [MGSwipeButton buttonWithTitle:@"Gallery" backgroundColor:[ColorHelper Teal] callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
        if(isVideoRef){
            //Open up the video logic
            [MediaHelpers selectVideoGallery:self._parentController];
        }
        else{
            //Open up the photos logic
            [MediaHelpers selectPhotoGallery:self._parentController];
        }
        
        return true;
    }]];
    
//    [MGSwipeButton buttonWithTitle:@"Clear Cache" backgroundColor:UIColor.redColor callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
//
//                    //Invoke the deletion of items
//                    // Check first if the user would like to clear this cache, because this will delete all items of theirs, from the entity
//                    [DialogHelper showDialogueWithTopicSimpleMessageAction:@"Clear Cache" messageRef:@"This will permanantly delete all items for this category on your local database. Note: This will not affect your data on the cloud" action:(^() {
//
//                        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
//                        [SnackBarHelper showSnackBarWithCustomBtnActionedMessage:[NSString stringWithFormat:@"Clearing cache for \"%@\"", [self categoryHelper:category]] buttonTitle:@"Undo" invokedAction:(^(){
//
//                            [DialogHelper showDialogueWithSimpleMessage:@"Rolled back Process" controller:self._parentController];
//                        })];
//                    }) controller: self._parentController];
//
//                    return true;
//                }]
}

-(NSArray *) defaultRightButtons:(uint) category{
    return @[[MGSwipeButton buttonWithTitle:@"Add" backgroundColor:[ColorHelper CardDark_ThemBackground] callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
        
        //Open up the notes page modally based on the category
        switch (category) {
            case 0: //Notes
                [self beginCreateNote];
                break;
            case 1: //Documents
                //Allows the user to select an item from the security enclave
                [MediaHelpers takeDocumentFromLocalDevice:self._parentController];
                break;
            case 2: //PDFs
                [MediaHelpers takePDFFromLocalDevice:self._parentController];
                break;
            case 3: //Photos
                [MediaHelpers takePhotoFromCamera:self._parentController];
                break;
                case 4: //Videos
                [MediaHelpers takeVideoFromCamera:self._parentController];
                break;
            case 6: //Emails
                break;
            case 7: //Music & Albums
                
                //Invoke the itunes library api to manage this logic
                break;
            default:
                break;
        }
        
        return true;
    }]];
    
//    [MGSwipeButton buttonWithTitle:@"Clear Cache" backgroundColor:UIColor.redColor callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
//
//        //Invoke the deletion of items
//        // Check first if the user would like to clear this cache, because this will delete all items of theirs, from the entity
//        [DialogHelper showDialogueWithTopicSimpleMessageAction:@"Clear Cache" messageRef:@"This will permanantly delete all items for this category on your local database. Note: This will not affect your data on the cloud" action:(^() {
//
//            //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
//            [SnackBarHelper showSnackBarWithCustomBtnActionedMessage:[NSString stringWithFormat:@"Clearing cache for \"%@\"", [self categoryHelper:category]] buttonTitle:@"Undo" invokedAction:(^(){
//
//                [DialogHelper showDialogueWithSimpleMessage:@"Rolled back Process" controller:self._parentController];
//            })];
//        }) controller: self._parentController];
//
//        return true;
//    }]
}

-(void) configureTableCell:(uint)category tableCell:(MGSwipeTableCell**)cell{
    
    (*cell).textLabel.textColor = UIColor.blackColor;
    (*cell).detailTextLabel.textColor = UIColor.blackColor;
    
    (*cell).textLabel.font = [UIFont fontWithName:@"Roboto-Light" size:25.0f];
    (*cell).detailTextLabel.font = [UIFont fontWithName:@"Roboto-Light" size:20.0f];
    (*cell).backgroundColor = UIColor.whiteColor;
    
    //Configure Leading Icon
    (*cell).imageView.image = [self configureCategoryImage:[UIImage imageNamed:self._imageItems[category]]];
    (*cell).imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //Accessory Item
    (*cell).accessoryType = UITableViewCellAccessoryNone;
    
    if(self._dataArray.count < 8){
        (*cell).accessoryView = [self configureAccessoryView:@"(0)" tableCell:(*cell)]; //The Count of the Items must be passed from the controller
    }
    else {
    (*cell).accessoryView = [self configureAccessoryView:[NSString stringWithFormat:@"(%@)", self._dataArray[category]] tableCell:(*cell)]; //The Count of the Items must be passed from the controller
    }
    //Ripple Effects
    //    MDCRippleTouchController *inkTouchController = [[MDCRippleTouchController alloc] initWithView:dashboardItem];
    //    [inkTouchController addRippleToView:dashboardItem];
    
    if(category == 3 || category == 4){
        (*cell).rightButtons = [self mediaRightButtons:category isVideo:(category == 4)];
    }
    else {
        (*cell).rightButtons = [self defaultRightButtons:category];
    }
    
//    if(category >= 3){
//        (*cell).leftButtons = @[[MGSwipeButton buttonWithTitle:@"Synchronise" backgroundColor:[ColorHelper DarkOrange] callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
//
//            //Open up the notes page modally based on the category
//            switch (category) {
//                case 3: //Photos
//                    [SnackBarHelper showSnackBarWithMessage:@"Synchronising with Photos album"];
//                    break;
//                case 4: //Videos
//                    [SnackBarHelper showSnackBarWithMessage:@"Synchronising with Videos album"];
//                    break;
//                case 5: //Browser History
//                    [SnackBarHelper showSnackBarWithMessage:@"Synchronising with your Browser History"];
//                    break;
//                case 6: //Emails
//                    [SnackBarHelper showSnackBarWithMessage:@"Synchronising Emails"];
//                    break;
//                case 7: //Music & Albums
//                    [SnackBarHelper showSnackBarWithMessage:@"Synchronising with Music Library"];
//                    //Invoke the itunes library api to manage this logic
//                    break;
//                default:
//                    break;
//            }
//            return true;
//        }]];
//    }
//
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
            [self._parentController.navigationController pushViewController:[storyRef instantiateViewControllerWithIdentifier:@"PhotosViewController"] animated:true];
            break;
        case 4: //Videos
            [self._parentController.navigationController pushViewController:[storyRef instantiateViewControllerWithIdentifier:@"VideosViewController"] animated:true];
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
