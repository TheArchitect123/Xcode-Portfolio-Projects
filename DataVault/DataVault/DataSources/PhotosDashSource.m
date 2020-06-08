//
//  PhotosDashSource.m
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "PhotosDashSource.h"


//Apple
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

//Custom
#import "PhotosDataArray.h"
#import "AMPPreviewController.h"

//Dto
#import "PhotosDto.h"

//Material
#import <MGSwipeTableCell/MGSwipeTableCell.h>
#import <MGSwipeTableCell/MGSwipeButton.h>

//Helpers
#import "ColorHelper.h"
#import "DialogHelper.h"
#import "SnackBarHelper.h"
#import "MimeHelper.h"


@implementation PhotosDashSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self._dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self._dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MGSwipeTableCell *photosItem = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"photosItem"];
    
    [self configureTableCell:indexPath.row tableCell:&photosItem]; //Configure the Table Cell
    
    //Configure Right Buttons
    photosItem.rightSwipeSettings.allowsButtonsWithDifferentWidth = true;
    photosItem.rightSwipeSettings.enableSwipeBounces = true;
    photosItem.rightSwipeSettings.transition = MGSwipeTransition3D;
    photosItem.rightButtons = [self defaultRightButtons:indexPath.row tableView:tableView];
    
    return photosItem;
}

-(UIImage *) configureCategoryImage:(UIImage *) image{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(60.0f, 60.0f), false, 1.0f);
    [image drawInRect:CGRectMake(0, 0, 60.0f, 60.0f)];
    
    UIImage* imageFromContext = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageFromContext;
}

-(NSArray *) defaultRightButtons:(uint) index tableView:(UITableView *) tableViewRef{
    return @[[MGSwipeButton buttonWithTitle:@"View" backgroundColor:[ColorHelper CardDark_ThemBackground] callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
        
        [self openSpecifiedPhoto:index tableView:tableViewRef];
        return true;
    }], [MGSwipeButton buttonWithTitle:@"Delete" backgroundColor:UIColor.redColor callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
        
        //Check first if the user would like to clear this cache, because this will delete all items of theirs, from the entity
               [DialogHelper showDialogueWithTopicSimpleMessageAction:@"Remove Document" messageRef:@"This will permanantly delete this item from your local database. Note: This will not affect your data on the cloud" action:(^() {
                   
                   //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
                   
                   [SnackBarHelper showSnackBarWithCustomBtnActionedMessage:[NSString stringWithFormat:@"Removing item \"%@\"", self._dataArray[index]] buttonTitle:@"Undo" invokedAction:(^(){
                       
                       [DialogHelper showDialogueWithSimpleMessage:@"Rolled back Process" controller:self._parentController];
                   })];
               }) controller: self._parentController];
        return true;
    }]];
}

-(void) configureTableCell:(uint)index tableCell:(UITableViewCell**)cell{
    
    (*cell).textLabel.textColor = UIColor.blackColor;
    (*cell).detailTextLabel.textColor = UIColor.blackColor;
    
    (*cell).textLabel.font = [UIFont fontWithName:@"Roboto-Light" size:25.0f];
    (*cell).detailTextLabel.font = [UIFont fontWithName:@"Roboto-Light" size:20.0f];
    (*cell).backgroundColor = UIColor.whiteColor;
    
    //Accessory Item
    (*cell).accessoryType = UITableViewCellAccessoryNone;
    
    //(*cell).accessoryView = [self configureAccessoryView:self._dataDocumentArray[index].created tableCell:(*cell)]; //The Count of the Items must be passed from the controller
    
    (*cell).textLabel.text = self._dataArray[index].name;
    (*cell).detailTextLabel.text = self._dataArray[index].photoDescription;
    
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

-(void) openSpecifiedPhoto:(uint)index tableView:(UITableView *)tableViewRef {
    
    //Opens up the modal dialogue of the note, allowing the user to edit it.
    //This will make an upload to the cloud, while also updating the items on the local database
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        // Generate the file path
        NSString* tempFileName = @"/SafetyBox/tempfileName.jpg";
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *dataPath = [NSString stringWithFormat:@"%@",[documentsDirectory stringByAppendingPathComponent:tempFileName]];
        
        // Save it into file system
    //    if([NSFileManager.defaultManager fileExistsAtPath:dataPath isDirectory:false])
        NSError* error = nil;
        [NSFileManager.defaultManager createDirectoryAtPath:[documentsDirectory stringByAppendingPathComponent:@"SafetyBox"] withIntermediateDirectories:true attributes:nil error:&error];
        [NSFileManager.defaultManager createFileAtPath:dataPath contents:self._dataArray[index].data attributes:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            AMPPreviewController *previewController = [[AMPPreviewController alloc] initWithFilePath:[NSURL fileURLWithPath:dataPath]];
            [previewController.navigationController.navigationItem setTitle:self._dataArray[index].name];
            [self._parentController presentViewController:previewController animated:true completion:nil];
        });
    });
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    [self openSpecifiedPhoto:indexPath.row tableView:tableView];
}
@end
