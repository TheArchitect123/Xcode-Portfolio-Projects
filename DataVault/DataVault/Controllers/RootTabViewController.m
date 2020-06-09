//
//  RootTabViewController.m
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "RootTabViewController.h"
#import "RootDashboardController.h"
#import "RootSearchViewController.h"
#import "RootSettingsViewController.h"
#import "NotesPostViewController.h"

//Apple
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

//Helpers
#import "ScreenHelper.h"
#import "ColorHelper.h"
#import "DialogHelper.h"
#import "SnackBarHelper.h"
#import "MediaHelpers.h"
#import "DatabaseHelper.h"
#import "DateHelpers.h"
#import "MimeHelper.h"

//Dtos
#import "NotesDto.h"
#import "PhotosDto.h"
#import "VideosDto.h"
#import "BrowserHistoryDto.h"
#import "MusicAlbumsDto.h"
#import "EmailsDto.h"
#import "PDFsDto.h"
#import "DocumentsDto.h"

//Material Components
#import <MaterialComponents/MaterialBottomAppBar.h>
#import <MaterialComponents/MDCFloatingButton.h>
#import <MaterialComponents/MDCFloatingButton+MaterialTheming.h>

@implementation RootTabViewController

-(void) viewDidLoad{
    //Replace the Bottom Tab Bar with the material Bar
    
    [self configureAppBarItems];
    [self configureControllers];
    [self configureBottomBarBehaviour];
    [self setNavigationBarComponents];
    [self setupOtherUIComponents];
    
    //Load up the Database Connection
    self._dbHelper = [[DatabaseHelper alloc] init];
    
    //Check whether the device has setup iCloud storage
    // [self promptCloudStorageSetup];
}

//Each page with a table controller needs to listen for when it is selected so that it can adjust its edge insets to avoid having any issues with the margin from the navigation bar
//To SIMULATE: Press on Tab Bar from Dashboard to Search Button

-(void) enableUINotifications{
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(recreateViewsRequiredForConstraints) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

-(void) disposeUINotifications{
    [NSNotificationCenter.defaultCenter removeObserver:nil name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

-(void) viewWillAppear:(BOOL)animated{
    [self enableUINotifications];
}

-(void) viewWillDisappear:(BOOL)animated{
    
    [self disposeUINotifications];
}

-(void) recreateViewsRequiredForConstraints{
    //Refresh btn Constraints
    self._refreshFloatBtn.frame = CGRectMake(self.view.bounds.size.width - 100.0f, self.view.bounds.size.height - 160.0f, 80.0f, 80.0f);
}

-(void) setupOtherUIComponents{
    
    //Refresh Floating Button
    self._refreshFloatBtn = [[MDCFloatingButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 100.0f, self.view.bounds.size.height - 160.0f, 80.0f, 80.0f)];
    self._refreshFloatBtn.backgroundColor = [ColorHelper CardDark_ThemBackground];
    [self._refreshFloatBtn setImage:[UIImage imageNamed:@"RefreshWhite"] forState:UIControlStateNormal];
    [self._refreshFloatBtn addTarget:self action:@selector(refreshItems) forControlEvents:UIControlEventTouchDown];
    
   // [self.view addSubview:self._refreshFloatBtn];
}

-(void) configureAppBarItems{
    [self.tabBar setHidden:true];
    self._bottomNavBar = [[MDCBottomNavigationBar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 60.0f, [ScreenHelper GetScreenWidth], 60.0f)];
    self._bottomNavBar.delegate = self;
    
    [self.view addSubview:self._bottomNavBar];
}

-(void) configureBottomBarBehaviour{
    self._bottomNavBar.selectedItemTitleColor = [ColorHelper CardDark_ThemBackground];
    self._bottomNavBar.selectedItemTintColor = [ColorHelper CardDark_ThemBackground];
    
    self._bottomNavBar.elevation = 2.0f;
    self._bottomNavBar.backgroundBlurEffectStyle = UIBlurEffectStyleProminent;
    
    self._bottomNavBar.selectedItem = self.viewControllers[0].tabBarItem;
}

-(void) refreshItems{
    //Read the Dashboard Controller and refresh the items
    [self._dashboardPage refreshItems];
}

- (void)bottomNavigationBar:(MDCBottomNavigationBar *)bottomNavigationBar didSelectItem:(UITabBarItem *)item{
    //On Selection make sure to switch the active view controller
    self.selectedViewController = self.viewControllers[item.tag];
    
    if(item.tag == 0){
        [self._dashboardPage.tableView setContentInset:UIEdgeInsetsMake(0.0f, 0, 60.0f, 0)];
        [self refreshItems];
    }
}


#pragma mark Navigation Logic (Bottom Drawer, Menu Drawer for accounts)

-(void) setNavigationBarComponents{
    self.navigationController.navigationBar.backgroundColor = UIColor.lightGrayColor;
    
    //Add Option
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(promptNewContent)]];
    
    //Cloud Storage
    //    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(promptCloudStorageSetup)]];
}

-(void)promptNewContent{
    
    //Opens the bottom drawer
    NSMutableArray* actions = [[NSMutableArray alloc] initWithCapacity:5];
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Notes" image:@"Dashboard_NotesIcon" action:(^() {
        
        UIStoryboard* storyRef = [UIStoryboard storyboardWithName:@"SafetyBoxStory" bundle:nil];
        NotesPostViewController *notesPostController = [storyRef instantiateViewControllerWithIdentifier:@"NotesPostViewController"];
        
        notesPostController.completionBlock = ^(NSString *s, NSString *e) {
            //Take the strings from the post page, and add it to the database
            NotesDto* item = [[NotesDto alloc] init];
            item.title = s;
            item.notesDescription = e;
            
            [self._dbHelper createNote:item];
        };
        
        [self.navigationController pushViewController:notesPostController animated:true];
    })]];
    
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Documents" image:@"Dashboard_DocumentsIcon" action:(^() {
        
        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
        [MediaHelpers takeDocumentFromLocalDevice:self];
    })]];
    
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"PDFs" image:@"Dashboard_PDFIcon" action:(^() {
        
        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
        [MediaHelpers takePDFFromLocalDevice:self];
    })]];
    
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Photos" image:@"Dashboard_PhotosIcon" action:(^() {
        
        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
        
        [MediaHelpers takePhotoFromCamera:self];
    })]];
    
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Videos" image:@"Dashboard_VideosIcon" action:(^() {
        
        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
        [MediaHelpers takeVideoFromCamera:self];
    })]];
    
    //    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Emails" image:@"Dashboard_EmailsIcon" action:(^() {
    //
    //        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
    //    })]];
    //
    //    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Music & Albums" image:@"Dashboard_MusicIcon" action:(^() {
    //
    //        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
    //    })]];
    
    [DialogHelper showActionSheetWithSimpleMessage:@"You can add new content for the selected category by clicking on them..." dialogues:actions controller:self];
}

