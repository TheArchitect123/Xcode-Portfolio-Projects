//
//  DocumentsTableViewController.m
//  DataVault
//
//  Created by Assassin on 5/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "DocumentsTableViewController.h"
#import "DocumentsDashSource.h"
#import <AFURLSessionManager.h>
#import <AFNetworking/AFNetworking.h>

//Helpers
#import "DialogHelper.h"
#import "MediaHelpers.h"
#import "SnackBarHelper.h"
#import "DateHelpers.h"
#import "MimeHelper.h"

@implementation DocumentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureDocumentsPage];
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

-(void) pickImportDocument{
    [MediaHelpers takeDocumentFromLocalDevice:self];
}

-(void) refreshItems{
    [self.tableView.refreshControl endRefreshing];
}

#pragma mark - Load the DataSource (Dashboard DataSource)
-(void) configureDocumentsPage {
    
    self.DataSource = [[DocumentsDashSource alloc] init];
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
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pickImportDocument)]];
}

#pragma mark -- DocumentPicker Delegate

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
                    
                    // update UI on the main thread
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //After processing the file Data, make sure to add the item to the DocumentsDataSource collection
                        
                        DocumentsDto* dtoItem = [self mapToDto:fileName created:fileDate extension:fileExtension];
                        dtoItem.data = fileData;
                        
                        [self.DataSource._dataDocumentArray addObject:dtoItem];
                        
                        [SnackBarHelper showSnackBarWithMessage:[NSString stringWithFormat:@"Completed processing your document \"%@\"", fileName]];
                        [self.tableView reloadData]; //Make sure to reload the table view
                    });
                }];
                
                [item stopAccessingSecurityScopedResource];
            }
            else { //Non File based (Taken from the remote server)
                NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
                AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
                
                NSURLRequest *request = [NSURLRequest requestWithURL:item];
                NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
                    
                } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                    
                    if(error != nil){
                        NSLog(error.localizedDescription);
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [SnackBarHelper showSnackBarWithMessage:@"Failed to process document..."];
                        });
                    }
                    else {
                        NSLog(responseObject);
                        
                        // update UI on the main thread
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [SnackBarHelper showSnackBarWithMessage:@"Completed processing your document..."];
                            [self.tableView reloadData]; //Make sure to reload the table view
                        });
                    }
                }];
                
                [dataTask resume];
            }
        }
    });
}

-(DocumentsDto *) mapToDto:(NSString *) fileName created:(NSString *) fileCreated extension:(NSString *) fileExtension{
    DocumentsDto* dto = [[DocumentsDto alloc] init];
    dto.name = fileName;
    dto.created = [DateHelpers getFormattedDate:fileCreated];
    dto.docDescription = [NSString stringWithFormat:@"Document created on %@", dto.created];
    dto.mime = [MimeHelper getMimeOfFile:fileExtension];
    
    return dto;
}

-(void) documentPickerWasCancelled:(UIDocumentPickerViewController *)controller{
    NSLog(@"Cancelled Document Picker");
}
@end
