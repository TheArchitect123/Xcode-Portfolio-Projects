//
//  DocumentsDashSource.m
//  DataVault
//
//  Created by Assassin on 5/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "DocumentsDashSource.h"

//Apple
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

//Custom
#import "DocumentsDataArray.h"

//Dto
#import "DocumentsDto.h"

//Material
#import <MaterialComponents/MaterialRipple.h>

//Helpers
#import "ColorHelper.h"
#import "DialogHelper.h"
#import "SnackBarHelper.h"

@implementation DocumentsDashSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self._dataDocumentArray = [[NSMutableArray alloc] init];
//        [self._dataDocumentArray addObject:[self documentMapper:@"Sample note" description:@"this is a very long description labeled, write here, amongst the notes"]];
//        [self._dataDocumentArray addObject:[self documentMapper:@"Broken note" description:@"sample description"]];
//        [self._dataDocumentArray addObject:[self documentMapper:@"MAHAHAAH!" description:@"this is another sample description"]];
    }
    return self;
}

-(DocumentsDto *) documentMapper:(NSString *) title  description:(NSString *) descriptionRef{
    DocumentsDto* item = [[DocumentsDto alloc] init];
    item.name = title;
    item.docDescription = descriptionRef;
    
    return item;
}
         
         

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self._dataDocumentArray.count;
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
        
        //[self openSpecifiedNote:(uint)indexPath.row tableView:tableView];
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
    
    //Configure Leading Icon
    (*cell).imageView.image = [self configureCategoryImage:[UIImage imageWithData:self._dataDocumentArray[index].data]];
    (*cell).imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    // (*cell).accessoryView = [self configureAccessoryView:@"(0)" tableCell:(*cell)]; //The Count of the Items must be passed from the controller
    
    (*cell).textLabel.text = self._dataDocumentArray[index].name;
    (*cell).detailTextLabel.text = self._dataDocumentArray[index].docDescription;
//    
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

-(void) openSpecifiedDocument:(uint)index tableView:(UITableView *)tableViewRef {
    
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}



@end