-(void) promptCloudStorageSetup{
    
    //Opens the bottom drawer
    NSMutableArray* actions = [[NSMutableArray alloc] initWithCapacity:3];
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Setup Microsoft OneDrive" image:@"CloudSetup_Win" action:(^() {
        
        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
    })]];
    
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Setup Google Drive" image:@"CloudSetup_Google" action:(^() {
        
        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
    })]];
    
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Setup Apple iCloud" image:@"CloudSetup_Apple" action:(^() {
        
        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
    })]];
    
    [DialogHelper showActionSheetWithSimpleMessage:@"Integrate SafetyBox with your cloud storage provider of choice" dialogues:actions controller:self];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    //Generate the image from the dictionary & post it to the data source
    [picker dismissViewControllerAnimated:true completion:^{
        // Edited image works great (if you allowed editing)
        
        //CHeck if you are dealing with a video function or photo
        NSString* item = [info objectForKey:UIImagePickerControllerMediaType];
        if([item isEqualToString:@"public.movie"]){
            [self invokeTextVideoFunction:[NSData dataWithContentsOfURL:[info objectForKey:UIImagePickerControllerMediaURL]]];
        }
        else {
            [self invokeTextPhotoFunction:UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerEditedImage], 1.0f)];
        }
        //                // AND the original image works great
        //        UIImage* originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        //                // AND do whatever you want with it, (NSDictionary *)info is fine now
        //        UIImage *myImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        [self._dashboardPage refreshItems];
    }];
}

