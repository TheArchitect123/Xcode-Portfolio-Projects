//
//  VideosViewController.m
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "VideosViewController.h"
#import "VideosDashSource.h"

//Helpers
#import "DialogHelper.h"
#import "MediaHelpers.h"
#import "SnackBarHelper.h"
#import "DateHelpers.h"

@implementation VideosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureVideosPage];
    [self configureRefreshComponent];
    [self setupOtherUIComponents];
    [self setNavigationBarComponents];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self refreshItems];
}

-(void) setupOtherUIComponents {
    
    //Bottom Bar
}

-(void) refreshItems{
    [self.tableView.refreshControl beginRefreshing];
    
    [self.DataSource._dataArray removeAllObjects];
    [self.tableView reloadData];
    
    [SnackBarHelper showSnackBarWithMessage:@"Refreshing videos..."];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        //Run in background thread while a loader is showing
        
        [self.DataSource._dataArray addObjectsFromArray:[self.DataSource._dbHelper getVideosFromDb]];
        
        //[SnackBarHelper showSnackBarWithMessage:[@"Retrieved photos"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            [self.tableView.refreshControl endRefreshing];
        });
    });
    
}

#pragma mark - Load the DataSource (Dashboard DataSource)
-(void) configureVideosPage {
    
    self.DataSource = [[VideosDashSource alloc] init];
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
        [self invokeTextFunction:[NSData dataWithContentsOfURL:[info objectForKey:UIImagePickerControllerMediaURL]]];
    }];
}

-(void) invokeTextFunction:(NSData *)videoData{
    //Generate a new photos object
    //Output some sort of text field alert dialogue
    UIAlertController* textController = [UIAlertController alertControllerWithTitle:@"Name your Video" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [textController addTextFieldWithConfigurationHandler:nil];
    [textController addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if([textController textFields][0].text == @""){
            [self invokeTextFunction: videoData];
        }
        else {
            VideosDto* itemDto = [self mapToDto:[textController textFields][0].text fileData:videoData created:[NSDate date] extension:@"mp4"];
            
            [self.DataSource._dataArray addObject:itemDto];
            [self.DataSource._dbHelper createVideo:itemDto];
            
            [self.tableView reloadData];
        }
    }]];
    
    [textController addAction:[UIAlertAction actionWithTitle:@"Skip" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        VideosDto* itemDto = [self mapToDto:@"System Created Video" fileData:videoData created:[NSDate date] extension:@"mp4"];
        
        [self.DataSource._dataArray addObject:itemDto];
        [self.DataSource._dbHelper createVideo:itemDto];
        
        [self.tableView reloadData];
    }]];
    
    
    [self presentViewController:textController animated:true completion:nil];
}

-(VideosDto *) mapToDto:(NSString *) fileName fileData:(NSData *)videoData created:(NSString *) fileCreated extension:(NSString *) fileExtension{
    VideosDto* dto = [[VideosDto alloc] init];
    dto.name = fileName;
    dto.data = videoData;
    dto.created = [DateHelpers getFormattedDate:fileCreated];
    dto.videoDescription = [NSString stringWithFormat:@"Video was created on %@", dto.created];
    
    return dto;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
     [picker dismissViewControllerAnimated:true completion:^{
          [SnackBarHelper showSnackBarWithMessage:@"Canceled all Pending photo requests"];
      }];
}

-(void) promptCameraSetup{
    
    //Opens the bottom drawer
    NSMutableArray* actions = [[NSMutableArray alloc] initWithCapacity:2];
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Camera" image:@"Dashboard_VideosIcon" action:(^() {
        
        [MediaHelpers takeVideoFromCamera:self];
    })]];
    
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Gallery" image:@"Dashboard_GalleryIcon" action:(^() {
        
        [MediaHelpers selectVideoGallery:self];
    })]];
    
    [DialogHelper showActionSheetWithSimpleMessage:@"Add a video either from the photo gallery or the camera" dialogues:actions controller:self];
}

@end
