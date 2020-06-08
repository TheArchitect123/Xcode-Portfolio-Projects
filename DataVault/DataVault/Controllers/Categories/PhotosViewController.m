//
//  PhotosViewController.m
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotosDashSource.h"

//Helpers
#import "DialogHelper.h"
#import "MediaHelpers.h"
#import "SnackBarHelper.h"
#import "DateHelpers.h"

@interface PhotosViewController ()

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configurePhotosPage];
    [self configureRefreshComponent];
    [self setupOtherUIComponents];
    [self setNavigationBarComponents];
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

-(void) setupOtherUIComponents {
    
    //Bottom Bar
}

-(void) refreshItems{
    [self.tableView.refreshControl endRefreshing];
}

#pragma mark - Load the DataSource (Dashboard DataSource)
-(void) configurePhotosPage {
    
    self.DataSource = [[PhotosDashSource alloc] init];
    self.DataSource._parentController = self;
    
    self.tableView.dataSource = self.DataSource;
    self.tableView.delegate = self.DataSource;
    self.tableView.rowHeight = 100.0f;
    self.tableView.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
}

-(void) configureRefreshComponent{
    UIRefreshControl* refreshDashboard = [[UIRefreshControl alloc] init];
    [refreshDashboard addTarget:self action:@selector(refreshItems) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refreshDashboard;
}

-(void) setNavigationBarComponents{
    self.navigationController.navigationBar.backgroundColor = UIColor.lightGrayColor;
    
    //Add Option
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(promptCameraSetup)]];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    //Generate the image from the dictionary & post it to the data source
    [picker dismissViewControllerAnimated:true completion:^{
        // Edited image works great (if you allowed editing)
        [self invokeTextFunction:UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerEditedImage], 1.0f)];
        
        //                // AND the original image works great
        //        UIImage* originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        //                // AND do whatever you want with it, (NSDictionary *)info is fine now
        //        UIImage *myImage = [info objectForKey:UIImagePickerControllerEditedImage];
    }];
}

-(void) invokeTextFunction:(NSData *)imageData{
    //Generate a new photos object
    //Output some sort of text field alert dialogue
    UIAlertController* textController = [UIAlertController alertControllerWithTitle:@"Name your Photo" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [textController addTextFieldWithConfigurationHandler:nil];
    [textController addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if([textController textFields][0].text == @""){
            [self invokeTextFunction: imageData];
        }
        else {
            [self.DataSource._dataArray addObject:[self mapToDto:[textController textFields][0].text fileData:imageData created:[NSDate now] extension:@"jpg"]];
            
            [self.tableView reloadData];
        }
    }]];
    
    [textController addAction:[UIAlertAction actionWithTitle:@"Skip" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self.DataSource._dataArray addObject:[self mapToDto:@"System Created Image" fileData:imageData created:[NSDate now] extension:@"jpg"]];
        
        [self.tableView reloadData];
    }]];
    
    
    [self presentViewController:textController animated:true completion:nil];
}

-(PhotosDto *) mapToDto:(NSString *) fileName fileData:(NSData *)imageData created:(NSString *) fileCreated extension:(NSString *) fileExtension{
    PhotosDto* dto = [[PhotosDto alloc] init];
    dto.name = fileName;
    dto.data = imageData;
    dto.created = [DateHelpers getFormattedDate:fileCreated];
    dto.photoDescription = [NSString stringWithFormat:@"Photo was created on %@", dto.created];
    
    return dto;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [SnackBarHelper showSnackBarWithMessage:@"Canceled all Pending photo requests"];
}

-(void) promptCameraSetup{
    
    //Opens the bottom drawer
    NSMutableArray* actions = [[NSMutableArray alloc] initWithCapacity:2];
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Photos" image:@"Dashboard_PhotosIcon" action:(^() {
        
        [MediaHelpers takePhotoFromCamera:self];
    })]];
    
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Gallery" image:@"Dashboard_GalleryIcon" action:(^() {
        
        [MediaHelpers selectPhotoGallery:self];
    })]];
    
    [DialogHelper showActionSheetWithSimpleMessage:@"Add a photo either from the photo gallery or the camera" dialogues:actions controller:self];
}

@end