-(void) invokeTextPhotoFunction:(NSData *)imageData{
    //Generate a new photos object
    //Output some sort of text field alert dialogue
    UIAlertController* textController = [UIAlertController alertControllerWithTitle:@"Name your Photo" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [textController addTextFieldWithConfigurationHandler:nil];
    [textController addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if([[textController textFields][0].text isEqualToString:@""]){
            [self invokeTextPhotoFunction: imageData];
        }
        else {
            PhotosDto* itemDto = [self mapToPhotosDto:[textController textFields][0].text fileData:imageData created:[NSDate date] extension:@"jpg"];
            
            [self._dbHelper createPhoto:itemDto];
            [self._dashboardPage refreshItems];
        }
    }]];
    
    [textController addAction:[UIAlertAction actionWithTitle:@"Skip" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        PhotosDto* itemDtoDef = [self mapToPhotosDto:@"System Created Image" fileData:imageData created:[NSDate date] extension:@"jpg"];
        
        [self._dbHelper createPhoto:itemDtoDef];
        [self._dashboardPage refreshItems];
    }]];
    
    
    [self presentViewController:textController animated:true completion:nil];
}

-(void) invokeTextVideoFunction:(NSData *)videoData{
    //Generate a new photos object
    //Output some sort of text field alert dialogue
    UIAlertController* textController = [UIAlertController alertControllerWithTitle:@"Name your Video" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [textController addTextFieldWithConfigurationHandler:nil];
    [textController addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if([textController textFields][0].text == @""){
            [self invokeTextVideoFunction: videoData];
        }
        else {
            VideosDto* itemDto = [self mapToVideoDto:[textController textFields][0].text fileData:videoData created:[NSDate date] extension:@"mp4"];
            
            [self._dbHelper createVideo:itemDto];
            [self._dashboardPage refreshItems];
        }
    }]];
    
    [textController addAction:[UIAlertAction actionWithTitle:@"Skip" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        VideosDto* itemDto = [self mapToVideoDto:@"System Created Video" fileData:videoData created:[NSDate date] extension:@"mp4"];
        
        [self._dbHelper createVideo:itemDto];
        [self._dashboardPage refreshItems];
    }]];
    
    
    [self presentViewController:textController animated:true completion:nil];
}


//Image Pickers
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
     [picker dismissViewControllerAnimated:true completion:^{
          [SnackBarHelper showSnackBarWithMessage:@"Canceled all Pending photo requests"];
      }];
}

-(void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls{
    
    if(urls.count > 1){
        [SnackBarHelper showSnackBarWithMessage:@"Processing your documents. This should only take a few seconds..."];
    }
    else if(urls.count == 1) {
        [SnackBarHelper showSnackBarWithMessage:@"Processing your document. This should only take a few seconds..."];
    }
    
    //When selecting a document, the user will be able to add an item directly into the data array of the data source, which will in turn add the items to the database
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Add the data items to the database
        for(NSURL* item in urls){
            
            if(item.isFileURL){
                //Change the session configuration to be able to read file
                
                [item startAccessingSecurityScopedResource];
                NSFileCoordinator *coordinator = [[NSFileCoordinator alloc] init];
                NSError *error = nil;
                __block NSData *fileData;
                
                [coordinator coordinateReadingItemAtURL:item options:NSFileCoordinatorReadingForUploading error:&error byAccessor:^(NSURL *newURL) {
                    // File name for use in writing the file out later
                    NSString *fileName = [newURL lastPathComponent];
                    
                    //Based on the file extension, make sure to commit the Mime of the document
                    NSString *fileExtension = [newURL pathExtension];
                    
                    NSDate *fileDate;
                    NSError *errorDate = nil;
                    [newURL getResourceValue:&fileDate forKey:NSURLContentModificationDateKey error:&errorDate];
                    
                    //                   if([fileExtension isEqualToString:@"zip"]) {
                    //                     if([[[newURL URLByDeletingPathExtension] pathExtension] isEqualToString:@"pages"] ||
                    //                        [[[newURL URLByDeletingPathExtension] pathExtension] isEqualToString:@"numbers"] ||
                    //                        [[[newURL URLByDeletingPathExtension] pathExtension] isEqualToString:@"key"] ) {
                    //                       // Remove .zip if it is an iWork file
                    //                       fileExtension = [[newURL URLByDeletingPathExtension] pathExtension];
                    //                       fileName = [[newURL URLByDeletingPathExtension] lastPathComponent];
                    //                     }
                    //                   }
                    
                    NSError *fileConversionError;
                    fileData = [NSData dataWithContentsOfURL:newURL options:NSDataReadingUncached error:&fileConversionError];
                    
                    if(![fileExtension isEqualToString:@"pdf"]){
                        DocumentsDto* dtoItem = [self mapToDocDto:fileName created:fileDate extension:fileExtension data:fileData];
                        
                        [self._dbHelper createDocument:dtoItem];
                        // update UI on the main thread
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //After processing the file Data, make sure to add the item to the DocumentsDataSource collection
                            [SnackBarHelper showSnackBarWithMessage:[NSString stringWithFormat:@"Completed processing your document \"%@\"", fileName]];

                            [self._dashboardPage refreshItems];
                        });
                    }
                    else {
                        PDFsDto* dtoItem = [self mapToPDFsDto:fileName created:fileDate extension:fileExtension];
                        dtoItem.data = fileData;
                        
                        [self._dbHelper createPDFs:dtoItem];
                        // update UI on the main thread
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //After processing the file Data, make sure to add the item to the DocumentsDataSource collection
                            [SnackBarHelper showSnackBarWithMessage:[NSString stringWithFormat:@"Completed processing your pdf \"%@\"", fileName]];
                            
                            [self._dashboardPage refreshItems];
                        });
                    }
                }];
                
                [item stopAccessingSecurityScopedResource];
            }
        }
    });
}

-(DocumentsDto *) mapToDocDto:(NSString *) fileName created:(NSString *) fileCreated extension:(NSString *) fileExtension data:(NSData *)dataRef{
    DocumentsDto* dto = [[DocumentsDto alloc] init];
    dto.name = fileName;
    dto.created = [DateHelpers getFormattedDate:fileCreated];
    dto.docDescription = [NSString stringWithFormat:@"Document created on %@", dto.created];
    dto.data = dataRef;
    
    dto.mime = [MimeHelper getMimeOfFile:fileExtension];
    
    return dto;
}

-(PDFsDto *) mapToPDFsDto:(NSString *) fileName created:(NSString *) fileCreated extension:(NSString *) fileExtension{
    PDFsDto* dto = [[PDFsDto alloc] init];
    dto.name = fileName;
    dto.created = [DateHelpers getFormattedDate:fileCreated];
    dto.smallDescription = [NSString stringWithFormat:@"PDF created on %@", dto.created];
    
    return dto;
}

-(PhotosDto *) mapToPhotosDto:(NSString *) fileName fileData:(NSData *)imageData created:(NSString *) fileCreated extension:(NSString *) fileExtension{
    PhotosDto* dto = [[PhotosDto alloc] init];
    dto.name = fileName;
    dto.data = imageData;
    dto.created = [DateHelpers getFormattedDate:fileCreated];
    dto.photoDescription = [NSString stringWithFormat:@"Photo was created on %@", dto.created];
    
    return dto;
}

-(VideosDto *) mapToVideoDto:(NSString *) fileName fileData:(NSData *)videoData created:(NSString *) fileCreated extension:(NSString *) fileExtension{
    VideosDto* dto = [[VideosDto alloc] init];
    dto.name = fileName;
    dto.data = videoData;
    dto.created = [DateHelpers getFormattedDate:fileCreated];
    dto.videoDescription = [NSString stringWithFormat:@"Video was created on %@", dto.created];
    
    return dto;
}

-(void) configureControllers{
    
    UIStoryboard* storyMngr = [UIStoryboard storyboardWithName:@"SafetyBoxStory" bundle:nil];
    
    self._dashboardPage = [storyMngr instantiateViewControllerWithIdentifier:@"RootDashboardController"];
    self._dashboardPage.tabBarItem.title = @"Dashboard";
    self._dashboardPage.tabBarItem.image = [UIImage imageNamed:@"DashboardTab"];
    self._dashboardPage.tabBarItem.tag = 0;
    
    
    
    //    self._searchPage = [storyMngr instantiateViewControllerWithIdentifier:@"RootSearchViewController"];
    //    self._searchPage.tabBarItem.title = @"Search";
    //    self._searchPage.tabBarItem.image = [UIImage imageNamed:@"SearchTab"];
    //    self._searchPage.tabBarItem.tag = 1;
    //
    self._settingsPage = [storyMngr instantiateViewControllerWithIdentifier:@"RootSettingsViewController"];
    self._settingsPage.tabBarItem.title = @"Settings";
    self._settingsPage.tabBarItem.image = [UIImage imageNamed:@"SettingsTab"];
    self._settingsPage.tabBarItem.tag = 1;
    
    
    //Set the Tabs
    self._bottomNavBar.items = [[NSArray alloc] initWithObjects:self._dashboardPage.tabBarItem,  self._settingsPage.tabBarItem, nil];
    self.viewControllers = [[NSArray alloc] initWithObjects:self._dashboardPage, self._settingsPage, nil];
}

@end
